
#include "llvm/ADT/Statistic.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/RegAllocRegistry.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/Target/TargetFrameLowering.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/AllocationOrder.h"
#include "llvm/Target/TargetSubtargetInfo.h"
#include "llvm/CodeGen/RegisterClassInfo.h"
#include "llvm/Target/TargetInstrInfo.h"
//#include "llvm/Target/TargetTargetInfo.h"
#include "llvm/CodeGen/LiveIntervalAnalysis.h"
#include "llvm/CodeGen/LiveRegMatrix.h"
#include "llvm/CodeGen/VirtRegMap.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineOperand.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/RegisterClassInfo.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/PassAnalysisSupport.h"

#include "llvm/Target/TargetMachine.h"

#include <map>
#include <set>

#include <algorithm>
#include <vector>

#define DEBUG_TYPE "chaitin-briggs"

using namespace llvm;

namespace llvm {
  FunctionPass *createChaitin();
}
STATISTIC(NumOfLoads_Chaitin, "The # of added load spill instructions");
STATISTIC(NumOfStores_Chaitin, "The # of added store spill instructions");
static RegisterRegAlloc chaitinBriggs("chaitin-briggs",
                                      "chaitin-briggs style coloring-based register Chaitin",
                                      createChaitin);

namespace {
    // a node within interference graph
    struct VirtualRegister {
        // vector of register/node indices (not registers!)
        SmallVector<unsigned, 8> Interfered;
        
        // id of this virtual register
        unsigned VirtReg;
        
        // number of register interfering with this virtual register
        unsigned Degree;
        
        // if the register is cloberred by any instructions
        bool Clobbered;
        
        VirtualRegister(): Degree(0), Clobbered(false) {}
    };
    
    // interference graph of virtual registers
    class IntGraph {
    private:
        // adjacency matrix
        bool **Mat;
        typedef VirtualRegister Node;
        // 8 general purpose registers minus stack and frame pointer
        static const unsigned K = 6;
        
        // number of nodes in the graph
        unsigned NumNodes;
        
        // nodes in the graph
        std::vector<Node> Nodes;
        
        // TODO use denseset for all sets
        // nodes of low degrees (< k)
        std::set<unsigned> Low;
        // nodes of high degrees (>= k)
        std::set<unsigned> High;
        
    public:
        IntGraph(unsigned N): NumNodes(N) {
            Nodes.resize(NumNodes);

            Mat = new bool*[N];
            for (unsigned i = 0; i < N; i++) {
                Mat[i] = new bool[N];
            }

            for (unsigned i = 0; i < NumNodes; i++) {
                Nodes[i].VirtReg = TargetRegisterInfo::index2VirtReg(i);
            }
        };
        
        ~IntGraph() {
            for (unsigned i = 0; i < NumNodes; i++) {
                delete[] Mat[i];
            }
            delete[] Mat;
        }
        
        // add an edge to the graph
        void addEdge(unsigned Idx1, unsigned Idx2) {
            if (Mat[Idx1][Idx2]) return;
            
            Node& V = Nodes[Idx1];
            Node& W = Nodes[Idx2];
            V.Interfered.push_back(Idx2);
            W.Interfered.push_back(Idx1);
            V.Degree++;
            W.Degree++;
            
            Mat[Idx1][Idx2] = Mat[Idx2][Idx1] = true;
        }
        
        Node& getNode(unsigned Idx) { return Nodes[Idx]; }
        
        unsigned getNumNodes() const { return NumNodes; }
        
        // return everything within high sets
        std::set<unsigned>& getHighs() { return High; }
        
        // separate nodes in the graph into low and high sets
        void sepByDegrees() {
            assert(Low.empty());
            assert(High.empty());
            
            for (unsigned i = 0; i < NumNodes; i++) {
                Node& N = Nodes[i];
                if (N.Degree < K) {
                    Low.insert(i);
                } else {
                    High.insert(i);
                }
            }
            
            errs() << "Interference Graph ("<<NumNodes<<") has " << Low.size() << " low nodes, and " << High.size() << " high nodes\n";
        }
        
        // check if the graph has at least one low degree node
        bool hasLow() const { return !Low.empty(); }
        
        // return an arbitrary node from low set
        unsigned getOneLow() const { return *Low.begin(); }
        
        // remove a node
        void remove(unsigned Idx) {
            NumNodes--;
            
            if (Low.find(Idx) != Low.end()) { // in low set
                Low.erase(Idx);
            } else { // in high set
                High.erase(Idx);
            }
            
            Node& N = Nodes[Idx];
            // iterate over its neighbors, whose degree should be decremented by one,
            // and update high and low set
            for (unsigned IntIdx: N.Interfered) {
                Node& Interfered = Nodes[IntIdx];
                // we can move nodes originally in high set to low set now
                if (Interfered.Degree-- == K && High.erase(IntIdx)) {
                    Low.insert(IntIdx);
                }
            }
        }
        
    }; // end of interference graph
    
    class Chaitin : public MachineFunctionPass {
    public:
        Chaitin();
        
        void releaseMemory() override {};
        const char* getPassName() const override { return "Chaitin-Briggs style Chaitin"; }
        
        /// SpillAll analysis usage.
        void getAnalysisUsage(AnalysisUsage &AU) const override;
        
        /// Perform register allocation.
        bool runOnMachineFunction(MachineFunction &mf) override;
        
        static char ID;
        
    private:
        // maping clobbered physical register -> its saving slot
        std::map<unsigned, int> SavingSlots;
        typedef std::set<unsigned> VirtRegSet;
        std::map<MachineBasicBlock*, VirtRegSet> In, Out, Gen, Kill, Def, Ref;
        VirtRegSet Global;
        
        void init(MachineFunctionPass *Pass, MachineFunction *mf);
        // simplify the `IG`'s nodes on to `Stack`
        void simplify(IntGraph& IG, std::vector<unsigned>& Stack) {
            outs() << "simplifying\n";
            while (IG.getNumNodes() > 0) {
                // remove a low degree node if there's any
                // select a high degree node, which we will potentially spill
                unsigned Idx = IG.hasLow() ? IG.getOneLow() : chooseSpillCandidate(IG.getHighs());
                IG.remove(Idx);
                Stack.push_back(Idx);
            }
        }
        
        // assign physical registers to virtual registers on `Stack` or spill
        // `Stack` is a vector of node/register indices
        // `Spilled` is a vector of virtual register (not node or register indices)
        void select(IntGraph& IG, std::vector<unsigned>& Stack, std::vector<unsigned>& Spilled) {
            outs() << "selecting\n";
            while (!Stack.empty()) {
                unsigned Idx = Stack.back();
                VirtualRegister& Reg = IG.getNode(Idx);
                Stack.pop_back();
                unsigned PhysReg = selectPhysReg(Reg.VirtReg, &Reg.Clobbered);
                if (!PhysReg) {
                    outs() << "have one to spill-----------------------------------------------------------\n";
                    // have to spill this register
                    Spilled.push_back(Reg.VirtReg);
                }
            }
            outs() << "reaching 1\n";
            
        }
        
        // liveness analysis
        void buildReachingDefinitions();
        void buildLiveIntervals();
        
        // similar to `getStackSlot`
        int getStackSlotForRegSaving(unsigned PhysReg, const TargetRegisterClass *RC);
        
        // rewirte machine function to spill registers
        // this function should also re-run required analysis after changing the machine function
        void rewriteToSpill(std::vector<unsigned>& Spilled);
        
        unsigned chooseSpillCandidate(std::set<unsigned>& Cands);
        
        // populate an interference graph with interference edges
        void populateGraph(IntGraph&);
        
        // create a mapping from clobbering instruction to cloberred physical instructions
        void findClobbered(IntGraph&, std::multimap<MachineInstr *, unsigned>&);

        // check if we can assign virtreg to physreg with causing interference
        bool canAssignPhys(LiveInterval& VirtReg, unsigned PhysReg);

                // context
        MachineFunction *MF;
        
        // utility data structure
        LiveRegMatrix *Mat;
        VirtRegMap *VRM;
        LiveIntervals *LIS;
        const TargetRegisterInfo *TRI;
        RegisterClassInfo RegClassInfo;
        std::map<unsigned, int> VirtReg2FrameIdx;
        const TargetMachine *TM;
        
        // check if a machine operand is virtual register
        bool isVirtReg(MachineOperand& MO) {
            return MO.isReg() && MO.getReg() &&
            TargetRegisterInfo::isVirtualRegister(MO.getReg());
        }
        
        // get get a spill slot for a virtual register
        int getStackSlot(unsigned VirtReg, const TargetRegisterClass* RC);
        
        // get a an available physical register for a virtual register
        unsigned selectPhysReg(unsigned VirtReg, bool *Cloberred=nullptr);
        
        // replace a virtual register with a physical register
        bool setReg(MachineOperand& MO, unsigned PhysReg);
    };
    
    char Chaitin::ID = 0;
} // end of anonymous namespace

int Chaitin::getStackSlotForRegSaving(unsigned PhysReg, const TargetRegisterClass *RC)
{
    bool Allocated = SavingSlots.find(PhysReg) != SavingSlots.end();
    if (Allocated) {
        return SavingSlots[PhysReg];
    }
    
    const TargetFrameLowering *TFI = MF->getTarget().getFrameLowering();
    
    unsigned StackAlign = TFI->getStackAlignment(),
    ObjAlign = RC->getAlignment(),
    Align = std::min(StackAlign, ObjAlign);
    
    int FI = MF->getFrameInfo()->CreateStackObject(RC->getSize(), Align, true);
    SavingSlots[PhysReg] = FI;
    
    return FI;
}

// this should be called after every virtual registers are assigned a physical register
// this should only be called ONCE during register allocation, right before we
// rewrite the machine function to use physical registers
void Chaitin::findClobbered(IntGraph& IG, std::multimap<MachineInstr *, unsigned>& ClobberedMap)
{
    // collect clobbered intervals
    SmallVector<VirtualRegister *, 4> Clobbered;
    unsigned NumNodes = MF->getRegInfo().getNumVirtRegs();
    for (unsigned i = 0; i < NumNodes; i++) {
        VirtualRegister& Reg = IG.getNode(i);
        if (Reg.Clobbered) Clobbered.push_back(&Reg);
    }
    
    errs() << Clobbered.size() << " virtual registers are clobbered\n";
    
    SlotIndexes *Indexes = LIS->getSlotIndexes();
    ArrayRef<SlotIndex> ClobberedSlots = LIS->getRegMaskSlots();
    
    for (SlotIndex Slot : ClobberedSlots) {
        MachineInstr *MI = Indexes->getInstructionFromIndex(Slot);
        
        for (VirtualRegister* Reg : Clobbered) {
            LiveInterval& LI = LIS->getInterval(Reg->VirtReg);
            if (LI.overlaps(Slot, Slot.getNextSlot())) {
                // `Reg` is clobbered by `MI`
                unsigned PhysReg = VRM->getPhys(Reg->VirtReg);
                ClobberedMap.insert(
                                    std::pair<MachineInstr *, unsigned>(MI, PhysReg));
            }
        }
        
    }
}

// TODO
// use a more effective spill metrics
unsigned Chaitin::chooseSpillCandidate(std::set<unsigned>& Cands)
{
    // return an arbitrary high degree node
    return *Cands.begin();
}

void Chaitin::populateGraph(IntGraph& IG)
{
    buildLiveIntervals();
    std::vector<unsigned> Nodes;
    
    for (auto Pair: Out) {
        VirtRegSet& OutSet = Pair.second;
        Nodes.resize(0);
        
        for (unsigned Reg: OutSet) {
            unsigned V = TargetRegisterInfo::virtReg2Index(Reg);
            for (unsigned W: Nodes) {
                IG.addEdge(V, W);
            }
            Nodes.push_back(V);
        }
    }
    IG.sepByDegrees();
}

void Chaitin::rewriteToSpill(std::vector<unsigned>& Spilled)
{
    errs() << "rewrite function with virtual spills (" << Spilled.size() << ")\n";
    // sort `Spilled` so that we can use it as a set
    // with binary search
    std::sort(Spilled.begin(), Spilled.end());
    
    MachineRegisterInfo& MRI = MF->getRegInfo();
    const TargetInstrInfo *TII = MF->getTarget().getInstrInfo();
    
    for (MachineBasicBlock& MB : *MF) {
        for (auto MII = MB.begin(); MII != MB.end(); ++MII) {
            unsigned NumOperands = MII->getNumOperands();
            // use this for inserting store for spilling
            auto NextInst = MII;
            ++NextInst;
            
            for (unsigned i = 0; i < NumOperands; i++) {
                MachineOperand& MO = MII->getOperand(i);
                if (!isVirtReg(MO)) continue;
                
                unsigned VirtReg = MO.getReg();
                // skip if the virtual register is not in the spill list
                if (!std::binary_search(Spilled.begin(), Spilled.end(), VirtReg))
                    continue;
                
                bool IsDef = MO.isDef(), IsUse = MO.isUse();
                
                // allocate stack space to spill
                const TargetRegisterClass *RC = MRI.getRegClass(VirtReg);
                int FI = getStackSlot(VirtReg, RC);
                assert(IsDef || IsUse);
                // use a new temporary virtual register to do the spilling
                unsigned Temp = MRI.createVirtualRegister(RC);
                if (!VRM->hasPhys(VirtReg)) outs() << VirtReg << "don't has phys!\n";
                //unsigned Temp = VRM->getPhys(VirtReg);
                // insert a load before use and store after use

                if (IsDef) {
                    TII->storeRegToStackSlot(MB, NextInst, Temp, true, FI, RC, TRI);
                    NumOfStores_Chaitin++;
                }
                if (IsUse) {
                    TII->loadRegFromStackSlot(MB, MII, Temp, FI, RC, TRI);
                    NumOfLoads_Chaitin++;
                }

                
                MO.setReg(Temp);
            }
        }
    }

    if (!Spilled.empty()) {
        // having rewritten the machine function to spill,
        // we need to re-run these analysis
        errs() << "Recomputing live intervals after spilling.\n";

        VRM = getAnalysisIfAvailable<VirtRegMap>();
        //VRM->runOnMachineFunction(*MF);
        VRM->grow();
        VRM->print(outs());
        assert(VRM && "Unable to recompute VirtRegMap");
        Mat = getAnalysisIfAvailable<LiveRegMatrix>();
        assert(Mat && "Unable to recompute LiveRegMatrix");
        LIS = getAnalysisIfAvailable<LiveIntervals>();
        //LIS->runOnMachineFunction(*MF);
        assert(LIS && "Unable to recompute LiveIntervals");
    }
}

bool Chaitin::runOnMachineFunction(MachineFunction &mf)
{
    DEBUG(dbgs() << "********** SPILL ALL ALLOCATION **********\n"
          << "********** Function: "
          << mf.getName() << '\n');
    
    // init for Chaitin
    init(this, &mf);
    SavingSlots.clear();
    
    // stack used for chaitin's graph coloring algorithm
    std::vector<unsigned> Stack;
    std::vector<unsigned> Spilled;
    // mapping cloberring instructions (e.g. call) -> clobbered virtual registers
    std::multimap<MachineInstr *, unsigned> Clobbered;
    for (;;) {
        //VRM->grow();
        errs() << "Running Chaitin-Briggs\n";
        Spilled.resize(0);
        Stack.resize(0);

        unsigned numVirtRegs = MF->getRegInfo().getNumVirtRegs();
        IntGraph IG(numVirtRegs);
        // populate graph with edges (pairs of interfering virtual registers)
        populateGraph(IG);
        simplify(IG, Stack);
        select(IG, Stack, Spilled);
        rewriteToSpill(Spilled);
                    outs() << "spilled size is : " << Spilled.size() << "\n";
        if (Spilled.empty()) {

            findClobbered(IG, Clobbered);
            break;
        }

    };
    
    // now we have a physical register for every virtual register
    errs() << "Finished register allocation, rewriting function to use physical registers.\n";
    const TargetInstrInfo *TII = MF->getTarget().getInstrInfo();
    
    // rewrite machine function
    for (MachineBasicBlock& MB: *MF) {
        for (auto MBI = MB.begin(); MBI != MB.end(); ++MBI) {
            
            MachineInstr& MI = *MBI;
            
            auto NextInst = MBI;
            ++NextInst; 
            // iterate over every physical clobbered by `MI`
            auto ret = Clobbered.equal_range(&MI); 
            for (auto It = ret.first; It != ret.second; ++It) {
                // PhysReg clobbered by MI
                unsigned PhysReg = It->second; 
                
                // allocate saving space
                const TargetRegisterClass *RC = TRI->getMinimalPhysRegClass(PhysReg);
                int FI = getStackSlotForRegSaving(PhysReg, RC);
                
                // insert a store before the instruction and a load after
                TII->storeRegToStackSlot(MB, MBI, PhysReg, true, FI, RC, TRI); 
                TII->loadRegFromStackSlot(MB, NextInst, PhysReg, FI, RC, TRI);
                NumOfLoads_Chaitin++;
                NumOfStores_Chaitin++;
            }
            
            // replace every virtual register with assigned physical register
            unsigned NumOperands = MI.getNumOperands();
            for (unsigned i = 0; i < NumOperands; i++) {
                MachineOperand& MO = MI.getOperand(i);
                if (!isVirtReg(MO)) continue;
                
                unsigned PhysReg = VRM->getPhys(MO.getReg());
                assert(PhysReg && "VRM got amnesia");
                setReg(MO, PhysReg); 
            }
        }
    } 

    return true;
}

void Chaitin::buildReachingDefinitions()
{
    In.clear();
    Out.clear();
    Gen.clear();
    Kill.clear();
    // populate Gen and Kill sets
    for (auto &MB : * MF) {
        
        for (auto &MI : MB) {
            unsigned NumOperands = MI.getNumOperands();
            for (unsigned i = 0; i < NumOperands; i++) {
                MachineOperand &MO = MI.getOperand(i);
                if (!isVirtReg(MO)) {
                    continue;
                }
                unsigned VirtReg = MO.getReg();
                if (MO.isDef() && !MO.isKill()) {
                    Gen[&MB].insert(VirtReg);
                }
                if (MO.isKill()) {
                    Gen[&MB].erase(VirtReg);
                    Kill[&MB].insert(VirtReg);
                }
                
            }
            
        }
        Out[&MB] = Gen[&MB];
    }
    
    bool Changed = false;
    do {
        for (auto &MB : *MF)
        {
            unsigned In_size = In.size(), Out_size = Out.size();
            // in[b] = union out[p] for every p in predecessors[b]
            for (MachineBasicBlock *Pred : MB.predecessors()) {
                for (unsigned VirtReg : Out[Pred]) {
                    In[&MB].insert(VirtReg);
                }
            }
            // Out[B] = Gen[B] union (In[B] - Kill[B]
            for (unsigned VirtReg : In[&MB]) {
                VirtRegSet &Killed = Kill[&MB];
                if (Killed.find(VirtReg) == Killed.end()) {
                    Out[&MB].insert(VirtReg);
                }
            }
            
            Changed = (In.size() != In_size ||
                       Out.size() != Out_size);
        }
    }
    while(Changed);
}


void Chaitin::buildLiveIntervals()
{
    In.clear();
    Out.clear();
    Gen.clear(); //  set of variables that are used in basic block before any assignment.
    Kill.clear(); // set of variables that are assigned a value in basic block
    // build gobal set
   /* Global.clear();
    for (auto &MB : * MF) {
        for (auto &MI: MB) {
            unsigned NumOperands = MI.getNumOperands();
            for (unsigned i = 0; i < NumOperands; i++) {
                MachineOperand &MO = MI.getOperand(i);
                if (!isVirtReg(MO)) {
                    continue;
                }
                Global.insert(MO.getReg());
            }
        }
    }*/
    // populate Def and Ref sets
    for (auto &MB : * MF) {
        //Def[&MB] = Global;
        for (MachineBasicBlock::iterator i = MB.begin(), e = MB.end(); i!=e; i++) {
            MachineInstr &MI = *(&*(i));
            unsigned NumOperands = MI.getNumOperands();
            for (unsigned j = 0; j < NumOperands; j++) {
                MachineOperand &MO = MI.getOperand(j);

                /*if (!MO.isReg()) {
                    continue;
                }

                if (!MO.getReg()) {
                    continue;
                }
                if (!TargetRegisterInfo::isVirtualRegister(MO.getReg())) {
                    continue;
                }*/
                if (!isVirtReg(MO)) {
                    continue;
                }
                unsigned VirtReg = MO.getReg();
                if (MO.isDef()) {
                    Kill[&MB].insert(VirtReg);
                    Gen[&MB].erase(VirtReg);
                }
                if (MO.isUse()) {
                    Gen[&MB].insert(VirtReg);
                }
                
            }
            
        }
        In[&MB] = Gen[&MB];
    }
    
    bool Changed = false;
    do {
        for (auto &MB : *MF)
        {
            unsigned In_size = In.size(), Out_size = Out.size();
            // Out[b] = union In[p] for every p in successors[b]
            for (MachineBasicBlock *Pred : MB.successors()) {
                for (unsigned VirtReg : In[Pred]) {
                    Out[&MB].insert(VirtReg);
                }
            }
            // In[B] = Gen[B] union (Out[B] - Kill[B])
            for (unsigned VirtReg : Out[&MB]) {
                VirtRegSet &Killed = Kill[&MB];
                if (Killed.find(VirtReg) == Killed.end()) {
                    In[&MB].insert(VirtReg);
                }
            }
            
            Changed = (In.size() != In_size ||
                       Out.size() != Out_size);
        }
    }
    while(Changed);
}


bool Chaitin::setReg(MachineOperand& MO, unsigned PhysReg)
{
    bool Dead = MO.isDead();
    
    if (!MO.getSubReg()) {
        // no sub-register used here
        MO.setReg(PhysReg);
        return MO.isKill() || MO.isDead();
    }
    
    MO.setReg(PhysReg ? TRI->getSubReg(PhysReg, MO.getSubReg()) : 0);
    MO.setSubReg(0);
    
    // killed sub register implies that the full register is killed
    if (MO.isKill()) {
        MO.getParent()->addRegisterKilled(PhysReg, TRI, true);
        return true;
    }
    
    // defed sub register implies that the full register is defed
    if (MO.isDef() || MO.isUndef()) {
        MO.getParent()->addRegisterDefined(PhysReg, TRI);
    }
    
    return Dead;
}

// select an available physical register
unsigned Chaitin::selectPhysReg(unsigned VirtReg, bool *Clobbered)
{
    //outs() << "reaching 4\n";
    //outs() << "virtreg is: " << VirtReg << " "<< TRI->isVirtualRegister(VirtReg) << "\n";
            //outs() << ((1L << 30) - 1 < VirtReg) << "\n";
    if (VRM->hasPhys(VirtReg)) {
        outs() << "reaching 6\n";
        outs() << "physReg is: " << TRI->getName(VRM->getPhys(VirtReg)) << "\n";
        return VRM->getPhys(VirtReg);
    }
    //outs() << "reaching 5\n";
    AllocationOrder Order(VirtReg, *VRM, RegClassInfo);
            //outs() << "reaching 8\n";
    LiveInterval& VLI = LIS->getInterval(VirtReg);
    unsigned PhysReg;
    bool Interfering;

    do {
        PhysReg = Order.next();
        //outs() << "now checking physReg " << PhysReg << "\n";
        // run out of physical register
        if (!PhysReg) {
                    outs() << "Run out of registers!\n";
            break;
        }
        Interfering = !canAssignPhys(VLI, PhysReg);
    } while (Interfering);
    
    if (!PhysReg) {
        outs() << "return 0\n";
        return 0;
    }
    //outs() << "reaching 7\n";
    Mat->assign(VLI, PhysReg);
    
    if (Clobbered != nullptr) {
        *Clobbered = Mat->checkRegMaskInterference(VLI, PhysReg);
    }
    
    return PhysReg;
}

int Chaitin::getStackSlot(unsigned PhysReg, const TargetRegisterClass *RC)
{
    bool Allocated = VirtReg2FrameIdx.find(PhysReg) != VirtReg2FrameIdx.end();
    if (Allocated) {
        return VirtReg2FrameIdx[PhysReg];
    }
    
    int FI = MF->getFrameInfo()->CreateSpillStackObject(RC->getSize(), RC->getAlignment());
    VirtReg2FrameIdx[PhysReg] = FI;
    return FI;
}

void Chaitin::init(MachineFunctionPass *Pass, MachineFunction *mf)
{
    MF = mf;
    TM = &MF->getTarget();
    VRM = &Pass->getAnalysis<VirtRegMap>();
    LIS = &Pass->getAnalysis<LiveIntervals>();
    Mat = &Pass->getAnalysis<LiveRegMatrix>();
    // Target Register Info
    TRI = MF->getTarget().getRegisterInfo();
    
    RegClassInfo.runOnMachineFunction(*MF);
    
    VirtReg2FrameIdx.clear();
}


// check if virtreg interferes with other fixed regunit (e.g. ESP)
// and if virtreg interferes with other other virtreg
bool Chaitin::canAssignPhys(LiveInterval& VirtReg, unsigned PhysReg)
{
    if (Mat->checkRegUnitInterference(VirtReg, PhysReg)) return false;
    
    for (MCRegUnitIterator Units(PhysReg, TRI); Units.isValid(); ++Units) {
        if (Mat->query(VirtReg, *Units).checkInterference()) return false;
    }
    
    return true;
}

void Chaitin::getAnalysisUsage(AnalysisUsage &AU) const
{
    AU.setPreservesCFG();
    //AU.addRequiredID(PHIEliminationID);
    AU.addRequired<LiveIntervals>();
    AU.addRequired<VirtRegMap>();
    AU.addRequired<LiveRegMatrix>();
    AU.addPreserved<LiveRegMatrix>();
    AU.addPreserved<LiveIntervals>();
    AU.addPreserved<VirtRegMap>();
    MachineFunctionPass::getAnalysisUsage(AU);
}

Chaitin::Chaitin() : MachineFunctionPass(ID)
{
    initializePHIEliminationPass(*PassRegistry::getPassRegistry());
    initializeLiveIntervalsPass(*PassRegistry::getPassRegistry());
    initializeVirtRegMapPass(*PassRegistry::getPassRegistry());
    initializeLiveRegMatrixPass(*PassRegistry::getPassRegistry());
}

FunctionPass *llvm::createChaitin() {
    return new Chaitin;
}
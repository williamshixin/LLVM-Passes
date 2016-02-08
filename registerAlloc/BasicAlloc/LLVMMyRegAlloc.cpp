#include "llvm/Pass.h"
#include "llvm/CodeGen/VirtRegMap.h"
#include "llvm/CodeGen/RegisterClassInfo.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/RegAllocRegistry.h"
#include "llvm/Target/TargetInstrInfo.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include <iostream>
#include <vector>
#include <map>
#define DEBUG_TYPE "myregalloc"

using namespace llvm;

namespace llvm {
  FunctionPass *createLLVMMyRegAlloc();
}

static RegisterRegAlloc myRegAlloc("MyRegAllocator", "A global register allocatio pass at the procedure level.", createLLVMMyRegAlloc);

namespace {
  struct LLVMMyRegAlloc : public MachineFunctionPass {

  public:
    // pass identification, replacement for type id
    static char ID;
    // constructor
    LLVMMyRegAlloc() : MachineFunctionPass(ID){}
    // register allocator for the function
    bool runOnMachineFunction(MachineFunction &Fn);
    //specified required and invalidated sets for this pass
    virtual void getAnalysisUsage(AnalysisUsage &AU) const {
      AU.addRequiredID(PHIEliminationID);
      AU.addRequired<VirtRegMap>();
      AU.addPreserved<VirtRegMap>();
      MachineFunctionPass::getAnalysisUsage(AU);
    }

  private:
    // Primary interface to the complete machine description for the target
    // machine. All target-specific information should be accessible through
    // this interface.
    const TargetMachine *TM;
    // Interface to description of machine instruction set
    const TargetInstrInfo *TII;
    // We assume that the target defines a static array of TargetRegisterDesc
    // objects that represent all of the machine registers that the target has.
    // As such, we simply have to track a pointer to this array so that we can
    // turn register number into a register descriptor.
    const TargetRegisterInfo *TRI;
    // Collect native machine code for a function. This class contains a list of
    // MachineBasicBlock instances that make up the current compiled function.
    // This class also contains pointers to various classes which hold
    // target-specific informaiton about the generated code.
    MachineFunction *MF;
    // Keep track of information for virtual and phsical registers,
    // including vreg register classes, use/def chains for registers, etc.
    MachineRegisterInfo *MRI;
    // Provides dynamic informaiton about target register classes. Callee
    // saved and reserved registers depends on calling conventions and other
    // dynamic information, so some things cannot be determined statically
    RegisterClassInfo RCI;
    // This maps virtual registers to physical registers and virtual registers to
    // stack slots. It is created and updated by a register allocator and then
    //used by a machine code rewriter that adds spill code and rewrites virtual into
    // physical register references.
    VirtRegMap *VRM;
    // maps virtual register to stack slot where to spill
    std::map<unsigned, int> virtRegMapStack;
    // registers that currently not use for assignment
    std::vector<bool> assignedRegs;
    // array of physical registers to check for use
    ArrayRef<MCPhysReg> assignOrder;
    // replace the virtual registers with available physical register for a
    // basic block
    void replaceVRegWithPReg(MachineBasicBlock & MBB);
    // find an available physical register for a virtial register for replacement
    unsigned findPhysReg(unsigned virtReg);
    // initiate this pass
    void init(MachineFunctionPass *Pass, MachineFunction *mf);
  };
  char LLVMMyRegAlloc::ID = 0;
}

unsigned LLVMMyRegAlloc::findPhysReg(unsigned virtReg) {
  assignOrder = RCI.getOrder(MRI->getRegClass(virtReg));

  unsigned physReg = 0;
  // check in order to find an available physical register
  for (unsigned idx = 0; idx < assignOrder.size(); idx++) {
    physReg = assignOrder[idx];
    if (!assignedRegs[physReg]) {
      // find one physical register to use
      MRI->setPhysRegUsed(physReg);
      break;
    }
  }
// if physical register num is 0, means we run out of registers
return physReg;
}

void LLVMMyRegAlloc::replaceVRegWithPReg(MachineBasicBlock &MBB) {

  typedef MachineBasicBlock::iterator MBBIterator;
  // loop for each instruction to find replacement for the virtual register operands
  for (MBBIterator MI = MBB.begin(); MI != MBB.end(); MI++) {
    // maps virtual resiger and assigned physical register pairs in this basic block
    std::map<unsigned, unsigned> vRegMapPReg;
    int numRegs = MRI->getNumVirtRegs();
    assignedRegs.resize(numRegs);

    bool isImpUses = MI->getDesc().getImplicitUses(), isImpDefs = MI->getDesc().getImplicitDefs();
    // for each registers that are potentially read by any instance of this
    // machine instruction, set them not available
    if (isImpUses) {
      const unsigned short *uses = MI->getDesc().getImplicitUses();
      while (*uses != 0) {
        assignedRegs[*uses] = true;
        uses++;
      }
    }
    // for each registers that are potentially written by any instance of
    // this machine instruction, set them unavailable
    if (isImpDefs) {
      const unsigned short *defs = MI->getDesc().getImplicitDefs();
      while (*defs != 0) {
        assignedRegs[*defs] = true;
        MRI->setPhysRegUsed(*defs);
        defs++;
      }
    }
    // loop for this instruction to find replacement for operands
    for (int i = MI->getNumOperands() - 1; i >= 0; i--) {
      MachineOperand &op = MI->getOperand(i);
      if (op.isReg() && TargetRegisterInfo::isVirtualRegister(op.getReg())) {
        unsigned virtReg = (unsigned) op.getReg();
        unsigned physReg = vRegMapPReg[virtReg];
        const TargetRegisterClass *RC = MRI->getRegClass(virtReg);
        int frameIdx;
        // get a frame in the stack for further spilling
        if (virtRegMapStack.find(virtReg) != virtRegMapStack.end()) {
        // already have assigned a slot
            frameIdx = virtRegMapStack[virtReg];
        } else {
        // currently no assigned slot, get a slot and assign now
          frameIdx = MF->getFrameInfo()->CreateSpillStackObject(RC->getSize(), RC->getAlignment());
          virtRegMapStack[virtReg] = frameIdx;
        }
        // add move instruction for spilling
        if ((!physReg && op.isDef()) || physReg) {
          if (!physReg) physReg = findPhysReg(virtReg);
          if (physReg && op.isUse()) continue;
          TII->storeRegToStackSlot(MBB, next(MI), physReg, false, frameIdx, RC, TRI);
        }
        // add move instruction for filling
        if (!physReg && op.isUse()) {
          physReg = findPhysReg(virtReg);
          TII->loadRegFromStackSlot(MBB, MI, physReg, frameIdx, RC, TRI);
          vRegMapPReg[virtReg] = physReg;
        }
        assignedRegs[physReg] = true;
        outs() << PrintReg(virtReg,TRI);
        // set physical register for the virtual register
        MI->getOperand(i).setReg(physReg);
        outs() << " => %" << TRI->getName(physReg) << "(physReg" << op.getReg() << ")" << "\n";
      }
    }
    assignedRegs.clear();
  }
}

bool LLVMMyRegAlloc::runOnMachineFunction(MachineFunction &Fn) {
  typedef MachineFunction::iterator MFIterator;

  init(this, &Fn);
  outs() << "Register Allocation for function: " << MF->getName() << "\n";
  for (MFIterator MBB = Fn.begin(); MBB != Fn.end(); MBB++) {
    replaceVRegWithPReg(*MBB);
  }
  MRI->clearVirtRegs();
  virtRegMapStack.clear();
  return true;
}

void LLVMMyRegAlloc::init(MachineFunctionPass *Pass, MachineFunction *mf) {
  MF = mf;
  TM = &MF->getTarget();
  MRI = &MF->getRegInfo();
  TII = TM->getInstrInfo();
  TRI = TM->getRegisterInfo();
  VRM = &Pass->getAnalysis<VirtRegMap>();
  RCI.runOnMachineFunction(VRM->getMachineFunction());
}

FunctionPass *llvm::createLLVMMyRegAlloc() {
  return new LLVMMyRegAlloc();
}

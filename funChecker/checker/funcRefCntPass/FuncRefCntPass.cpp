#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/CallGraphSCCPass.h"

using namespace llvm;

namespace{
	struct FuncRefCntPass : public CallGraphSCCPass 
	{
		static char ID;

		FuncRefCntPass () : CallGraphSCCPass(ID) {}

		bool runOnSCC (CallGraphSCC &scc) override  {
			for (CallGraphNode *node : scc) {
				Function *func = node->getFunction();
				if (func == NULL || func->isDeclaration()) continue;
				outs() << (func->getName()).str() << " (";
				FunctionType *fType = func->getFunctionType();
				FunctionType::param_iterator paraIter = fType->param_begin();
				while (paraIter != fType->param_end()) {
					StringRef type;
					if ((*paraIter)->isIntegerTy(8)) {
						type = "char";
					} else if ((*paraIter)->isIntegerTy(32)) {
						type = "int";
					} else if ((*paraIter)->isFloatTy()) {
						type = "float";
					} else if ((*paraIter)->isDoubleTy()) {
						type = "double";
					} else if ((*paraIter)->isFunctionTy()) {
						type = "function";
					} else if ((*paraIter)->isArrayTy()) {
						type = "array";
					} else if ((*paraIter)->isPointerTy()) {
						type = "pointer";
					} else {
						type = "unknown_type";
					}
					if (paraIter != fType->param_begin()) outs() << ", ";
					outs() << type;
					paraIter++;
				}
				int refNum = node->getNumReferences();
				outs() << ") : " << refNum << "\n";
			}
			return false;
		}
	};
}

char FuncRefCntPass :: ID = 0;
static RegisterPass<FuncRefCntPass> X("func-RefCnt", "Function References Count", false, false);
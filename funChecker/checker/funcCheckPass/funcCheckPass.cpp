#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Attributes.h"
#include "llvm/Analysis/CallGraphSCCPass.h"

using namespace llvm;

namespace {
	struct FuncCheck : public ModulePass {
		static char ID;
		FuncCheck() : ModulePass(ID){}

		bool runOnModule(Module &M) override {
			//M.addModuleFlag(llvm::Module::Warning, "Dwarf Version", 3);

//M.addModuleFlag(llvm::Module::Error, "Debug Info Version",
                             //llvm::DEBUG_METADATA_VERSION);
			//func is an iterator of the functions in the module
			//if (Triple(llvm::sys::getProcessTriple()).isOSDarwin()) errs() << "asdfasdfasdf\n";
			//M.addModuleFlag(llvm::Module::Warning, "Dwarf Version", 2);
			Module::iterator func = M.begin();
			while (func != M.end()) {
				//basicBlock is an iterator of the basicblocks in a function
				Function::iterator basicBlock = func->begin();
				while (basicBlock != func->end()) {
					//instruc is an iterator of the instructions in a basic black
					BasicBlock::iterator instruc = basicBlock->begin();
					while (instruc != basicBlock->end()) {
						//a call instruction implies we have a function to chech in this instruction
						if (isa<CallInst>(instruc)) {
							Instruction &inst = *instruc;
							//static_cast is a checked cast, if it is a instruction, we assumes it is a call instruction
							CallInst &caller = static_cast<CallInst&>(inst);
							//get the parameter numbers of the callee function
							unsigned oprandNum = inst.getNumOperands() - 1;
							//dyn_cast is a checking cast, check if the instruction is actually a call function, if yes, check the type and params
							if (const Function *f = dyn_cast<const Function>(caller.getCalledValue()->stripPointerCasts())) {
							//use stripPointerCasts to get the real name of the function in case the callee is different with the function's decleartion
								FunctionType *fType = f->getFunctionType();
								//get the parameter number in the function declaration
								unsigned declParamNum = fType->getNumParams();
								//compile with -g, get metadata node of the call instruction, later get line number and other infos
								MDNode *mdNode = inst.getMetadata("dbg");
								//if (mdNode == NULL) errs() << "asdgfgsdfasdf";
								//DILocation: A debug location in source code, used for debug info and otherwise.
								//DILocation dgbInfo(mdNode); //DI: debug information
								DILocation loc = DILocation(mdNode);
								//check if parameters number doesn't match
								if (!f->isDeclaration()) {
									if(oprandNum != declParamNum){
										errs() << "Function \'";
										errs() << f->getName();
										errs() << "\' call on line \'";
										//errs() << dgbInfo.getLineNumber(); 
										errs() << loc.getLineNumber();
										errs() <<"\': excepted \'";
										errs() << declParamNum;
										errs() <<"\' arguments but \'";
										errs() << oprandNum;
										errs() << "\' are/is present.\n";
										//continue;
									}
								}

								//check if parameters types do not match
								if(!f->isDeclaration()){
									for(int i= 0; i<(int)oprandNum; i++){
										Type *t = (inst.getOperand(i))->getType();
										Type *paramType = fType->getParamType(i);
										if(paramType->getTypeID() != t->getTypeID()){
											errs() << "Function \'";
											errs() << f->getName();
											errs() <<"\' call on line \'";
											//errs() << dgbInfo.getLineNumber();
											errs() << loc.getLineNumber();
											errs() <<"\': argument type mismatch. Expected \'";
											errs() << typeChecker(paramType);
											errs() <<"\'' but argument is of type \'";
											errs() << typeChecker(t) <<"\'.\n";
										} else if ((paramType->isIntegerTy(32) && t->isFloatTy()) || (paramType->isFloatTy() && t->isIntegerTy(32))) {
											errs() << "Function \'";
											errs() << f->getName();
											errs() <<"\' call on line \'";
											//errs() << dgbInfo.getLineNumber();
											errs() << loc.getLineNumber();
											errs() <<"\': argument type mismatch. Expected \'";
											errs() << typeChecker(paramType); 
											errs() <<"\' but argument is of type \'";
											errs() << typeChecker(t) <<"\'.\n";
										}
									}
								}
							}
						}
						instruc++;
					}
					basicBlock++;
				}
				func++;
			}
			return false;
		}

		private: 
			//get type of the input parameter
			StringRef typeChecker(Type *target){
				const int charSize = 8;
				const int integerSize = 32;
				StringRef rv;

				if ((*target).isFunctionTy()) {
					rv = "function";
				} else if ((*target).isPointerTy()) {
					rv = "pointer";
				} else if ((*target).isArrayTy()) {
					rv = "array";
				} else if ((*target).isDoubleTy()) {
					rv = "double"; 
				} else if ((*target).isFloatTy()) {
					rv = "float";
				} else if ((*target).isIntegerTy(integerSize)) {
					rv = "int";
				} else if ((*target).isIntegerTy(charSize)) {
					rv = "char";
				} else {
					rv = "unknown type";
				}

				return rv;
			}	
	};
	/*struct FuncCheck : public ModulePass {
		static char ID;
		FuncCheck() : ModulePass(ID){}

		bool runOnModule(Module &M) override {
			//func is an iterator of the functions in the module
			Module::iterator func = M.begin();
			while (func != M.end()) {
				//basicBlock is an iterator of the basicblocks in a function
				Function::iterator basicBlock = func->begin();
				while (basicBlock != func->end()) {
					//instruc is an iterator of the instructions in a basic black
					BasicBlock::iterator instruc = basicBlock->begin();
					while (instruc != basicBlock->end()) {
						//a call instruction implies we have a function to chech in this instruction
						if (isa<CallInst>(instruc)) {
							Instruction &inst = *instruc;
							//dyn_cast is a checking cast, check if the instruction is actually a call function, if yes, check the type and params
							if (const Function *f = dyn_cast<const Function>((static_cast<CallInst&>(inst)).getCalledValue()->stripPointerCasts())) {
								//DILocation: A debug location in source code, used for debug info and otherwise.
								DILocation dgbInfo(inst.getMetadata("dbg")); //DI: debug information

								//check if parameters number doesn't match
								if(inst.getNumOperands() - 1 != f->getFunctionType()->getNumParams()){
									errs() << "Function \'";
									errs() << f->getName();
									errs() << "\' call on line \'";
									errs() << dgbInfo.getLineNumber(); 
									errs() <<"\': excepted \'";
									errs() << f->getFunctionType()->getNumParams();
									errs() <<"\' arguments but \'";
									errs() << inst.getNumOperands() - 1;
									errs() << "\' are/is present.\n";
									continue;
								}

								//check if parameters types do not match
								if(!f->isDeclaration()){
									for(int i= 0; i<(int)inst.getNumOperands() - 1; i++){
										Type *t = (inst.getOperand(i))->getType();
										Type *paramType = f->getFunctionType()->getParamType(i);
										if(paramType->getTypeID() != t->getTypeID()){
											errs() << "Function \'";
											errs() << f->getName();
											errs() <<"\' call on line \'";
											errs() << dgbInfo.getLineNumber();
											errs() <<"\': argument type mismatch. Expected \'";
											errs() << typeChecker(paramType);
											errs() <<"\'' but argument is of type \'";
											errs() << typeChecker(t) <<"\'.\n";
										} else if ((paramType->isIntegerTy(32) && t->isFloatTy()) || (paramType->isFloatTy() && t->isIntegerTy(32))) {
											errs() << "Function \'";
											errs() << f->getName();
											errs() <<"\' call on line \'";
											errs() << dgbInfo.getLineNumber();
											errs() <<"\': argument type mismatch. Expected \'";
											errs() << typeChecker(paramType); 
											errs() <<"\' but argument is of type \'";
											errs() << typeChecker(t) <<"\'.\n";
										}
									}
								}
							}
						}
						instruc++;
					}
					basicBlock++;
				}
				func++;
			}
			return false;
		}

		private: 
			//get type of the input parameter
			StringRef typeChecker(Type *target){
				const int charSize = 8;
				const int integerSize = 32;
				StringRef rv;

				if ((*target).isFunctionTy()) {
					rv = "function";
				} else if ((*target).isPointerTy()) {
					rv = "pointer";
				} else if ((*target).isArrayTy()) {
					rv = "array";
				} else if ((*target).isDoubleTy()) {
					rv = "double"; 
				} else if ((*target).isFloatTy()) {
					rv = "float";
				} else if ((*target).isIntegerTy(integerSize)) {
					rv = "int";
				} else if ((*target).isIntegerTy(charSize)) {
					rv = "char";
				} else if ((*target).isVoidTy()){
					rv = "void";
				} else {
					rv = "unknown type";
				}

				return rv;
			}	
	};*/
}

char FuncCheck :: ID =0;
static RegisterPass<FuncCheck> X("FuncCheck", "A semantic analysis pass with checking the function call's parameter number and type.", false, false);
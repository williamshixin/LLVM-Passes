# Makefile for tests; generates assembly code .s for all tests

# MACROS

# Test files
FILES = Test1.bc Test2.bc  Test4.bc Test5.bc Test6.bc Test7.bc Test8.bc  \
Test1.s Test2.s Test4.s Test5.s Test6.s Test7.s Test8.s  outTestCase.s\
Test1.exe Test2.exe  Test4.exe Test5.exe Test6.exe Test7.exe Test8.exe 
#FILES = Test5.bc Test5.s
# Paths and flags
LLVM_ROOT = ../../../Debug+Asserts
CLANG = $(LLVM_ROOT)/bin/clang
CLANG_FLAGS = -emit-llvm -O0
DIS = $(LLVM_ROOT)/bin/llvm-dis

LLC = $(LLVM_ROOT)/bin/llc
LLC_FLAGS = -load
#LIB_NAME = SpillAll.dylib
LIB_NAME = LLVMMyRegAlloc.dylib
LIB_ROOT = $(LLVM_ROOT)/lib/$(LIB_NAME)
#PASS_NAME = spill-all
PASS_NAME = MyRegAllocator
PASS_FLAGS = -regalloc=$(PASS_NAME)

# Dummy targets
all: $(FILES)

clean: 
	rm -f  *.ll *.s $(FILES:%.bc=%.exe)

# targets
%.bc: %.c
	$(CLANG) $(CLANG_FLAGS) -c $(@:%.bc=%.c) -o $@
	
%.s: %.bc
	$(LLC) $(LLC_FLAGS) $(LIB_ROOT) $(PASS_FLAGS) $^ -o $@ -O0

%.exe: %.s
	$(CLANG) $^ -o $@

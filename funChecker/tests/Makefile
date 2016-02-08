# Makefile for tests, generates unoptimized .ll IR for all tests

##
LLVM_ROOT = ../../../Debug+Asserts
CLANG = $(LLVM_ROOT)/bin/clang
CLANG_FLAGS = -emit-llvm -O0 -g
DIS = $(LLVM_ROOT)/bin/llvm-dis
LLC = $(LLVM_ROOT)/bin/llc
LLL = $(LLVM_ROOT)/bin/llvm-link

tests: test1.bc test2.bc
	
test1.bc: test1.c
	$(CLANG) $(CLANG_FLAGS) -c test1.c -o test1.bc

test2.bc: test2.1.c test2.2.c
	$(CLANG) $(CLANG_FLAGS) -c test2.1.c -o test2.1.bc
	$(CLANG) $(CLANG_FLAGS) -c test2.2.c -o test2.2.bc
	$(LLL)  test2.1.bc test2.2.bc -o test2.bc
	$(DIS) -f $@

clean:
	rm -f *.bc *.ll *.s $(FILES:%.bc=%)
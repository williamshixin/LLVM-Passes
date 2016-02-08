../../../Debug+Asserts/bin/opt -load ../../../Debug+Asserts/lib/FuncRefCntPass.dylib -func-RefCnt < test1.bc -o /dev/null
../../../Debug+Asserts/bin/opt -load ../../../Debug+Asserts/lib/funcCheckPass.dylib -FuncCheck < test1.bc -o /dev/null

../../../Debug+Asserts/bin/opt -load ../../../Debug+Asserts/lib/FuncRefCntPass.dylib -func-RefCnt < test2.bc -o /dev/null
../../../Debug+Asserts/bin/opt -load ../../../Debug+Asserts/lib/funcCheckPass.dylib -FuncCheck < test2.bc -o /dev/null
LLVM Passes

This is a project of optimization passes based on the LLVM compilation infrastrucure to analyse and optimize the compilation of C/C+ code.

The function checker pass checks if the user defined functions are decleared and their parameters type/number matches the declearation, gather the reference count of the user defined function in the code

The two register allocators passes: a basic strategy is spill all register to memory after use, another more sophiscated one is a graph coloring register allocator based on Chaitin-Briggs' algorithm.

../../Debug+Asserts/bin/clang -S -emit-llvm TaskII_Callgraph.c -o - | ../../Debug+Asserts/bin/opt -analyze -dot-callgraph
dot -T png -o callgraph.png callgraph.dot
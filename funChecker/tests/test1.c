#include <stdio.h>

void func1();
void func2(int num);
void func3();
void func4(int num);
void func5();

int main(){
	func1();
	func3();
	func5();
	printf("%s\n", "Main function is called by program. This is a test for -dot-callgraph pass in LLVM.");
}

void func1() {
	int num = 11;
	printf("%s\n", "Function1 was callsed by program.");
	func2(num);
}

void func2(int num) {
	printf("%s\n", "Function2 was called by program.");
}

void func3() {
	int num = 1;
	printf("%s\n", "Function3 was called by program.");
	func2(num);
}

void func4(int num) {
	printf("%s\n", "Function4 was called by program.");
}

void func5() {
	int num1 = 2, num2 = 3;
	printf("%s\n", "Function5 was called by program.");
	func2(num1);
	func4(num2);
}
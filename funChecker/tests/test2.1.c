#include <stdio.h>

extern void func1(float f1);
extern void func2(float f1);

int main() {
	float f = 0.5f;
	func1(f);
	func2(0.5f);
	printf("This is a test for project 1.\n");
	return 0;
}
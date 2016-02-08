#include <stdio.h>

int factorial(long int n){
	if(n==1 || n==0)
		return 1;
	return n*factorial(n-1);
}

int fibonacci(int n){
	if(n==0 || n==1)
		return n;
	return fibonacci(n-2) + fibonacci(n-1);

}


int main(){
	printf("\n 5th Term in fibonacci is: %d", fibonacci(5));
	printf("\n Factorial of 5 is: %d", factorial(5));
	return 0;
}

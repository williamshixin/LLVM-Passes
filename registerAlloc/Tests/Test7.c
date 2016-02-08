#include <stdio.h>

// use this so that opt doesn't optimize away constants
int get(int n)
{
    return n;
}

int main()
{
    int a;
    if (get(1)) {
        a = get(42);
    } else {
        a = get(0);
    }
    printf("%d\n", a);
}
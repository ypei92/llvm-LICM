#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    int a = atoi(argv[1]);
    int b = atoi(argv[2]);
    int i = 1;

    int c = 0;
    while ( i < 3 ) {
        c += a + b;
        i ++;
    }

    return 0;
}

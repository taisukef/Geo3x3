#include <stdio.h>
#include "geo3x3.h"

int main() {
    char buf[30];
    Geo3x3_encode(35.65858, 139.745433, 14, buf);
    printf("%s\n", buf); // E3793653391822

    double res[4];
    Geo3x3_decode("E3793653391822", res);
    printf("%f %f %f %f\n", res[0], res[1], res[2], res[3]); // 35.658634 139.745466 14.000000 0.000113
    return 0;
}

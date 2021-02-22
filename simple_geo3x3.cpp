#include <iostream>
#include "geo3x3.h"
using namespace std;

int main() {
    char buf[30];
    Geo3x3_encode(35.65858, 139.745433, 14, buf);
    cout << buf << endl;

    double res[4];
    Geo3x3_decode("E3793653391822", res);
    cout << res[0] << " " << res[1] << " " << res[2] << " " << res[3] << endl;
    return 0;
}

#include <iostream>
#include "geo3x3.h"
using namespace std;

int main() {
    enum GEO3X3_RES err;

    char enc_buf[16];
    struct geo3x3_wgs84 res;

    if ((err = geo3x3_from_wgs84_str(
        35.65858, 139.745433,
        14,
        enc_buf,
        sizeof(enc_buf)
    ))) {
        // handle errors
        exit(1);
    }

    cout << enc_buf << endl;

    if ((err = geo3x3_to_wgs84_str(enc_buf, &res))) {
        // handle errors
        exit(1);
    }

    cout << res.lat << " " << res.lng << " " << +res.level << " " << res.unit << endl;

    return 0;
}

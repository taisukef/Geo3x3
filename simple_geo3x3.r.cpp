#include <stdio.h>
#include "geo3x3.r.hpp"

int main(){
    Geo3x3::Encoder<14> enc(35.65858, 139.745433);
    printf("%s\n", (const char*)enc);

    Geo3x3::Decoder dec("E9139659937288");
    printf("%f %f (%d)\n", dec.lat(), dec.lng(), dec.level());

    return 0;
}



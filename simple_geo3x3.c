#include <stdio.h> /**< printf */
#include <stdlib.h> /**< exit */
#include "geo3x3.h"

/* cc -Wall -Wextra simple_geo3x3.c */

int main() {
    enum GEO3X3_RES err;

    char enc_buf[16];
    struct geo3x3_wgs84 res;

    if ((err = geo3x3_from_wgs84_str(
         35.36053512254623,
         138.72724901129274,
         14,
         enc_buf,
         sizeof(enc_buf)
       ))) {
      // handle errors
      exit(1);
    }
    
    printf("geo3x3: %s\n", enc_buf); // geo3x3: E9139519253557

    if ((err = geo3x3_to_wgs84_str(enc_buf, &res))) {
      // handle errors
      exit(1);
    }

    // wgs84: 35.360576 138.727215 14 0.000113
    printf(" wgs84: %f %f %u %f\n", 
      res.lat,
      res.lng,
      res.level,
      res.unit
    );

    return 0;
}

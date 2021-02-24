#include <stdio.h>
#include "Geo3x3.r.h"



int main(){
  char g3x3[14+1];
  Geo3x3_encode(35.65858, 139.745433, g3x3, g3x3+14);
  printf("%s\n", g3x3);

  double lat, lng;
  int level = Geo3x3_decode(g3x3, &lat, &lng);
  printf("%f %f (%d)\n", lat, lng, level);

  return 0;
}




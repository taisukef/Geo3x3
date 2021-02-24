#include <stdio.h>



// Encode
static
char* encode_(double lat, double lng, double prec, char* ps, char* pe){
  if(ps == pe){
    *ps = '\0';
  }else{
    int x = lng / prec;
    int y = lat / prec;
    *ps = '1' + (3*y) + x;
    encode_(lat-prec*y, lng-prec*x, prec/3, ps+1, pe);
  }
  return ps;
}

char* Geo3x3_encode(double lat, double lng, char* ps, char* pe){
  if(lng < 0.0){
    *ps = 'W';
    encode_(90.0-lat, lng+180.0, 180.0/3, ps+1, pe);
  }else{
    *ps = 'E';
    encode_(90.0-lat, lng,       180.0/3, ps+1, pe);
  }
  return ps;
}

// Decode
static
int decode_(char* ps, double prec, double* plat, double* plng, int level){
  unsigned n = *ps - '1';
  if(n < 9){
    *plng += n % 3 * prec;
    *plat -= n / 3 * prec;
    return decode_(ps+1, prec/3, plat, plng, level+1);
  }else{
    *plng += prec / 2;
    *plat -= prec / 2;
    return level;
  }
}

int Geo3x3_decode(char* ps, double* plat, double* plng){
  *plat = 90.0;
  *plng = 0.0;
  return decode_(ps+1, 180.0/3, plat, plng, 1);
}





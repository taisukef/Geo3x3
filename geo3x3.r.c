// Encode
static
char* encode_(double lat, double lng, double prec, char* code, unsigned remain){
  if(remain){
    int x = lng / prec;
    int y = lat / prec;
    *code = '1' + (3*y) + x;
    encode_(lat-prec*y, lng-prec*x, prec/3, code+1, remain-1);
  }else{
    *code = '\0';
  }
  return code;
}

char* Geo3x3_encode(double lat, double lng, char* code, unsigned remain){
  if(lng < 0.0){
    *code = 'W';
    encode_(lat + 90.0, lng+180.0, 180.0/3, code+1, remain-1);
  }else{
    *code = 'E';
    encode_(lat + 90.0, lng,       180.0/3, code+1, remain-1);
  }
  return code;
}

// Decode
static
int decode_(char* ps, double prec, double* plat, double* plng, int level){
  unsigned n = *ps - '1';
  if(n < 9){
    *plng += n % 3 * prec;
    *plat += n / 3 * prec;
    return decode_(ps+1, prec/3, plat, plng, level+1);
  }else{
    *plng += prec / 2;
    *plat += prec / 2;
    return level;
  }
}

int Geo3x3_decode(char* ps, double* plat, double* plng){
  *plat = 0.0;
  *plng = (*ps == 'W') ? -180.0 : 0.0;
  int res = decode_(ps+1, 180.0/3, plat, plng, 1);
  *plat -= 90.0;
  return res;
}



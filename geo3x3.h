#ifndef GEO3X3_H
#define GEO3X3_H

#ifdef __cplusplus
extern "C"
{
#endif

int Geo3x3_encode(double lat, double lng, int level, char* res) {
  if (level < 1) {
    return 0;
  }
  int idx = 0;
  res[idx] = 'E';
  if (lng < 0) {
    res[idx] = 'W';
    lng += 180;
  }
  idx++;
  lat = 90. - lat; // 0:the North Pole,  180:the South Pole
  double unit = 180.;
  for (int i = 1; i < level; i++) {
    unit /= 3;
    int x = (int)(lng / unit);
    int y = (int)(lat / unit);
    res[idx++] = (char)('0' + x + y * 3 + 1);
    lng -= x * unit;
    lat -= y * unit;
  }
  res[idx] = 0;
  return 1;
}
int Geo3x3_decode(const char* code, double* res) {
  if (!code) {
    return 0;
  }
  int flg = code[0] == 'W';
  double unit = 180.;
  double lat = 0.;
  double lng = 0.;
  int level = 1;
  for (int i = 1;; i++) {
    char c = code[i];
    if (!c || c < '0' || c > '9') {
      break;
    }
    int n = c - '0';
    if (n == 0) {
      break;
    }
    unit /= 3;
    n--;
    lng += (n % 3) * unit;
    lat += (int)(n / 3) * unit;
    level++;
  }
  lat += unit / 2;
  lng += unit / 2;
  lat = 90 - lat;
  if (flg) {
    lng -= 180;
  }
  res[0] = lat;
  res[1] = lng;
  res[2] = (double)level;
  res[3] = unit;
  return 1;
}

#ifdef __cplusplus
} //X:E extern "C"
#endif

#endif //X:E GEO3X3_H

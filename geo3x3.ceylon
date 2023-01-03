Float floor(Float n) {
  dynamic {
    return \iMath.floor(n);
  }
}

shared String encode(variable Float lat, variable Float lng, Integer level) {
  variable value res = "E";
  if (lng < 0.0) {
    res = "W";
    lng += 180.0;
  }
  lat += 90.0; // 180:the North Pole,  0:the South Pole
  variable value unit = 180.0;
  for (i in 1:level - 1) {
    unit /= 3.0;
    value x = floor(lng / unit);
    value y = floor(lat / unit);
    value c = "0123456789"[(x + y * 3 + 1).integer];
    if (is Character c) {
      res = res + "``c``";
    }
    lng -= x * unit;
    lat -= y * unit;
  }
  return res;
}

shared [Float, Float, Integer, Float] decode(String code) {
  variable value flg = false;
  variable value begin = 0;
  value c = code[0];
  if (is Character c) {
    if (c == 'W') {
      flg = true;
      begin = 1;
    } else if (c == 'E') {
      begin = 1;
    }
  }
  print(begin);
  variable value unit = 180.0;
  variable value lat = 0.0;
  variable value lng = 0.0;
  variable value level = 1;
  for (i in begin:code.size - 1) {
    value c2 = code[i];
    variable Integer n = 0;
    if (is Character c2) {
      n = c2.integer - 49;
    }
    unit /= 3.0;
    lng += (n % 3) * unit;
    lat += (n / 3) * unit;
    level++;
  }
  lat += unit / 2.0;
  lng += unit / 2.0;
  lat -= 90.0;
  if (flg) {
    lng -= 180.0;
  }
  return [lat, lng, level, unit];
}

shared void main() { 
  print(encode(35.65858, 139.745433, 14));
  print(decode("E9139659937288"));
}

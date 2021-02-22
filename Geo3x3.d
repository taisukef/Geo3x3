import std.string;
import std.math;

bool encode(double lat, double lng, int level, char[] code) {
  auto idx = 0;
  auto unit = 180.0;
  if (level < 1) {
    return false;
  }
  if (!code || code.length != level) {
    return false;
  }
  if (lng < 0.0) {
    code[idx] = 'W';
    lng += 180.0;
  } else {
    code[idx] = 'E';
  }

  idx++;
  lat = 90.0 - lat; // 0:the North Pole, 180:the South Pole
  for (auto i = 1; i < level; i++) {
    unit /= 3;
    const x = cast(int)(lng / unit);
    const y = cast(int)(lat / unit);
    code[idx++] = '0' + x + (y * 3) + 1;
    lng -= x * unit;
    lat -= y * unit;
  }
  return true;
}
auto decode(string code) {
  if (!code || code.length < 1) {
    return null;
  }

  auto flg = false;
  auto begin = 0;
  const c = code[0];
  if (c == '-' || c == 'W') {
    flg = true;
    begin = 1;
  } else if (c == '+' || c == 'E') {
    begin = 1;
  }
  double unit = 180.0;
  double lat = 0.0;
  double lng = 0.0;
  auto level = 1;
  for (auto i = begin; i < code.length; i++) {
    auto n = std.string.indexOf("0123456789", code[i]);
    if (n == 0) {
      break;
    }
    unit /= 3;
    n--;
    lng += n % 3 * unit;
    lat += n / 3 * unit;
    level++;
  }
  lat += unit / 2;
  lng += unit / 2;
  lat = 90.0 - lat;
  if (flg) {
    lng -= 180.0;
  }
  return [ lat, lng, level, unit ];
}

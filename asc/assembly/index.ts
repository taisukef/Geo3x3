export function encode(lat: f32, lng: f32, level: number): string {
  if (level < 1) {
    return "";
  }
  let res = "E";
  if (lng < 0) {
    res = "W";
    lng += 180;
  }
  lat += 90; // 180:the North Pole, 0:the South Pole
  let unit: f32 = 180;
  for (let i = 1; i < level; i++) {
    unit /= 3;
    const x = Math.floor(lng / unit) as i32;
    const y = Math.floor(lat / unit) as i32;
    res = res.concat((x + y * 3 + 1).toString());
    lng -= (x as f32) * unit;
    lat -= (y as f32) * unit;
  }
  return res;
}
export function decode(code: string): Array<f32> {
  const flg = code.charCodeAt(0) == 87;
  let unit: f32 = 180;
  let lat: f32 = 0;
  let lng: f32 = 0;
  let level: i32 = 1;
  for (let i = 1; i < code.length; i++) {
    const n = code.charCodeAt(i) - 48 - 1;
    if (n == -1) {
      break;
    }
    unit /= 3;
    lng += ((n % 3) as f32) * unit;
    lat += (Math.floor(n / 3) as f32) * unit;
    level++;
  }
  lat += unit / 2;
  lng += unit / 2;
  lat -= 90;
  if (flg) {
    lng -= 180;
  }
  const res = new Array<f32>(4);
  res[0] = lat;
  res[1] = lng;
  res[2] = level as f32;
  res[3] = unit;
  return res;
}

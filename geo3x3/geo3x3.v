module geo3x3

pub fn encode(lat f64, lng f64, level int) string {
  if level < 1 {
    return ""
  }
  mut res := "E"
  mut flat := lat
  mut flng := lng
  if lng < 0.0 {
    res = "W"
    flng += 180.0
  }
  flat += 90.0 // 0:the South Pole  180:the North Pole
  mut unit := 180.0
  for _ in 1 .. level {
    unit /= 3.0
    x := int(flng / unit)
    y := int(flat / unit)
    res += (x + y * 3 + 1).str()
    flng -= f64(x) * unit
    flat -= f64(y) * unit
  }
  return res
}
pub fn decode(code string) (f64, f64, int, f64) {
  flg := code[0] == `W`
  mut unit := 180.0
  mut lat := 0.0
  mut lng := 0.0
  mut level := 1
  for i in 1 .. code.len {
    c := code[i]
    if c < `1` || c > `9` {
      break
    }
    n := c - `1`
    unit /= 3.0
    lng += f64(n % 3) * unit
    lat += f64(n / 3) * unit
    level++
  }
  lat += unit / 2.0
  lng += unit / 2.0
  lat -= 90.0
  if flg {
    lng -= 180.0
  }
  return lat, lng, level, unit
}

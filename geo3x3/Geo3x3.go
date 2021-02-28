package geo3x3

func Encode(lat float64, lng float64, level int) string {
  if level < 1 {
    return ""
  }
  res := "E"
  if lng < 0.0 {
    res = "W"
    lng += 180.0
  }
  //lat = 90. - lat // 0:the North Pole,  180:the South Pole
  lat += 90 // 0:the South Pole  180:the North Pole
  unit := 180.
  i := 1
  for i < level {
    unit /= 3.0
    x := (int)(lng / unit)
    y := (int)(lat / unit)
    res += string((int)("0"[0]) + x + y * 3 + 1)
    lng -= float64(x) * unit
    lat -= float64(y) * unit
    i++
  }
  return res
}
func Decode(code string) []float64 {
  flg := code[0] == 'W'
  unit := 180.
  lat := 0.
  lng := 0.
  level := 1
  i := 1
  for {
    c := code[i]
    if c < '1' || c > '9' {
      break
    }
    n := c - '1'
    unit /= 3.0
    lng += float64(n % 3) * unit
    lat += float64(n / 3) * unit
    level++
    i++
    if i == len(code) {
      break
    }
  }
  lat += unit / 2.0
  lng += unit / 2.0
  //lat = 90 - lat
  lat -= 90.
  if flg {
    lng -= 180.
  }
  return []float64{ lat, lng, float64(level), unit }
}

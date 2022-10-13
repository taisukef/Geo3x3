package geo3x3

func Encode(lat, lng float64, level int) string {
	if level < 1 {
		return ""
	}
	res := "E"
	if lng < 0.0 {
		res = "W"
		lng += 180.0
	}
	//lat = 90. - lat // 0:the North Pole,  180:the South Pole
	lat += 90.0 // 0:the South Pole  180:the North Pole
	unit := 180.0
	for i := 1; i < level; i++ {
		unit /= 3.0
		x := int(lng / unit)
		y := int(lat / unit)
		res += string(rune('0' + x + y*3 + 1))
		lng -= float64(x) * unit
		lat -= float64(y) * unit
	}
	return res
}

func Decode(code string) []float64 {
	flg := code[0] == 'W'
	unit := 180.0
	lat := 0.0
	lng := 0.0
	level := 1
	for _, c := range code[1:] {
		if c < '1' || c > '9' {
			break
		}
		n := int(c - '1')
		unit /= 3.0
		lng += float64(n%3) * unit
		lat += float64(n/3) * unit
		level++
	}
	lat += unit / 2.0
	lng += unit / 2.0
	//lat = 90 - lat
	lat -= 90.0
	if flg {
		lng -= 180.0
	}
	return []float64{lat, lng, float64(level), unit}
}

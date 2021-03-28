function geo3x3_encode(lat, lng, level, unit,
		res, i, x, y) {
	if (level < 1) {
		return ""
	}
	res = "E"
	if (lng < 0) {
		res = "W"
		lng += 180
	}
	lat += 90 # 180:the North Pole, 0:the South Pole
	unit = 180
	for (i = 1; i < level; i++) {
		unit /= 3
		x = int(lng / unit)
		y = int(lat / unit)
		res = res "" (x + y * 3 + 1)
		lng -= x * unit
		lat -= y * unit
	}
	return res
}
function geo3x3_decode(code,
		clen, flg, unit, lat, lng, level, i, res) {
	clen = length(code)
	if (clen == 0) {
		return null
	}
	flg = substr(code, 1, 1) == "W"
	unit = 180
	lat = 0
	lng = 0
	level = 1
	for (i = 1; i < clen; i++) {
		n = substr(code, i + 1, 1) - 1
		if (n < 0 || n > 9) {
			break
		}
		unit /= 3
		lng += (n % 3) * unit
		lat += int(n / 3) * unit
		level++
	}
	lat += unit / 2
	lng += unit / 2
	lat -= 90
	if (flg) {
		lng -= 180
	}
	return lat " "  lng " " level " " unit
}

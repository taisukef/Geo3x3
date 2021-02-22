class Geo3x3 {
	static encode(lat, lng, level) {
		if (level < 1)
			return null
		final res = new StringBuilder()
		if (lng >= 0) {
			res.append('E')
		} else {
			res.append('W')
			lng += 180
		}
		lat = 90 - lat // 0:the North Pole,  180:the South Pole
		def unit = 180
		for (i in 1 .. level - 1) {
			unit /= 3
			def x = (int)Math.floor(lng / unit)
			def y = (int)Math.floor(lat / unit)
			res.append((char)((int)'0' + x + y * 3 + 1))
			lng -= x * unit
			lat -= y * unit
		}
		return res.toString()
	}
	static decode(code) {
		if (code == null || code.length() == 0)
			return null
		def begin = 0
		def flg = false
		def c = code[0]
		if (c == '-' || c == 'W') {
			flg = true
			begin = 1
		} else if (c == '+' || c == 'E') {
			begin = 1
		}
		def unit = 180
		def lat = 0
		def lng = 0
		def level = 1
		final clen = code.length()
		for (i in begin .. clen - 1) {
			def n = "0123456789".indexOf(code[i])
			if (n <= 0)
				break
			unit /= 3.0
			n--
			lng += n % 3 * unit
			lat += Math.floor(n / 3) * unit
			level++
		}
		lat += unit / 2.0
		lng += unit / 2.0
		lat = 90.0 - lat
		if (flg)
			lng -= 180.0
		return new double[] { lat, lng, level, unit }
	}
}

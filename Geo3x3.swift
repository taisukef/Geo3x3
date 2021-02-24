public struct Geo3x3 {
    public static func encode(lat: Double, lng: Double, level: Int) -> String {
		if level < 1 {
			return ""
		}
		var lng2 = lng
		var res = ""
		if lng >= 0 {
			res += "E"
		} else {
			res += "W"
			lng2 += 180
		}
		var lat2 = 90 - lat // 0:the North Pole,  180:the South Pole
		var unit = 180.0
		for _ in 1 ..< level {
			unit /= 3
			let x = (Int)(lng2 / unit)
			let y = (Int)(lat2 / unit)
			res += String(x + y * 3 + 1)
			lng2 -= Double(x) * unit
			lat2 -= Double(y) * unit
		}
		return res
    }
    public static func decode(code: String) -> Array<Double> {
		var begin = 0
		var flg = false
		let c = code.first // index(code.startIndex, offsetBy: 1)
		if c == "-" || c == "W" {
			flg = true
			begin = 1
		} else if c == "+" || c == "E" {
			begin = 1
		}
		var unit = 180.0
		var lat = 0.0
		var lng = 0.0
		var level = 1
		let clen = code.count
		let num = "0123456789"
		for i in begin ..< clen {
			let c = code[code.index(code.startIndex, offsetBy: i)]
			if let idx = num.firstIndex(of : c) {
				let n = num.distance(from: num.startIndex, to: idx) - 1
				if n >= 0 {
					unit /= 3
					lng += Double(n % 3) * unit
					lat += Double(n / 3) * unit
					level += 1
				}
			} else {
				break
			}
		}
		lat += unit / 2
		lng += unit / 2
		lat = 90 - lat
		if flg {
			lng -= 180.0
		}
        return [ lat, lng, Double(level), unit ];
    }
}

class Geo3x3 {
	companion object {
		fun encode(lat: Double, lng: Double, level: Int): String {
			if (level < 1) {
				return ""
			}
			val res = StringBuilder()
			var lng2 = lng
			if (lng >= 0) {
				res.append('E');
			} else {
				res.append('W');
	//			res.append('-');
				lng2 += 180;
			}
			var lat2 = lat + 90; // 180:the North Pole,  0:the South Pole
			var unit = 180.0;
			for (i in 1 until level) {
				unit /= 3;
				val x = (lng2 / unit).toInt();
				val y = (lat2 / unit).toInt();
				res.append(('0' + x + y * 3 + 1).toChar());
				lng2 -= x * unit;
				lat2 -= y * unit;
			}
			return res.toString();
		}
		fun decode(code: String): Array<Double> {
			var unit = 180.0
			var lat = 0.0
			var lng = 0.0
			var level = 1

			var begin = 0
			var flg = false;
			var c = code[0] // .charAt(0)
			if (c == '-' || c == 'W') {
				flg = true;
				begin = 1;
			} else if (c == '+' || c == 'E') {
				begin = 1;
			}
			val clen = code.length
			for (i in begin until clen) {
				var n = "0123456789".indexOf(code[i]) // .charAt(i));
				if (n <= 0)
					break;
				unit /= 3;
				n--;
				lng += n % 3 * unit;
				lat += n / 3 * unit;
				level++;
			}
			lat += unit / 2;
			lng += unit / 2;
			lat -= 90;
			if (flg)
				lng -= 180.0
			return arrayOf(lat, lng, level.toDouble(), unit);
		}
	}
}

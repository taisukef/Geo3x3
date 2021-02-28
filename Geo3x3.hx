class Geo3x3 {
    public static function encode(lat: Float, lng: Float, level: Int): String {
		if (level < 1) {
			return "";
		}
		var lng2 = lng;
		var res = "";
		if (lng >= 0) {
			res += "E";
		} else {
			res += "W";
			lng2 += 180;
		}
		var lat2 = lat + 90.0;
		var unit = 180.0;
		for (i in 1 ... level) {
			unit /= 3;
			final x = Std.int(lng2 / unit);
			final y = Std.int(lat2 / unit);
			res += x + y * 3 + 1;
			lng2 -= cast(x, Float) * unit;
			lat2 -= cast(y, Float) * unit;
		}
		return res;
    }
    public static function decode(code: String) : Array<Float> {
		var begin = 0;
		var flg = false;
		var c = code.charAt(0);
		if (c == "-" || c == "W") {
			flg = true;
			begin = 1;
		} else if (c == "+" || c == "E") {
			begin = 1;
		}
		var unit = 180.0;
		var lat = 0.0;
		var lng = 0.0;
		var level = 1;
		final clen = code.length;
		for (i in begin ... clen) {
			final n = "123456789".indexOf(code.charAt(i));
			if (n < 0) {
				break;
			}
			unit /= 3;
			lng += (n % 3) * unit;
			lat += Std.int(n / 3) * unit;
			level += 1;
		}
		lat += unit / 2;
		lng += unit / 2;
		lat -= 90.0;
		if (flg) {
			lng -= 180.0;
		}
        return [ lat, lng, level, unit ];
    }
}

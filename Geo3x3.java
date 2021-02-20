public class Geo3x3 {
	public static String encode(double lat, double lng, int level) {
		if (level < 1)
			return null;
		StringBuilder res = new StringBuilder();
		if (lng >= 0) {
			res.append('E');
		} else {
			res.append('W');
//			res.append('-');
			lng += 180;
		}
		lat = 90 - lat; // 0:the North Pole,  180:the South Pole
		double unit = 180;
		for (int i = 1; i < level; i++) {
			unit /= 3;
			int x = (int)Math.floor(lng / unit);
			int y = (int)Math.floor(lat / unit);
			res.append((char)('0' + x + y * 3 + 1));
			lng -= x * unit;
			lat -= y * unit;
		}
		return res.toString();
	}
	public static int encodeInt(double lat, double lng, int level) {
		String code = encode(lat, lng, level);
		if (code == null)
			return 0; // err
		try {
			int res = Integer.parseInt(code.substring(1));
			if (code.charAt(0) == 'W')
				return -res;
			return res;
		} catch (Exception e) {
		}
		return 0; // err
	}
	// lat, lng, level, unit
	public static double[] decode(String code) {
		if (code == null || code.length() == 0)
			return null;
		int begin = 0;
		boolean flg = false;
		char c = code.charAt(0);
		if (c == '-' || c == 'W') {
			flg = true;
			begin = 1;
		} else if (c == '+' || c == 'E') {
			begin = 1;
		}
		double unit = 180;
		double lat = 0;
		double lng = 0;
		int level = 1;
		int clen = code.length();
		for (int i = begin; i < clen; i++) {
			int n = "0123456789".indexOf(code.charAt(i));
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
		lat = 90 - lat;
		if (flg)
			lng -= 180;
		return new double[] { lat, lng, level, unit };
	}
	// lat, lng, level, unit
	public static double[] decodeInt(int code) {
		return decode(code < 0 ? "W" + -code : "E" + code);
	}
	// lat1, lng1, lat2, lng2, lat3, lng3, lat4, lng4
	public static double[] getCoords(String code) {
		double[] pos = decode(code);
		double x = pos[0];
		double y = pos[1];
		double u2 = pos[3] / 2;
		return new double[] {
			y - u2, x - u2,
			y - u2, x + u2,
			y + u2, x + u2,
			y + u2, x - u2
		};
	}
	// lat1, lng1, lat2, lng2, lat3, lng3, lat4, lng4
	public static double[] getCoordsInt(int code, int level) {
		double[] pos = decodeInt(code);
		double x = pos[0];
		double y = pos[1];
		// level
		double u2 = pos[3] / 2;
		return new double[] {
			y - u2, x - u2,
			y - u2, x + u2,
			y + u2, x + u2,
			y + u2, x - u2
		};
	}
	/*
	win.Geo3x3.ll2xy = function(lat, lng) {
		var x = lng * 111319.49079327355; // == 12756274 * Math.PI / 2
		var y = Math.log(Math.tan((90 + lat) * Math.PI / 360)) / (Math.PI / 180);
		y *= 111319.49079327355;
		return { "x" : x, "y" : y };
	};
	win.Geo3x3.xy2ll = function(x, y) {
		var lng = x / 111319.49079327355;
		var lat = y / 111319.49079327355;
		lat = 180 / Math.PI * (2 * Math.atan(Math.exp(lat * Math.PI / 180)) - Math.PI / 2);
		return { "lat" : lat, "lng" : lng };
	};
	*/
	// test
	public static void main(String[] args) {
//		String code = "E5379";
		String code = "W28644";
//		String code = "-28644";
		double[] res = decode(code);
		print(res);
		res = decodeInt(-28644);
		print(res);
		print(getCoords(code));
		for (int i = 0; i < 10; i++)
			System.out.println(encode(res[0], res[1], i));
	}
	static void print(double[] d) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < d.length; i++)
			sb.append(d[i] + ", ");
		sb.setLength(sb.length() - 2);
		System.out.println(sb);
	}
}

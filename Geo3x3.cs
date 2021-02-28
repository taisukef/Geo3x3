using System;
using System.Text;

public class Geo3x3 {
	public static String encode(double lat, double lng, int level) {
		if (level < 1)
			return null;
		StringBuilder res = new StringBuilder();
		if (lng >= 0) {
			res.Append('E');
		} else {
			res.Append('W');
//			res.append('-');
			lng += 180;
		}
		lat += 90;
		double unit = 180;
		for (int i = 1; i < level; i++) {
			unit /= 3;
			int x = (int)(lng / unit);
			int y = (int)(lat / unit);
			res.Append((char)('0' + x + y * 3 + 1));
			lng -= x * unit;
			lat -= y * unit;
		}
		return res.ToString();
	}
	// lat, lng, level, unit
	public static double[] decode(String code) {
		if (code == null || code.Length == 0)
			return null;
		int begin = 0;
		bool flg = false;
		char c = code[0];
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
		int clen = code.Length;
		for (int i = begin; i < clen; i++) {
			int n = "0123456789".IndexOf(code[i]);
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
			lng -= 180;
		return new double[] { lat, lng, level, unit };
	}
}

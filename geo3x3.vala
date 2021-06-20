class Geo3x3 {
    public static string encode(double lat, double lng, int level) {
        if (level < 1)
            return "";
        var res = new GLib.StringBuilder();
        if (lng >= 0.0) {
            res.append_c('E');
        } else {
            res.append_c('W');
            lng += 180.0;
        }
        lat += 90.0;
        double unit = 180.0;
        for (int i = 1; i < level; i++) {
            unit /= 3.0;
            int x = (int)GLib.Math.floor(lng / unit);
            int y = (int)GLib.Math.floor(lat / unit);
            res.append_c((char)('0' + x + y * 3 + 1));
            lng -= x * unit;
            lat -= y * unit;
        }
        return res.str;
    }
    public static double [] decode (string code ) {

        
        return {
	    1.1,
	    2.2,
	    3.3,
	    4.4
	};
    }
}

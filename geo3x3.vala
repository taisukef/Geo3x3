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
            var x = (int)GLib.Math.floor(lng / unit);
            var y = (int)GLib.Math.floor(lat / unit);
            res.append_c((char)('0' + x + y * 3 + 1));
            lng -= x * unit;
            lat -= y * unit;
        }
        return res.str;
    }
    public static double [] decode (string code) {
        if (code.length == 0)
            return {};
        int begin = 0;
        bool flg = false;
        unichar c = code.get_char(0);
        if (c == '-' || c == 'W') {
            flg = true;
            begin = 1;
        } else if (c == '+' || c == 'E') {
            begin = 1;
        }
        double unit = 180.0;
        double lat = 0.0;
        double lng = 0.0;
        int level = 1;
        int clen = code.length;
        for (int i = begin; i < clen; i++) {
            int n = "0123456789".index_of_char(code.get_char(i));
            if (n <= 0)
                break;
            unit /= 3.0;
            n--;
            lng += n % 3 * unit;
            lat += n / 3 * unit;
            level++;
        }
        lat += unit / 2.0;
        lng += unit / 2.0;
        lat -= 90.0;
        if (flg)
            lng -= 180.0;
        return {lat, lng, level, unit};
    }
}

import scala.math.floor
import scala.util.control.Breaks

object Geo3x3 {
    def encode(lat: Double, lng: Double, level: Int): String = {
        if (level < 1) {
            return null
        }
        var res = ""
        var lng2 = lng
        if (lng >= 0.0) {
            res = "E"
        } else {
            res = "W"
            lng2 += 180.0
        }
        var lat2 = 90.0 - lat // 0:the North Pole,  180:the South Pole
        var unit = 180.0
        for (i <- 1 to level - 1) {
            unit /= 3
            val x = floor(lng2 / unit).toInt
            val y = floor(lat2 / unit).toInt
            res += x + y * 3 + 1
            lng2 -= x * unit
            lat2 -= y * unit
        }
        return res
    }
    def decode(code: String): (Double, Double, Int, Double) = {
        if (code == null || code.length() == 0) {
            return null
        }
        var begin = 0
        var flg = false
        val c = code.charAt(0)
        if (c == '-' || c == 'W') {
            flg = true
            begin = 1
        } else if (c == '+' || c == 'E') {
            begin = 1
        }
        var unit = 180.0
        var lat = 0.0
        var lng = 0.0
        var level = 1
        val clen = code.length()
        val b = new Breaks
        b.breakable {
            for (i <- begin to clen - 1) {
                var n = "0123456789".indexOf(code.charAt(i));
                if (n <= 0) {
                    b.break
                }
                unit /= 3;
                n -= 1
                lng += n % 3 * unit;
                lat += n / 3 * unit;
                level += 1
            }
        }
        lat += unit / 2;
        lng += unit / 2;
        lat = 90.0 - lat;
        if (flg) {
            lng -= 180.0;
        }
        return (lat, lng, level, unit)
    }
    def main(args: Array[String]): Unit = {
        val code = encode(35.65858, 139.745433, 14)
        println(code)
        val (lat, lng, level, unit) = decode("E3793653391822")
        println(s"${lat} ${lng} ${level} ${unit}")
    }
}

class Geo3x3 {
    static encode(lat, lng, level) {
        if (level < 1) {
            return ""
        }
        var res = "E"
        if (lng < 0.0) {
            res = "W"
            lng = lng + 180.0
        }
        lat = lat + 90.0 // 180:the North Pole,  0:the South Pole
        var unit = 180.0
        for (i in 1...level) {
            unit = unit / 3.0
            var x = (lng / unit).floor
            var y = (lat / unit).floor
            res = res + (x + y * 3 + 1).toString
            lng = lng - x * unit
            lat = lat - y * unit
        }
        return res
    }
    static decode(code) {
        if (code.count == 0) {
            return null
        }
        var flg = code[0] == "W"
        var unit = 180.0
        var lat = 0.0
        var lng = 0.0
        var level = 1
        for (i in 1...code.count) {
            var n = "0123456789".indexOf(code[i])
            if (n == 0) {
                break
            }
            unit = unit / 3.0
            n = n - 1
            lng = lng + (n % 3) * unit
            lat = lat + (n / 3).floor * unit
            level = level + 1
        }
        lat = lat + unit / 2.0
        lng = lng + unit / 2.0
        lat = lat - 90.0
        if (flg) {
            lng = lng - 180.0
        }
        return [ lat, lng, level, unit ]
    }
}

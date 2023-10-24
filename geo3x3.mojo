from math import floor

struct Geo3x3:
    @staticmethod
    fn encode(lat: Float64, lng: Float64, level: Int) -> String:
        if level < 1:
            return ""
        let res = Pointer[UInt8].alloc(level)
        var plng = lng
        var plat = lat
        if lng >= 0:
            #res += "E"
            res.store(0, ord("E"))
        else:
            #res += "W"
            res.store(0, ord("W"))
            plng += 180
        plat += 90 # 180:the North Pole,  0:the South Pole
        var unit: Float64 = 180
        for i in range(1, level):
            unit /= 3
            let x = (plng / unit).cast[DType.int64]().to_int()
            let y = (plat / unit).cast[DType.int64]().to_int()
            #res += chr(ord("0") + x + y * 3 + 1)
            res.store(i, ord("0") + x + y * 3 + 1)
            plng -= x * unit
            plat -= y * unit
        
        var s = String()
        for i in range(level):
            let c = chr(res.load(i).to_int())
            s += c[0]   
        return s

    @staticmethod
    fn decode(code: String) -> (Float64, Float64, Int, Float64):
        let clen: Int = len(code)
        var unit: Float64 = 180
        var lat: Float64 = 0
        var lng: Float64 = 0
        var level: Int = 1
        if clen == 0:
            return (lat, lng, level, unit)
        var begin: Int = 0
        var flg: Bool = False
        let c = code[0]
        if c == '-' or c == 'W':
            flg = True
            begin = 1
        elif c == '+' or c == 'E':
            begin = 1
        for i in range(begin, clen):
            var n: Int = ord(code[i]) - ord("0")
            if n <= 0 or n > 9:
                break
            unit /= 3
            n -= 1
            lng += n % 3 * unit
            lat += n // 3 * unit
            level += 1
        lat += unit / 2
        lng += unit / 2
        lat -= 90
        if flg:
            lng -= 180
        return (lat, lng, level, unit)

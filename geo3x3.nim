proc encode*(lat: float, lng: float, level: int): string =
    if level < 1:
        return ""
    var res = ""
    var lng2 = lng
    if lng >= 0:
        res &= "E"
    else:
        res &= "W"
        lng2 += 180.0
    var lat2 = lat + 90.0 # 180:the North Pole,  0:the South Pole
    var unit = 180.0
    var i = 1
    while i < level:
        unit /= 3.0
        let x = int(lng2 / unit)
        let y = int(lat2 / unit)
        res &= chr(ord('0') + x + y * 3 + 1)
        lng2 -= float(x) * unit
        lat2 -= float(y) * unit
        i += 1
    return res

proc decode*(code: string): (float, float, int, float) =
    let clen = len(code)
    if clen == 0:
        raise
    var begin = 0
    var flg = false
    let c = code[0]
    if c == '-' or c == 'W':
        flg = true
        begin = 1
    elif c == '+' or c == 'E':
        begin = 1
    var unit = 180.0
    var lat = 0.0
    var lng = 0.0
    var level = 1
    var i: int = begin
    while i < clen:
        var n = "0123456789".find(code[i])
        if n <= 0:
            break
        unit /= 3
        n -= 1
        lng += (float)(n mod 3) * unit
        lat += (float)((int)(n / 3)) * unit
        level += 1
        i += 1
    lat += unit / 2.0
    lng += unit / 2.0
    lat -= 90.0
    if flg:
        lng -= 180.0
    return (lat, lng, level, unit)

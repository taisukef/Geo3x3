def encode(lat: float, lng: float, level: int):
    if level < 1:
        return null
    res = ""
    if lng >= 0:
        res += "E"
    else:
        res += "W"
        lng += 180
    lat = 90 - lat # // 0:the North Pole,  180:the South Pole
    unit = 180
    for i in range(1, level):
        unit /= 3
        x = int(lng / unit)
        y = int(lat / unit)
        res += chr(ord('0') + x + y * 3 + 1)
        lng -= x * unit
        lat -= y * unit
    return res

def decode(code):
    clen = len(code)
    if clen == 0:
        return null
    begin = 0
    flg = False
    c = code[0]
    if c == '-' or c == 'W':
        flg = True
        begin = 1
    elif c == '+' or c == 'E':
        begin = 1
    unit = 180
    lat = 0
    lng = 0
    level = 1
    for i in range(begin, clen):
        n = "0123456789".find(code[i])
        if n <= 0:
            break
        unit /= 3
        n -= 1
        lng += n % 3 * unit
        lat += n // 3 * unit
        level += 1
    lat += unit / 2
    lng += unit / 2
    lat = 90 - lat
    if flg:
        lng -= 180
    return (lat, lng, level, unit)

vim9script

def g:Geo3x3_encode(lat: float, lng: float, level: number): string
    var flng = lng
    var res = ""
    if flng >= 0.0
        res = "E"
    else
        res = "W"
        flng += 180.0
    endif
    var flat = lat + 90.0
    var unit = 180.0
    for i in range(1, level - 1)
        unit /= 3
        var x = float2nr(flng / unit)
        var y = float2nr(flat / unit)
        var n = x + y * 3 + 1
        res = res .. n
        flng -= x * unit
        flat -= y * unit
    endfor
    return res
enddef

def g:Geo3x3_decode(code: string): list<any>
    var fcode = code
    var clen = strlen(code)
    if clen > 0
        var flg = code[0] == "W"
        var unit = 180.0
        var lat = 0.0
        var lng = 0.0
        var level = 1
        for i in range(1, clen)
            var n = str2nr(code[i])
            if n == 0
                break
            endif
            unit /= 3
            n -= 1
            lng += float2nr(n % 3) * unit
            lat += float2nr(n / 3) * unit
            level += 1
        endfor
        if flg
            lng -= 180.0
        endif
        lat += unit / 2
        lng += unit / 2
        lat -= 90
        return [lat, lng, level, unit]
    endif
    return []
enddef

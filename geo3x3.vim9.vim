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
        const x = float2nr(flng / unit)
        const y = float2nr(flat / unit)
        const n = x + y * 3 + 1
        res = res .. n
        flng -= x * unit
        flat -= y * unit
    endfor
    return res
enddef

def g:Geo3x3_decode(code: string): list<any>
    const clen = strlen(code)
    if clen > 0
        const flg = code[0] == "W"
        var unit = 180.0
        var lat = 0.0
        var lng = 0.0
        var level = 1
        for i in range(1, clen)
            const n = str2nr(code[i]) - 1
            if n < 0
                break
            endif
            unit /= 3
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

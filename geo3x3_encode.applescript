on encodeGeo3x3(lat, lng, level)
    if level < 1 then
        return ""
    end if
    set res to ""
    set lng2 to lng
    if lng >= 0 then
        set res to "E"
    else
        set res to "W"
        set lng2 to lng2 + 180
    end if
    set lat2 to lat + 90.0
    set unit to 180.0
    repeat level - 1 times
        set unit to unit / 3
        set x to lng2 div unit
        set y to lat2 div unit
        set res to res & (x + y * 3 + 1)
        set lng2 to lng2 - x * unit
        set lat2 to lat2 - y * unit
    end repeat
    return res
end encodeGeo3x3

log encodeGeo3x3(35.65858, 139.745433, 14)

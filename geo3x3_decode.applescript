on decodeGeo3x3(code)
    set unit to 180.0
    set lat to 0.0
    set lng to 0.0
    set level to 1

    set begin to 0
    set flg to false
    set c to character 1 of code
    if c = "-" or c = "W" then
        set flg to true
        set begin to 1
    else if c = "+" or c = "E" then
        set begin to 1
    end if
    set clen to length of code
    repeat with i from begin to clen - 1
        set c to character (1 + i) of code 
        set n to c as integer
        if n <= 0 then
            break
        end if
        set unit to unit / 3
        set n to n - 1
        set lng to lng + n mod 3 * unit
        set lat to lat + n div 3 * unit
        set level to level + 1
    end repeat
    set lat to lat + unit / 2
    set lng to lng + unit / 2
    set lat to lat - 90.0
    if flg then
        set lng to lng - 180.0
    end if
    return { lat: lat, lng: lng, level: level, unit: unit }
end decodeGeo3x3

log decodeGeo3x3("E9139659937288")

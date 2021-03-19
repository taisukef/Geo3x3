geo3x3_encode := method(lat, lng, level,
    if (level < 1,
        "",
        if (lng >= 0.0,
            res := "E",
            res := "W"
            lng := lng + 180.0
        )
        lat := lat + 90.0
        unit := 180.0
        for(i, 1, level - 1,
            unit := unit / 3.0
            x := (lng / unit) floor
            y := (lat / unit) floor
            res := res .. (x + y * 3 + 1)
            lng := lng - x * unit
            lat := lat - y * unit
        )
        res
    )
)
geo3x3_decode := method(code,
    if(code size == 0
        list(0, 0, 0, 180),
        flg := code at(0) == 87 // W
        unit := 180.0
        lat := 0.0
        lng := 0.0
        level := 1
        for(i, 1, code size - 1,
            n := code at(i) - 49
            if(n < 0, break)
            unit := unit / 3.0
            lng := lng + (n % 3) * unit
            lat := lat + (n / 3) floor * unit
            level := level + 1
        )
        lat := lat + unit / 2.0
        lng := lng + unit / 2.0
        lat := lat - 90.0
        if(flg, lng := lng - 180.0)
        list(lat, lng, level, unit)
    )
)

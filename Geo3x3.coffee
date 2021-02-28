export class Geo3x3
    @encode: (lat, lng, level) ->
        if level < 1
            return ""
        if lng >= 0
            result = "E"
        else
            result = "W"
            lng += 180
        lat = 90 - lat
        unit = 180.0
        for i in [1 .. level]
            unit /= 3
            x = Math.floor(lng / unit)
            y = Math.floor(lat / unit)
            result += x + y * 3 + 1
            lng -= x * unit
            lat -= y * unit 
        result

    @decode: (code) ->
        if code.length == 0
            return null
        c = code[0]
        flg = false
        if c == "-" || c == "W"
            flg = true
            code = code.substr(1)
        else if c == "+" || c == "E"
            code = code.substr(1)

        unit = 180.0
        lat = 0.0
        lng = 0.0
        level = 1
        for c in code
            n = "123456789".indexOf(c)
            if n < 0
                break

            unit /= 3
            lng += Math.floor(n % 3) * unit
            lat += Math.floor(n / 3) * unit
            level++
        
        lat += unit / 2
        lng += unit / 2
        lat = 90 - lat
        if flg
            lng -= 180.0

        [lat, lng, level, unit]

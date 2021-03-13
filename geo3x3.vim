: fu Geo3x3_encode(lat, lng, level)
:   let lng = a:lng
:   if lng >= 0.0
:     let result = "E"
:   else
:     let result = "W"
:     let lng += 180.0
:   en
:   let lat = a:lat + 90.0
:   let unit = 180.0
:   for i in range(1, a:level - 1)
:     let unit /= 3
:     let x = float2nr(lng / unit)
:     let y = float2nr(lat / unit)
:     let n = x + y * 3 + 1
:     let result = result . n
:     let lng -= x * unit
:     let lat -= y * unit
:   endfor
:   return result
: endf

: fu Geo3x3_decode(code)
:   let code = a:code
:   let clen = strlen(code)
:   if clen > 0
:     let flg = code[0] == "W"
:     let unit = 180.0
:     let lat = 0.0
:     let lng = 0.0
:     let level = 1
:     for i in range(1, clen)
:       let n = float2nr(str2float(code[i]))
:       if n == 0
:         break
:       en
:       let unit = unit / 3
:       let n = n - 1
:       let lng = lng + float2nr(n % 3) * unit
:       let lat = lat + float2nr(n / 3) * unit
:       let level = level + 1
:     endfor
:     if flg
:       let lng = lng - 180.0
:     en
:     let lat = lat + unit / 2
:     let lng = lng + unit / 2
:     let lat = lat - 90
:     return [lat, lng, level, unit]
:   en
: endf

module Geo3x3
  function encode(lat, lng, level)
    if level < 1
      return null
    end
    res = ""
    if lng >= 0
      res = "E"
    else
      res = "W"
      lng += 180.0
    end
    lat += 90.0 # 180:the North Pole,  0:the South Pole
    unit = 180.0
    for i = 1:level - 1
      unit /= 3
      x = Int(floor(lng / unit))
      y = Int(floor(lat / unit))
      res = string(res, x + y * 3 + 1)
      lng -= x * unit
      lat -= y * unit
    end
    return res
  end

  function decode(code)
    clen = length(code)
    if clen == 0
      return null
    end
    beg = 0
    flg = false
    c = code[1]
    if c == '-' || c == 'W'
      flg = true
      beg = 1
    elseif c == '+' || c == 'E'
      beg = 1
    end
    unit = 180.0
    lat = 0.0
    lng = 0.0
    level = 1
    for i = beg:clen - 1
      n = Int(code[i + 1]) - 48
      if n < 1 || n > 9
        break
      end
      unit /= 3.0
      n -= 1
      lng += n % 3 * unit
      lat += floor(n / 3) * unit
      level += 1
    end
    lat += unit / 2.0
    lng += unit / 2.0
    lat -= 90.0
    if flg
      lng -= 180.0
    end
    return (lat, lng, level, unit)
  end
end

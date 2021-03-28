encode = (lat, lng, level) ->
  if level < 1
    return null
  res = ""
  if lng >= 0.0
    res = "E"
  else
    res = "W"
    lng = lng + 180.0
  lat += 90.0
  unit = 180.0

  for i = 1, level - 1
    unit = unit / 3
    x = math.floor(lng / unit)
    y = math.floor(lat / unit)
    res = res .. string.format("%d", x + y * 3 + 1)
    lng = lng - x * unit
    lat = lat - y * unit
  return res

decode = (code) ->
  c = string.sub(code, 1, 1)
  begin = 0
  flg = false
  if c == "-" or c == "W"
    flg = true
    begin = 1
  elseif c == "+" or c == "E"
    begin = 1
  unit = 180.0
  lat = 0.0
  lng = 0.0
  level = 1
  for i = begin, string.len(code) - 1
    n = tonumber(string.sub(code, i + 1, i + 1))
    if n == 0
      break
    unit = unit / 3
    n = n - 1
    lng = lng + math.floor(n % 3) * unit
    lat = lat + math.floor(n / 3) * unit
    level = level + 1
  lat = lat + unit / 2
  lng = lng + unit / 2
  lat -= 90.0
  if flg
    lng = lng - 180.0
  return {lat, lng, level, unit}

{ :encode, :decode }

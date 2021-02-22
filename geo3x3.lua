local geo3x3 = {}

geo3x3.encode = function(lat, lng, level)
  if level < 1 then
    return null
  end
  res = ""
  if lng >= 0.0 then
    res = "E"
  else
    res = "W"
    lng = lng + 180.0
  end
  lat = 90.0 - lat
  unit = 180.0

  for i = 1, level - 1 do
    unit = unit / 3
    x = math.floor(lng / unit)
    y = math.floor(lat / unit)
    res = res .. string.format("%d", x + y * 3 + 1)
    lng = lng - x * unit
    lat = lat - y * unit
  end
  return res
end

geo3x3.decode = function(code)
  c = string.sub(code, 1, 1)
  begin = 0
  flg = false
  if c == "-" or c == "W" then
    flg = true
    begin = 1
  elseif c == "+" or c == "E" then
    begin = 1
  end
  unit = 180.0
  lat = 0.0
  lng = 0.0
  level = 1
  for i = begin, string.len(code) - 1 do
    n = tonumber(string.sub(code, i + 1, i + 1))
    if n == 0 then
      break
    end
    unit = unit / 3
    n = n - 1
    lng = lng + math.floor(n % 3) * unit
    lat = lat + math.floor(n / 3) * unit
    level = level + 1
  end
  lat = lat + unit / 2
  lng = lng + unit / 2
  lat = 90.0 - lat
  if flg then
    lng = lng - 180.0
  end
  return {lat, lng, level, unit}
end

return geo3x3

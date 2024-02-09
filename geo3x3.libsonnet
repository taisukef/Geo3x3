local encode_fn = function(code, level, i, lat, lng, unit)
  if i >= level then
    code
  else
    encode_fn(
      code + (std.floor(lng / unit) + std.floor(lat / unit) * 3 + 1),
      level,
      i + 1,
      lat - unit * std.floor(lat / unit),
      lng - unit * std.floor(lng / unit),
      unit / 3.0
    )
;

local _encode = function(lat, lng, level)
  encode_fn(
    if lng < 0.0 then "W" else "E",
    level,
    1,
    lat + 90.0,
    if lng < 0.0 then lng + 180.0 else lng,
    180.0 / 3.0
  )
;

local decode_fn = function(code, lat, lng, level, unit, wflg)
  if std.length(code) == level then
    {
      lat: -90.0 + (lat + unit * 3.0 / 2.0),
      lng: if wflg then
          (lng + unit * 3.0 / 2.0) - 180.0
        else
          lng + unit * 3.0 / 2.0,
      level: level,
      unit: unit * 3.0,
    }
  else
    local n = std.parseInt(code[level]) - 1;
    decode_fn(
      code,
      lat + std.floor(n / 3) * unit,
      lng + n % 3 * unit,
      level + 1,
      unit / 3.0,
      wflg
    )
;

local _decode = function(code)
  if code[0] == "W" then
    decode_fn(code, 0.0, 0.0, 1, 180.0 / 3.0, true)
  else
    decode_fn(code, 0.0, 0.0, 1, 180.0 / 3.0, false)
;

{
  encode: function(lat, lng, level) _encode(lat, lng, level),
  decode: function(code) _decode(code),
}

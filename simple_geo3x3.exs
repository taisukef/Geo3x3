Code.require_file("geo3x3.ex")

## get Geo3x3 code from latitude / longitude / level
code = Geo3x3.encode(35.65858, 139.745433, 14)
IO.inspect(code)

## get location from Geo3x3 code
pos = Geo3x3.decode("E9139659937288")
IO.inspect(pos)

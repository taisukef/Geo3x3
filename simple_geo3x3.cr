require "./Geo3x3"

## get Geo3x3 code from latitude / longitude / level
code = Geo3x3.encode(35.65858, 139.745433, 14)
puts code

## get location from Geo3x3 code
pos = Geo3x3.decode("E9139659937288")
puts pos

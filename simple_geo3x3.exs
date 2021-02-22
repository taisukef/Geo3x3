Code.require_file("geo3x3.ex")

## get Geo3x3 code from latitude / longitude / level
code = Geo3x3.encode(35.65858, 139.745433, 14)
IO.inspect(code) # "E3793653391822"

## get location from Geo3x3 code
pos = Geo3x3.decode("E3793653391822")
IO.inspect(pos) # [35.658633790016204, 139.74546563023935, 14, 0.00011290058538953522]

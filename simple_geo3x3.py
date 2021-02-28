import geo3x3

## get Geo3x3 code from latitude / longitude / level
code = geo3x3.encode(35.65858, 139.745433, 14)
print(code)

## get location from Geo3x3 code
pos = geo3x3.decode('E9139659937288')
print(pos)

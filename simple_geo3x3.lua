local geo3x3 = require("geo3x3")

print(geo3x3.encode(35.65858, 139.745433, 14))

pos = geo3x3.decode("E3793653391822")
print(pos[1], pos[2], pos[3], pos[4])


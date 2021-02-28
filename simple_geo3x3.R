source("Geo3x3.R")

code <- Geo3x3_encode(35.65858, 139.745433, 14)
print(code)

pos <- Geo3x3_decode("E9139659937288")
print(pos)

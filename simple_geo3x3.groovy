final code = Geo3x3.encode(35.65858, 139.745433, 14)
println code

final res = Geo3x3.decode("E9139659937288")
println(res[0] + " " + res[1] + " " + res[2] + " " + res[3])

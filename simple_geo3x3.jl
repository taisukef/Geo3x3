include("Geo3x3.jl")

code = Geo3x3.encode(35.65858, 139.745433, 14)
println(code)

pos = Geo3x3.decode("E9139659937288")
println(pos)

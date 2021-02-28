module simple_geo3x3
open Geo3x3

let code = Geo3x3.encode 35.65858 139.745433 14
printfn "%s" code

let (lat, lng, level, unit) = Geo3x3.decode "E9139659937288"
printfn "%f %f %d %f" lat lng level unit

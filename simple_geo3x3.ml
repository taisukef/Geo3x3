open String;;

let code = Geo3x3.encode 35.65858 139.745433 14;;
print_endline code;;

let (lat, lng, level, unit) = Geo3x3.decode "E9139659937288";;
print_endline (String.concat " " [string_of_float lat; string_of_float lng; string_of_int level; string_of_float unit]);;

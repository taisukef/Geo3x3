import geo3x3

fn main() {
    code := geo3x3.encode(35.65858, 139.745433, 14)
    println(code)
    
    lat, lng, level, unit := geo3x3.decode("E9139659937288")
    println('$lat $lng $level $unit')
}

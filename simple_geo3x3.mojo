from geo3x3 import Geo3x3

fn main():
    ## get Geo3x3 code from latitude / longitude / level
    let code = Geo3x3.encode(35.65858, 139.745433, 14)
    print(code)

    ## get location from Geo3x3 code
    let lat: Float64
    let lng: Float64
    let level: Int
    let unit: Float64
    (lat, lng, level, unit) = Geo3x3.decode("E9139659937288")
    print(lat, lng, level, unit)

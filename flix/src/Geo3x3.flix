namespace Geo3x3 {
    def encode_fn(code: String, level: Int32, i: Int32, lat: Float64, lng: Float64, unit: Float64): String =
        if (i >= level)
            code
        else
            encode_fn(
                "${code}${1
                    + Float64.clampToInt32(Float64.floor(lng / unit), 0, 2, 0)
                    + Float64.clampToInt32(Float64.floor(lat / unit), 0, 2, 0) * 3
                }",
                level,
                i + 1,
                lat - Float64.floor(lat / unit) * unit,
                lng - Float64.floor(lng / unit) * unit,
                unit / 3.0
            )
    
    pub def encode(lat: Float64, lng: Float64, level: Int32): String & Pure =
        if (level < 1)
            ""
        else
            encode_fn(
                match lng {
                    case _ if lng >= 0.0 => "E"
                    case _ if lng < 0.0 => "W"
                },
                level,
                1,
                lat + 90.0,
                match lng {
                    case _ if lng >= 0.0 => lng
                    case _ if lng < 0.0 => lng + 180.0
                },
                180.0 / 3.0
            )
    

    def decode_fn(code: String, lat: Float64, lng: Float64, level: Int32, unit: Float64): (Float64, Float64, Int32, Float64) =
        if (String.length(code) == 0)
            (lat + unit * 3.0 / 2.0 - 90.0, lng + unit * 3.0 / 2.0, level, unit * 3.0)
        else
            let n = Char.toInt32(String.charAt(0, code)) - Char.toInt32('1');
            decode_fn(
                String.dropLeft(1, code),
                lat + Int32.toFloat64(n / 3) * unit,
                lng + Int32.toFloat64(n mod 3) * unit,
                level + 1,
                unit / 3.0
            )

    def decode_fne(code: String): (Float64, Float64, Int32, Float64) =
        decode_fn(code, 0.0, 0.0, 1, 180.0 / 3.0)

    def decode_fnw(code: String): (Float64, Float64, Int32, Float64) =
        let (lat, lng, level, unit) = decode_fne(code);
        (lat, lng - 180.0, level, unit)
    
    pub def decode(code: String): (Float64, Float64, Int32, Float64) =
        if (String.length(code) == 0)
            (0.0, 0.0, 0, 180.0)
        else
            let n = String.charAt(0, code);
            match n {
                case _ if n == 'W' => decode_fnw(String.dropLeft(1, code))
                case _ if n == 'E' => decode_fne(String.dropLeft(1, code))
            }
}

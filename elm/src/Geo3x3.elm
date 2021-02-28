module Geo3x3 exposing (..)

encode_fn : String -> Int -> Int -> Float -> Float -> Float -> String
encode_fn code level i lat lng unit =
    if i >= level then
        code
    else
        let
            x = floor (lng / unit)
            y = floor (lat / unit)
        in
        encode_fn
            (code ++ String.fromInt (1 + x + y * 3))
            level
            (i + 1)
            (lat - toFloat y * unit)
            (lng - toFloat x * unit)
            (unit / 3.0)

encode : Float -> Float -> Int -> String
encode lat lng level =
    if level < 1 then
        ""
    else
        encode_fn
            (if lng >= 0.0 then "E" else "W")
            level
            1
            (lat + 90.0)
            (if lng >= 0.0 then lng else lng + 180.0)
            (180.0 / 3.0)

is_1to9 : Char -> Bool
is_1to9 c =
    c >= '1' && c <= '9'

decode_fn : List Char -> Float -> Float -> Int -> Float -> { lat : Float, lng : Float, level : Int, unit : Float }
decode_fn code lat lng level unit =
    let
        c = Maybe.withDefault '0' (List.head code)
    in
    if not (is_1to9 c) then
        let
            unit0 = unit * 3.0
        in
            { lat = (lat + unit0 / 2.0) - 90.0, lng = lng + unit0 / 2.0, level = level, unit = unit0 }
    else
        let
            n = Char.toCode c - 49
        in
        decode_fn
            (Maybe.withDefault [] (List.tail code))
            (lat + toFloat (n // 3) * unit)
            (lng + toFloat (remainderBy 3 n) * unit)
            (level + 1)
            (unit / 3.0)

decode_fne : List Char -> { lat : Float, lng : Float, level : Int, unit : Float }
decode_fne code =
    decode_fn code 0.0 0.0 1 (180.0 / 3.0)

decode_fnw : List Char -> { lat : Float, lng : Float, level : Int, unit : Float }
decode_fnw code =
    let
        pos = decode_fne code
    in
    { lat = 180.0 - pos.lat, lng = pos.lng, level = pos.level, unit = pos.unit }


decode : String -> { lat : Float, lng : Float, level : Int, unit : Float }
decode scode =
    let
        code = String.toList scode
    in
    if List.length code == 0 then
        { lat = 0.0, lng = 0.0, level = 0, unit = 180.0 } -- err
    else
        let
            tcode = Maybe.withDefault [] (List.tail code)
        in
        case Maybe.withDefault '_' (List.head code) of
            'W' -> decode_fnw tcode
            '-' -> decode_fnw tcode
            'E' -> decode_fne tcode
            '+' -> decode_fne tcode
            _ -> decode_fne code

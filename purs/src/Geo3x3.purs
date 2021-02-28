module Geo3x3 (encode, decode) where

import Prelude (mod, not, show, (&&), (*), (+), (-), (/), (<), (<=), (<>), (==), (>=))
import Data.Int (toNumber, floor)
import Data.String (codePointFromChar, length, uncons)
import Data.Maybe (fromMaybe)
import Data.Enum (fromEnum)

encode_fn :: String -> Int -> Int -> Number -> Number -> Number -> String
encode_fn code level i lat lng unit =
    if i >= level then
        code
    else
        let
            x = floor (lng / unit)
            y = floor (lat / unit)
        in
        encode_fn
            (code <> show (1 + x + y * 3))
            level
            (i + 1)
            (lat - toNumber y * unit)
            (lng - toNumber x * unit)
            (unit / 3.0)

encode :: Number -> Number -> Int -> String
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

is_1to9 :: Int -> Boolean
is_1to9 c =
    c >= 49 && c <= (49 + 9) -- '1' - '9'

decode_fn :: String -> Number -> Number -> Int -> Number -> { lat :: Number, lng :: Number, level :: Int, unit :: Number }
decode_fn code lat lng level unit =
    let
        { head: c, tail: tcode } = fromMaybe { head: codePointFromChar '_', tail: "" } (uncons code)
        c2 = (fromEnum c)
    in
    if not (is_1to9 c2) then
        let
            unit0 = unit * 3.0
        in
            { lat:  (lat + unit0 / 2.0) - 90.0, lng: lng + unit0 / 2.0, level: level, unit: unit0 }
    else
        let
            n = c2 - 49
        in
        decode_fn
            tcode
            (lat + toNumber (n / 3) * unit)
            (lng + toNumber (mod n 3) * unit)
            (level + 1)
            (unit / 3.0)

decode_fne :: String -> { lat :: Number, lng :: Number, level :: Int, unit :: Number }
decode_fne code =
    decode_fn code 0.0 0.0 1 (180.0 / 3.0)

decode_fnw :: String -> { lat :: Number, lng :: Number, level :: Int, unit :: Number }
decode_fnw code =
    let
        pos = decode_fne code
    in
    { lat: 180.0 - pos.lat, lng: pos.lng, level: pos.level, unit: pos.unit }

decode :: String -> { lat :: Number, lng :: Number, level :: Int, unit :: Number }
decode code =
    if length code == 0 then
        { lat: 0.0, lng: 0.0, level: 0, unit: 180.0 } -- err
    else
        let
            { head: c, tail: tcode } = fromMaybe { head: codePointFromChar '_', tail: "" } (uncons code)
        in
        case fromEnum c of
            87 -> decode_fnw tcode -- 'W'
            45 -> decode_fnw tcode -- '-'
            69 -> decode_fne tcode -- 'E'
            43 -> decode_fne tcode -- '+'
            _ -> decode_fne code

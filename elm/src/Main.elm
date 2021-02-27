module Main exposing (main)

import Geo3x3 exposing (decode, encode)
import Html exposing (Html, div, text)

main : Html msg
main =
    div []
        [
            div [] [ text (encode 35.65858 139.745433 14) ],
            div [] [ text (
                let
                    pos = decode "E3793653391822"
                in
                (String.fromFloat pos.lat ++ " " ++ String.fromFloat pos.lng ++ " " ++ String.fromInt pos.level)
            )]
        ]

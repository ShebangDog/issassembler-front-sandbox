module Palette exposing (..)


type Color
    = TurkishRose
    | Apache
    | FlatBlue


toHex : Color -> String
toHex color =
    case color of
        TurkishRose ->
            "#BF6F94"

        Apache ->
            "#DFC370"

        FlatBlue ->
            "#3F76A6"

module Color exposing (DisplayMode(..), defaultTheme, displayModeSet, fromString, palette, theme, toString)

import Css


palette : { turkishRose : Css.Color, apache : Css.Color, flatBlue : Css.Color }
palette =
    { turkishRose = Css.hex "#BF6F94"
    , apache = Css.hex "#DFC370"
    , flatBlue = Css.hex "#3F76A6"
    }


type alias Theme =
    { primary : Css.Color
    , secondary : Css.Color
    , tertiary : Css.Color
    }


defaultTheme : Theme
defaultTheme =
    { primary = palette.turkishRose
    , secondary = palette.flatBlue
    , tertiary = palette.apache
    }


lightTheme : Theme
lightTheme =
    defaultTheme


darkTheme : Theme
darkTheme =
    { primary = palette.apache
    , secondary = palette.flatBlue
    , tertiary = palette.turkishRose
    }


type DisplayMode
    = Default
    | Light
    | Dark


theme : DisplayMode -> Theme
theme mode =
    case mode of
        Default ->
            defaultTheme

        Light ->
            lightTheme

        Dark ->
            darkTheme


displayModeSet : List DisplayMode
displayModeSet =
    [ Default
    , Light
    , Dark
    ]


fromString : String -> Maybe DisplayMode
fromString displayMode =
    displayModeSet
        |> List.filter (\mode -> toString mode == displayMode)
        |> List.head


toString : DisplayMode -> String
toString mode =
    case mode of
        Default ->
            "default"

        Light ->
            "light"

        Dark ->
            "dark"

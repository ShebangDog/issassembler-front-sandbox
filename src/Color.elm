module Color exposing (DisplayMode(..), Theme, defaultTheme, displayModeSet, fromString, palette, suite, theme, toString)

import Css
import Expect
import Test exposing (Test, describe, test)


palette : { cerisePink : Css.Color, pinkSherbet : Css.Color, apache : Css.Color, flatBlue : Css.Color, white : Css.Color, black : Css.Color }
palette =
    { cerisePink = Css.hex "#EC407A"
    , pinkSherbet = Css.hex "#F48FB1"
    , apache = Css.hex "#DFC370"
    , flatBlue = Css.hex "#3F76A6"
    , white = Css.hex "#FFFFFF"
    , black = Css.hex "#000000"
    }


type alias Theme =
    { primary : Css.Color
    , primaryBright : Css.Color
    , onPrimary : Css.Color
    , background : Css.Color
    , secondary : Css.Color
    , tertiary : Css.Color
    }


defaultTheme : Theme
defaultTheme =
    { primary = palette.cerisePink
    , primaryBright = palette.pinkSherbet
    , secondary = palette.flatBlue
    , tertiary = palette.apache
    , onPrimary = palette.white
    , background = palette.white
    }


lightTheme : Theme
lightTheme =
    defaultTheme


darkTheme : Theme
darkTheme =
    { primary = palette.apache

    -- TODO(色決める)
    , primaryBright = palette.apache
    , secondary = palette.flatBlue
    , tertiary = palette.cerisePink
    , onPrimary = palette.white
    , background = palette.black
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



-- Test


suite : Test
suite =
    describe "Color module"
        [ describe "toString"
            [ test "toStringがDefault受け取ったとき、`default`を返すこと" (\() -> Expect.equal (toString Default) "default")
            , test "toStringがLight受け取ったとき、`light`を返すこと" (\() -> Expect.equal (toString Light) "light")
            , test "toStringがDark受け取ったとき、`dark`を返すこと" (\() -> Expect.equal (toString Dark) "dark")
            ]
        , describe "fromString"
            [ test "fromStringが`default`受け取ったとき、Just Defaultを返すこと" (\() -> Expect.equal (fromString "default") (Just Default))
            , test "fromStringが`light`受け取ったとき、Just Lightを返すこと" (\() -> Expect.equal (fromString "light") (Just Light))
            , test "fromStringが`dark`受け取ったとき、Just Darkを返すこと" (\() -> Expect.equal (fromString "dark") (Just Dark))
            , test "fromStringが`nothing`受け取ったとき、Nothingを返すこと" (\() -> Expect.equal (fromString "nothing") Nothing)
            ]
        , describe "displayModeSet"
            [ test "displayModeSetに全てのvariantが存在すること" (\() -> Expect.equal displayModeSet [ Default, Light, Dark ])
            ]
        , describe "theme"
            [ test "themeがDefaultを受け取ったとき、defaultThemeを返すこと" (\() -> Expect.equal (theme Default) defaultTheme)
            , test "themeがLightを受け取ったとき、lightThemeを返すこと" (\() -> Expect.equal (theme Light) lightTheme)
            , test "themeがDarkを受け取ったとき、darkThemeを返すこと" (\() -> Expect.equal (theme Dark) darkTheme)
            ]
        ]

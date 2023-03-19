module Color exposing (DisplayMode(..), defaultTheme, displayModeSet, fromString, palette, suite, theme, toString)

import Css
import Expect
import Test exposing (Test, describe, test)


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



-- テスト


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

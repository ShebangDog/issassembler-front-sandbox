module DisplayModeIcon exposing (..)

import Color
import Css
import Css.Global exposing (path)
import Html.Styled exposing (img)
import Html.Styled.Attributes exposing (css, src)


view : Color.DisplayMode -> Html.Styled.Html msg
view displayMode =
    let
        path =
            "../"
                ++ (case displayMode of
                        Color.Default ->
                            "../assets/earth.png"

                        Color.Light ->
                            "../assets/sun.png"

                        Color.Dark ->
                            "../assets/moon.png"
                   )

        icon =
            img
                [ src path
                , css [ Css.width (Css.px 24) ]
                ]
                []
    in
    icon

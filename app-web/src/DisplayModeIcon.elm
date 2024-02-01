module DisplayModeIcon exposing (..)

import Browser
import Color
import Css
import Css.Global exposing (path)
import Html.Styled exposing (Html, img)
import Html.Styled.Attributes exposing (css, src)



-- Implement


view : Color.DisplayMode -> Html.Styled.Html msg
view displayMode =
    let
        path =
            (case displayMode of
                Color.Default ->
                    "/assets/earth.png"

                Color.Light ->
                    "/assets/sun.png"

                Color.Dark ->
                    "/assets/moon.png"
            )

        icon =
            img
                [ src path
                , css [ Css.width (Css.px 24) ]
                ]
                []
    in
    icon



-- Preview


init : ()
init =
    ()


main : Program () () ()
main =
    Browser.sandbox
        { init = init
        , view = preview >> Html.Styled.toUnstyled
        , update = update
        }


update : () -> () -> ()
update _ _ =
    ()


preview : () -> Html msg
preview _ =
    Html.Styled.div
        []
        (List.map
            view
            Color.displayModeSet
        )

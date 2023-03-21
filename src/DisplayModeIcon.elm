module DisplayModeIcon exposing (..)

import Browser
import Color
import Css
import Css.Global exposing (path)
import Html.Styled exposing (Html, img)
import Html.Styled.Attributes exposing (css, src)
import Svg.Styled.Attributes exposing (mode)



-- Implement


type alias Model a =
    { a
        | displayMode : Color.DisplayMode
    }


view : Model a -> Html.Styled.Html msg
view model =
    let
        path =
            "../"
                ++ (case model.displayMode of
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



-- Preview


type alias PreviewModel =
    Model {}


init : PreviewModel
init =
    { displayMode = Color.Default
    }


main : Program () PreviewModel ()
main =
    Browser.sandbox
        { init = init
        , view = preview >> Html.Styled.toUnstyled
        , update = update
        }


update : () -> PreviewModel -> PreviewModel
update _ model =
    model


preview : PreviewModel -> Html msg
preview _ =
    Html.Styled.div
        []
        (List.map
            (\mode -> view { displayMode = mode })
            Color.displayModeSet
        )

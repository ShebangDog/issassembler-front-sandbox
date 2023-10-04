module Loading exposing (Model, view)

import Browser
import Css
import Css.Animations
import GlobalStyle
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (css)



-- Implement


type alias Model =
    { span : Int
    }


view : Model -> Html msg
view model =
    div
        [ css
            [ Css.width (Css.px 48)
            , Css.height (Css.px 48)
            , Css.property "background-image" "conic-gradient(red 140deg, black 140deg, transparent 360deg)"
            , Css.borderRadius (Css.pct 50)
            , Css.position Css.relative
            , Css.property "animation-timing-function" "linear"
            , Css.animationName animateSpinner
            , Css.animationDuration (Css.sec 1)
            , Css.animationIterationCount Css.infinite
            ]
        ]
        [ div
            [ css
                [ Css.position Css.absolute
                , Css.batch <| List.map (\edge -> edge (Css.pct 10)) [ Css.left, Css.right, Css.top, Css.bottom ]
                , Css.backgroundColor (Css.hex "000000")
                , Css.borderRadius (Css.pct 50)
                ]
            ]
            []
        ]


animateSpinner : Css.Animations.Keyframes {}
animateSpinner =
    Css.Animations.keyframes
        [ ( 0
          , [ Css.Animations.transform [ Css.rotate (Css.deg 0) ]
            ]
          )
        , ( 100
          , [ Css.Animations.transform [ Css.rotate (Css.deg 360) ]
            ]
          )
        ]



-- Preview


init : Model
init =
    { span = 0
    }


main : Program () Model ()
main =
    Browser.sandbox
        { init = init
        , view = preview >> Html.Styled.toUnstyled
        , update = update
        }


update : () -> Model -> Model
update _ model =
    model


preview : Model -> Html msg
preview model =
    Html.Styled.div
        []
        [ GlobalStyle.stopAnimation
        , view model
        ]

module Loading exposing (Model, view)

import Css
import Css.Animations
import Html.Styled exposing (Html)
import Html.Styled.Attributes


type alias Model =
    { span : Int
    }


view : Model -> Html msg
view model =
    Html.Styled.div
        [ Html.Styled.Attributes.css
            [ Css.width (Css.px 48)
            , Css.height (Css.px 36)
            , Css.property "background-image" "conic-gradient(blue 140deg, black 140deg, transparent 360deg)"
            , Css.borderRadius (Css.pct 50)
            , Css.position Css.relative
            , Css.property "animation-timing-function" "linear"
            , Css.animationName animateSpinner
            , Css.animationDuration (Css.sec 1)
            , Css.animationIterationCount Css.infinite
            ]
        ]
        [ Html.Styled.div
            [ Html.Styled.Attributes.css
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

module GlobalStyle exposing (..)

import Css
import Css.Animations
import Css.Global
import Html.Styled exposing (Html)


stopAnimation : Html msg
stopAnimation =
    Css.Global.global
        [ Css.Global.selector "*" <|
            List.map Css.important
                [ Css.animationName (Css.Animations.keyframes [])
                ]
        ]

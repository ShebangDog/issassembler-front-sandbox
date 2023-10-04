module DisplayModeSelectableItem exposing (view)

import Browser
import Color
import Css
import DisplayModeIcon
import Html.Styled exposing (li, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)



-- Implement


view : Color.Theme -> List Css.Style -> Color.DisplayMode -> (Color.DisplayMode -> msg) -> Html.Styled.Html msg
view theme style displayMode consumeDisplayMode =
    let
        mergedStyle =
            List.concat
                [ [ Css.displayFlex
                  , Css.flexDirection Css.row
                  , Css.alignItems Css.center
                  , Css.cursor Css.pointer
                  ]
                , style
                ]

        item =
            li
                [ css mergedStyle
                , onClick (consumeDisplayMode displayMode)
                ]
                [ DisplayModeIcon.view displayMode
                , text (Color.toString displayMode)
                ]
    in
    item



-- Preview


init : ()
init =
    ()


main : Program () () Msg
main =
    Browser.sandbox
        { init = init
        , view = preview >> Html.Styled.toUnstyled
        , update = update
        }


type Msg
    = A


update : Msg -> () -> ()
update _ _ =
    ()


preview : () -> Html.Styled.Html Msg
preview _ =
    view Color.defaultTheme [] Color.Default (\_ -> A)

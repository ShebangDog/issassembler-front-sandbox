module DisplayModeDropDown exposing (..)

import Browser
import Color
import Css
import DisplayModeSelectableItem
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (css)



-- Implement


view : List Css.Style -> Color.Theme -> (Color.DisplayMode -> msg) -> Html.Styled.Html msg
view style theme clickedAction =
    let
        mergedStyle =
            List.concat
                [ style
                , [ Css.backgroundColor theme.primaryBright
                  ]
                ]

        selectableItemModelList =
            List.map (\mode -> DisplayModeSelectableItem.view theme [ Css.padding (Css.px 8) ] mode clickedAction) Color.displayModeSet
    in
    div
        [ css mergedStyle
        ]
        selectableItemModelList



-- Preview


type Msg
    = None


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


update : Msg -> () -> ()
update _ _ =
    ()


preview : () -> Html Msg
preview _ =
    Html.Styled.div
        [ css [ Css.width (Css.px 120) ] ]
        [ view [] Color.defaultTheme (\_ -> None)
        ]

module DisplayModeDropDown exposing (..)

import Color
import Css
import DisplayModeSelectableItem
import Html.Styled exposing (div)
import Html.Styled.Attributes exposing (css)


view : List Css.Style -> Color.Theme -> (Color.DisplayMode -> msg) -> Html.Styled.Html msg
view style theme clickedAction =
    let
        mergedStyle =
            List.concat
                [ style
                , [ Css.backgroundColor theme.primaryBright
                  , Css.transform (Css.translateY (Css.px 4))
                  ]
                ]

        selectableItemModelList =
            List.map (\mode -> DisplayModeSelectableItem.view theme [ Css.padding (Css.px 8) ] mode clickedAction) Color.displayModeSet
    in
    div
        [ css mergedStyle
        ]
        selectableItemModelList

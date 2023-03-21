module DisplayModeDropDown exposing (..)

import Browser
import Color
import Css
import DisplayModeSelectableItem
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (css)



-- Implement


type alias Model a msg =
    { a
        | theme : Color.Theme
        , handleItemSelected : Color.DisplayMode -> msg
    }


view : List Css.Style -> Model a msg -> Html.Styled.Html msg
view style model =
    let
        mergedStyle =
            List.concat
                [ style
                , [ Css.backgroundColor model.theme.primaryBright
                  ]
                ]

        selectableItemView mode =
            DisplayModeSelectableItem.view
                [ Css.padding (Css.px 8) ]
                { theme = model.theme
                , handleSelected = model.handleItemSelected
                , displayMode = mode
                }

        selectableItemModelList =
            List.map selectableItemView Color.displayModeSet
    in
    div
        [ css mergedStyle
        ]
        selectableItemModelList



-- Preview


type Msg
    = None


type alias PreviewModel =
    Model {} Msg


init : PreviewModel
init =
    { theme = Color.defaultTheme
    , handleItemSelected = \_ -> None
    }


main : Program () PreviewModel Msg
main =
    Browser.sandbox
        { init = init
        , view = preview >> Html.Styled.toUnstyled
        , update = update
        }


update : Msg -> PreviewModel -> PreviewModel
update _ model =
    model


preview : PreviewModel -> Html Msg
preview model =
    Html.Styled.div
        [ css [ Css.width (Css.px 120) ] ]
        [ view [] model
        ]

module DisplayModeSelectableItem exposing (view)

import Browser
import Color
import Css
import DisplayModeIcon
import Html.Styled exposing (li, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)



-- Implement


type alias Model a msg =
    { a
        | theme : Color.Theme
        , displayMode : Color.DisplayMode
        , handleSelected : Color.DisplayMode -> msg
    }


view : List Css.Style -> Model a msg -> Html.Styled.Html msg
view style model =
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
                , onClick (model.handleSelected model.displayMode)
                ]
                [ DisplayModeIcon.view model
                , text (Color.toString model.displayMode)
                ]
    in
    item



-- Preview


type Msg
    = None


type alias PreviewModel =
    Model {} Msg


init : PreviewModel
init =
    { theme = Color.defaultTheme
    , displayMode = Color.Default
    , handleSelected = \_ -> None
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


preview : PreviewModel -> Html.Styled.Html Msg
preview model =
    view [] model

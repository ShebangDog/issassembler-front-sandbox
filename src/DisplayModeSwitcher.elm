module DisplayModeSwitcher exposing (view)

import Browser
import Color
import Css
import DisplayModeDropDown
import DisplayModeIcon
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import None
import OpenState exposing (OpenState(..))



-- Implement


type alias Model a msg =
    { a
        | theme : Color.Theme
        , displayMode : Color.DisplayMode
        , openState : OpenState
        , handleItemSelected : Color.DisplayMode -> msg
        , switchOpenState : OpenState.OpenState -> msg
    }


view : Model a msg -> Html.Styled.Html msg
view model =
    let
        dropDown =
            DisplayModeDropDown.view
                [ Css.position Css.absolute
                , Css.top (Css.pct 100)
                , Css.transform (Css.translateY (Css.px 4))
                ]
                { model | handleItemSelected = model.handleItemSelected }

        overlay =
            div
                [ css
                    [ Css.position Css.absolute
                    , Css.width (Css.pct 100)
                    , Css.height (Css.pct 100)
                    , Css.top (Css.px 0)
                    , Css.left (Css.px 0)
                    ]
                , onClick (model.switchOpenState model.openState)
                ]
                []

        ( dropDownView, overlayView ) =
            case model.openState of
                Open ->
                    ( dropDown, overlay )

                Close ->
                    ( None.view, None.view )

        colorStyle =
            Css.batch
                [ case model.openState of
                    OpenState.Open ->
                        Css.backgroundColor model.theme.primaryBright

                    OpenState.Close ->
                        Css.backgroundColor Css.transparent
                , Css.hover
                    [ Css.backgroundColor model.theme.primaryBright
                    ]
                ]

        indicatorView =
            div
                [ onClick (model.switchOpenState model.openState)
                , css
                    [ Css.displayFlex
                    , Css.flexDirection Css.row
                    , Css.alignItems Css.center
                    , Css.position Css.relative
                    , Css.height (Css.pct 100)
                    , Css.cursor Css.pointer
                    , colorStyle
                    ]
                ]
                [ DisplayModeIcon.view model
                , text "Theme"
                , dropDownView
                ]
    in
    div [] [ overlayView, indicatorView ]



-- Preview


type Msg
    = None


type alias PreviewModel =
    Model {} Msg


init : PreviewModel
init =
    { theme = Color.defaultTheme
    , displayMode = Color.Default
    , openState = OpenState.Open
    , handleItemSelected = \_ -> None
    , switchOpenState = \_ -> None
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
        []
        [ view model
        ]

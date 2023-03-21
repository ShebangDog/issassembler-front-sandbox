module DisplayModeSwitcher exposing (view)

import Color exposing (DisplayMode)
import Css
import DisplayModeDropDown
import DisplayModeIcon
import Html.Styled exposing (div, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import None
import OpenState exposing (OpenState(..))


view : Color.Theme -> DisplayMode -> OpenState -> (Color.DisplayMode -> msg) -> (OpenState.OpenState -> msg) -> Html.Styled.Html msg
view theme displayMode openState updateMode switchState =
    let
        dropDownView =
            DisplayModeDropDown.view
                [ Css.position Css.absolute
                , Css.top (Css.pct 100)
                ]
                theme
                updateMode

        displayingView state =
            case state of
                Open ->
                    dropDownView

                Close ->
                    None.view

        colorStyle =
            Css.batch
                [ case openState of
                    OpenState.Open ->
                        Css.backgroundColor theme.primaryBright

                    OpenState.Close ->
                        Css.backgroundColor Css.transparent
                , Css.hover
                    [ Css.backgroundColor theme.primaryBright
                    ]
                ]

        indicatorView =
            div
                [ onClick (switchState openState)
                , css
                    [ Css.displayFlex
                    , Css.flexDirection Css.row
                    , Css.alignItems Css.center
                    , Css.position Css.relative
                    , Css.cursor Css.pointer
                    , colorStyle
                    ]
                ]
                [ DisplayModeIcon.view displayMode
                , text "Theme"
                , displayingView openState
                ]
    in
    indicatorView

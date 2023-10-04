module DisplayModeSwitcher exposing (view)

import Browser
import Color exposing (DisplayMode)
import Css
import DisplayModeDropDown
import DisplayModeIcon
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import None
import OpenState exposing (OpenState(..))



-- Implement


view : Color.Theme -> DisplayMode -> OpenState -> (Color.DisplayMode -> msg) -> (OpenState.OpenState -> msg) -> Html.Styled.Html msg
view theme displayMode openState updateMode switchState =
    let
        dropDown =
            DisplayModeDropDown.view
                [ Css.position Css.absolute
                , Css.top (Css.pct 100)
                , Css.transform (Css.translateY (Css.px 4))
                ]
                theme
                updateMode

        overlay =
            div
                [ css
                    [ Css.position Css.absolute
                    , Css.width (Css.pct 100)
                    , Css.height (Css.pct 100)
                    , Css.top (Css.px 0)
                    , Css.left (Css.px 0)
                    ]
                , onClick (switchState openState)
                ]
                []

        ( dropDownView, overlayView ) =
            case openState of
                Open ->
                    ( dropDown, overlay )

                Close ->
                    ( None.view, None.view )

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
                    , Css.height (Css.pct 100)
                    , Css.cursor Css.pointer
                    , colorStyle
                    ]
                ]
                [ DisplayModeIcon.view displayMode
                , text "Theme"
                , dropDownView
                ]
    in
    div [] [ overlayView, indicatorView ]



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
        []
        [ view Color.defaultTheme Color.Default OpenState.Open (\_ -> None) (\_ -> None)
        ]

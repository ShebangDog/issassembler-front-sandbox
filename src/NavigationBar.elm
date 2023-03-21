module NavigationBar exposing (view)

import Browser
import Color
import Css
import DisplayModeSwitcher
import Html.Styled exposing (div, h1, header, nav, text, ul)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import NavigationItem
import OpenState exposing (OpenState)
import Route



-- Implement


type alias Model a msg =
    { a
        | theme : Color.Theme
        , title : String
        , openState : OpenState
        , routeSet : List Route.Route
        , route : Route.Route
        , displayMode : Color.DisplayMode
        , handleNavigationClicked : Route.Route -> Html.Styled.Attribute msg
        , handleItemSelected : Color.DisplayMode -> msg
        , switchOpenState : OpenState -> msg
    }


view : Model a msg -> Html.Styled.Html msg
view model =
    let
        navigationItem route =
            NavigationItem.view
                { theme = model.theme
                , handleNavigationClicked = model.handleNavigationClicked
                , isSelected = model.route == route
                , route = model.route
                }
    in
    header
        [ css
            [ Css.backgroundColor model.theme.primary
            , Css.color model.theme.onPrimary
            , Css.padding2 (Css.px 24) (Css.px 24)
            ]
        ]
        [ h1
            [ css
                [ Css.fontSize (Css.px 32)
                ]
            ]
            [ text model.title ]
        , div []
            [ nav []
                [ ul
                    [ css
                        [ Css.displayFlex
                        , Css.flexDirection Css.row
                        , Css.marginTop (Css.px 16)
                        ]
                    ]
                    (List.concat
                        [ List.map navigationItem model.routeSet
                        , [ DisplayModeSwitcher.view model ]
                        ]
                    )
                ]
            ]
        ]



-- Preview


type Msg
    = None


type alias PreviewModel =
    Model {} Msg


init : PreviewModel
init =
    { theme = Color.defaultTheme
    , displayMode = Color.Default
    , title = "issassembler"
    , openState = OpenState.Open
    , routeSet = Route.routeSet
    , route = Route.top
    , handleItemSelected = \_ -> None
    , handleNavigationClicked = \_ -> onClick None
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


preview : PreviewModel -> Html.Styled.Html Msg
preview model =
    view model

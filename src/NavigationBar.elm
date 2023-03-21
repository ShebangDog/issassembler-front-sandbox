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
import Route exposing (Route)



-- Implement


view : Color.Theme -> String -> OpenState -> List Route -> Route -> Color.DisplayMode -> (Route -> Html.Styled.Attribute msg) -> (Color.DisplayMode -> msg) -> (OpenState.OpenState -> msg) -> Html.Styled.Html msg
view theme title openState routeList currentRoute displayMode transition updateMode switchState =
    let
        navigationItem route =
            NavigationItem.view theme transition (route == currentRoute) route
    in
    header
        [ css
            [ Css.backgroundColor theme.primary
            , Css.color theme.onPrimary
            , Css.padding2 (Css.px 24) (Css.px 24)
            ]
        ]
        [ h1
            [ css
                [ Css.fontSize (Css.px 32)
                ]
            ]
            [ text title ]
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
                        [ List.map navigationItem routeList
                        , [ DisplayModeSwitcher.view theme displayMode openState updateMode switchState ]
                        ]
                    )
                ]
            ]
        ]



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


preview : () -> Html.Styled.Html Msg
preview _ =
    Html.Styled.div
        []
        [ view
            Color.defaultTheme
            "navigationBar"
            OpenState.Open
            Route.routeSet
            Route.top
            Color.Default
            (\_ -> onClick None)
            (\_ -> None)
            (\_ -> None)
        ]

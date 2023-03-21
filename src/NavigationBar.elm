module NavigationBar exposing (view)

import Color
import Css
import DisplayModeSwitcher
import Html.Styled exposing (div, h1, header, nav, text, ul)
import Html.Styled.Attributes exposing (css)
import NavigationItem
import OpenState exposing (OpenState)
import Route exposing (Route)


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

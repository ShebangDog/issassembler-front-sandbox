module NavigationBar exposing (view)

import Color
import Css
import Html.Styled exposing (div, h1, header, nav, text, ul)
import Html.Styled.Attributes exposing (css)
import NavigationItem
import Route exposing (Route)


view : Color.Theme -> String -> List Route -> Route -> (Route -> Html.Styled.Attribute msg) -> Html.Styled.Html msg
view theme title routeList currentRoute transition =
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
                    (List.map navigationItem routeList)
                ]
            ]
        ]

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
            NavigationItem.view transition (route == currentRoute) route
    in
    header
        []
        [ h1
            [ css
                [ Css.backgroundColor theme.primary
                , Css.color theme.onPrimary
                , Css.fontSize (Css.px 32)
                , Css.padding2 (Css.px 16) (Css.px 16)
                ]
            ]
            [ text title ]
        , div []
            [ nav []
                [ ul
                    []
                    (List.map navigationItem routeList)
                ]
            ]
        ]

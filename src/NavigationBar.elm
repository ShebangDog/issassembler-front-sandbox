module NavigationBar exposing (view)

import Html.Styled exposing (div, h1, header, nav, text, ul)
import NavigationItem
import Route exposing (Route)


view : String -> List Route -> Route -> (Route -> Html.Styled.Attribute msg) -> Html.Styled.Html msg
view title routeList currentRoute transition =
    let
        navigationItem route =
            NavigationItem.view transition (route == currentRoute) route
    in
    header
        []
        [ h1 [] [ text title ]
        , div []
            [ nav []
                [ ul
                    []
                    (List.map navigationItem routeList)
                ]
            ]
        ]

module NavigationItem exposing (view)

import Html.Styled exposing (a, li, p, text)
import Route exposing (Route)


view : (Route -> Html.Styled.Attribute msg) -> Bool -> Route -> Html.Styled.Html msg
view transition isSelected route =
    let
        content =
            text (Route.toString route)

        element =
            if isSelected then
                p [] [ content ]

            else
                a [ transition route ] [ content ]
    in
    li [] [ element ]

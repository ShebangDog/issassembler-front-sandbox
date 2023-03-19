module NavigationItem exposing (view)

import Css
import Html.Styled exposing (a, img, li, p, span, text)
import Html.Styled.Attributes exposing (css, src)
import Route exposing (Route)


view : (Route -> Html.Styled.Attribute msg) -> Bool -> Route -> Html.Styled.Html msg
view transition isSelected route =
    let
        path =
            "../"
                ++ (case route of
                        Route.Top _ ->
                            "../assets/pyramid.png"

                        Route.History _ ->
                            "../assets/black_book.png"
                   )

        icon =
            img [ src path, css [ Css.width (Css.px 24) ] ] []

        content =
            text (Route.toString route)

        element =
            if isSelected then
                span [] [ content ]

            else
                a [ transition route ] [ content ]
    in
    li [ css [ Css.padding (Css.px 8) ] ] [ icon, element ]

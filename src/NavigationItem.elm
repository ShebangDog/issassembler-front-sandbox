module NavigationItem exposing (view)

import Color
import Css
import Html.Styled exposing (a, img, li, p, span, text)
import Html.Styled.Attributes exposing (css, src)
import Route exposing (Route)


view : Color.Theme -> (Route -> Html.Styled.Attribute msg) -> Bool -> Route -> Html.Styled.Html msg
view theme transition isSelected route =
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

        style =
            css
                [ Css.color theme.onPrimary
                , Css.textDecorationLine Css.none
                ]

        underline =
            if isSelected then
                Css.borderBottom3 (Css.px 2) Css.solid theme.secondary

            else
                Css.borderBottom3 (Css.px 2) Css.solid Css.transparent

        element =
            a
                [ style
                , transition route
                ]
                [ content ]
    in
    li [ css [ Css.padding (Css.px 8), underline ] ] [ icon, element ]

module NavigationItem exposing (view)

import Browser
import Color
import Css
import Html.Styled exposing (Html, a, img, li, text)
import Html.Styled.Attributes exposing (css, src)
import Html.Styled.Events exposing (onClick)
import Route



-- Implement


type alias Model a msg =
    { a
        | theme : Color.Theme
        , handleNavigationClicked : Route.Route -> Html.Styled.Attribute msg
        , isSelected : Bool
        , route : Route.Route
    }


view : Model a msg -> Html.Styled.Html msg
view model =
    let
        -- TODO: icon用の描画関数に分ける
        path =
            "../"
                ++ (case model.route of
                        Route.Top _ ->
                            "../assets/pyramid.png"

                        Route.History _ ->
                            "../assets/black_book.png"
                   )

        icon =
            img [ src path, css [ Css.width (Css.px 24) ] ] []

        content =
            text (Route.toString model.route)

        style =
            css
                [ Css.color model.theme.onPrimary
                , Css.textDecorationLine Css.none
                ]

        underline =
            if model.isSelected then
                Css.borderBottom3 (Css.px 2) Css.solid model.theme.secondary

            else
                Css.borderBottom3 (Css.px 2) Css.solid Css.transparent

        element =
            a
                [ style
                , model.handleNavigationClicked model.route
                ]
                [ content ]
    in
    li [ css [ Css.padding (Css.px 8), underline ] ] [ icon, element ]



-- Preview


type Msg
    = None


type alias PreviewModel =
    Model {} Msg


init : PreviewModel
init =
    { theme = Color.defaultTheme
    , route = Route.top
    , isSelected = True
    , handleNavigationClicked = \_ -> onClick None
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


preview : PreviewModel -> Html Msg
preview model =
    view model

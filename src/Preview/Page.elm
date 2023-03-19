module Preview.Page exposing (Model, Msg(..), update, view)

import Browser
import Css.Global
import Css.Reset
import Html.Styled exposing (Html)
import Html.Styled.Events exposing (onClick)
import Page
import Route


type Msg
    = Clicked


type alias Model =
    Page.Model {}


switchRoute : Route.Route -> Route.Route
switchRoute route =
    case route of
        Route.Top _ ->
            Route.history

        Route.History _ ->
            Route.top


update : Msg -> Model -> Model
update msg model =
    case msg of
        Clicked ->
            { model | route = switchRoute model.route }


view : Model -> Html Msg
view model =
    Html.Styled.div
        [ onClick Clicked ]
        [ Css.Global.global Css.Reset.ericMeyer
        , Page.view model (Page.Action (\_ -> Clicked))
        ]


init : Model
init =
    { data = { count = 1 }
    , route = Route.top
    }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view >> Html.Styled.toUnstyled
        , update = update
        }

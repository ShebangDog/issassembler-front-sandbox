module Preview.Loading exposing (..)

import Browser
import Html.Styled exposing (Html)
import Loading


type Msg
    = Message


type alias Model =
    { statusText : String
    }


init : () -> ( Model, Cmd msg )
init () =
    ( { statusText = "Ready" }
    , Cmd.none
    )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view >> Html.Styled.toUnstyled
        , update = update
        , subscriptions = subscriptions
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Message ->
            ( { model | statusText = "Loaded" }
            , Cmd.none
            )


view : Model -> Html msg
view model =
    Loading.view { span = 1 }


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none

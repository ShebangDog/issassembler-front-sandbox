module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser exposing (Document)
import Html exposing (button, div, text)
import Html.Events exposing (onClick)


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
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Message ->
            ( { model | statusText = "Success Deployment" }
            , Cmd.none
            )


view : Model -> Document Msg
view model =
    { title = "title"
    , body =
        [ div
            []
            [ button [ onClick Message ] [ text model.statusText ] ]
        ]
    }


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none

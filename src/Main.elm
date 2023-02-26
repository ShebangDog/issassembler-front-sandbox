module Main exposing (Status(..), view)

import Browser exposing (Document)
import Css.Global
import Css.Reset
import Html.Styled exposing (button, div text)
import Html.Styled.Events exposing (onClick)
import Loading
import None


type Msg
    = Message


type Status
    = Success
    | Loading


type alias Model =
    { status : Status
    }


init : () -> ( Model, Cmd msg )
init () =
    ( { status = Loading }
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
            ( { model | status = Success }
            , Cmd.none
            )


statusText : Status -> String
statusText status =
    case status of
        Loading ->
            "fetch"

        Success ->
            "loaded"


view : Model -> Document Msg
view model =
    { title = "Issassembler"
    , body =
        List.map Html.Styled.toUnstyled
            [ div
                []
                [ Css.Global.global Css.Reset.ericMeyer
                , button [ onClick Message ]
                    [ text (statusText model.status)
                    ]
                , case model.status of
                    Loading ->
                        Loading.view { span = 2 }

                    Success ->
                        None.view
                ]
            ]
    }


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none

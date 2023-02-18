module Preview.Loading exposing (..)

import Browser
import Html.Styled exposing (Html)
import Loading
import Preview.GlobalStyle


type Msg
    = Message


type alias Model =
    { statusText : String
    }


init : Model
init =
    { statusText = "Ready" }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view >> Html.Styled.toUnstyled
        , update = update
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Message ->
            { model | statusText = "Loaded" }


view : Model -> Html msg
view model =
    Html.Styled.div
        []
        [ Loading.view { span = 1 }
        ]


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none

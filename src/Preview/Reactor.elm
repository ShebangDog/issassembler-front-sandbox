module Preview.Reactor exposing (..)

import Browser
import Browser.Navigation exposing (Key)
import Json.Encode
import Main
import Url exposing (Url)


initialFlags : Json.Encode.Value
initialFlags =
    Json.Encode.object
        [ ( "value", Json.Encode.int 1818 )
        ]


init : () -> Url -> Key -> ( Main.Model, Cmd Main.Msg )
init () =
    Main.init initialFlags


main : Program () Main.Model Main.Msg
main =
    Browser.application
        { init = init
        , view = Main.view
        , update = Main.update
        , subscriptions = Main.subscriptions
        , onUrlRequest = Main.LinkClicked
        , onUrlChange = Main.handleUrlChange
        }

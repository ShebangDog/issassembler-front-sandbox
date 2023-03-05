module Preview.None exposing (..)

import Browser
import Html.Styled exposing (Html)
import None


init : ()
init =
    ()


main : Program () () ()
main =
    Browser.sandbox
        { init = ()
        , view = view >> Html.Styled.toUnstyled
        , update = update
        }


update : () -> () -> ()
update _ _ =
    ()


view : () -> Html msg
view _ =
    Html.Styled.div
        []
        [ None.view
        ]

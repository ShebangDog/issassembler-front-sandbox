module Preview.NavigationItem exposing (..)

import Browser
import Css.Global
import Css.Reset
import Html.Styled exposing (Html, ul)
import NavigationItem
import Route


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
    ul
        []
        [ Css.Global.global Css.Reset.ericMeyer
        , NavigationItem.view
            Route.transition
            True
            Route.top
        ]

module Preview.NavigationBar exposing (..)

import Browser
import Css.Global
import Css.Reset
import Html.Styled exposing (div)
import Html.Styled.Events exposing (onClick)
import NavigationBar
import Route


init : ()
init =
    ()


main : Program () () Msg
main =
    Browser.sandbox
        { init = ()
        , view = view >> Html.Styled.toUnstyled
        , update = update
        }


update : Msg -> () -> ()
update _ _ =
    ()


type Msg
    = Clicked


view : () -> Html.Styled.Html Msg
view _ =
    div
        []
        [ Css.Global.global Css.Reset.ericMeyer
        , NavigationBar.view
            "title"
            Route.routeSet
            Route.top
            (\_ -> onClick Clicked)
        ]

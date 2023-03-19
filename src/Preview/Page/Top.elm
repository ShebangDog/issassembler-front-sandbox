module Preview.Page.Top exposing (..)

import Browser
import Html.Styled
import Page
import Preview.Page
import Route


init : Preview.Page.Model
init =
    { data = { count = 1 }
    , route = Route.history
    }


view : Preview.Page.Model -> Html.Styled.Html Preview.Page.Msg
view model =
    Page.top model (Page.Action (\_ -> Preview.Page.Clicked))


main : Program () Preview.Page.Model Preview.Page.Msg
main =
    Browser.sandbox
        { init = init
        , view = view >> Html.Styled.toUnstyled
        , update = Preview.Page.update
        }

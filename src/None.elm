module None exposing (view)

import Browser
import Html.Styled exposing (Html, text)



-- Implement


view : Html msg
view =
    text ""



-- Preview


init : ()
init =
    ()


main : Program () () ()
main =
    Browser.sandbox
        { init = ()
        , view = preview >> Html.Styled.toUnstyled
        , update = update
        }


update : () -> () -> ()
update _ _ =
    ()


preview : () -> Html msg
preview _ =
    view

module Page exposing (Action, Model, history, top, view)

import Browser
import Color
import Css.Global
import Css.Reset
import Html.Styled exposing (Html, button, div, text)
import Html.Styled.Events exposing (onClick)
import Route exposing (Route(..), history)



-- Implement


type alias Model a =
    { a
        | route : Route
        , data : Data
    }


type alias Data =
    { count : Int
    }


type alias Action msg =
    { onDisplayModeClicked : Color.DisplayMode -> msg
    }


top : { a | data : Data } -> Action msg -> Html.Styled.Html msg
top model action =
    div
        []
        (List.concat
            [ [ text "main"
              , text (String.fromInt model.data.count)
              ]
            , Color.displayModeSet
                |> List.map
                    (\mode -> button [ onClick (action.onDisplayModeClicked mode) ] [ text (Color.toString mode) ])
            ]
        )


history : a -> Action msg -> Html.Styled.Html msg
history _ _ =
    div
        []
        [ text "history"
        ]


view : Model a -> Action msg -> Html.Styled.Html msg
view model action =
    case model.route of
        Route.Top _ ->
            top model action

        Route.History _ ->
            history model action



-- Preview


type Msg
    = None


type alias PreviewModel =
    Model {}


switchRoute : Route.Route -> Route.Route
switchRoute route =
    case route of
        Route.Top _ ->
            Route.history

        Route.History _ ->
            Route.top


update : Msg -> PreviewModel -> PreviewModel
update msg model =
    case msg of
        None ->
            { model | route = switchRoute model.route }


preview : PreviewModel -> Html Msg
preview model =
    Html.Styled.div
        [ onClick None ]
        [ Css.Global.global Css.Reset.ericMeyer
        , view model (Action (\_ -> None))
        ]


init : PreviewModel
init =
    { data = { count = 1 }
    , route = Route.top
    }


main : Program () PreviewModel Msg
main =
    Browser.sandbox
        { init = init
        , view = preview >> Html.Styled.toUnstyled
        , update = update
        }

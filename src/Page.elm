module Page exposing (Action, Model, history, top, view)

import Color
import Html.Styled exposing (button, div, text)
import Html.Styled.Events exposing (onClick)
import Route exposing (Route(..), history)


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

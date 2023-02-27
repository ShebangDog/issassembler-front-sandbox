module Route exposing (Route(..), history, suite, toHistory, toString, toTop, top)

import Expect
import Test exposing (Test, describe, test)


type Transition a
    = Transition


type Allowed
    = Allowed


type Route
    = Top
        (Transition
            { history : Allowed
            }
        )
    | History
        (Transition
            { top : Allowed
            }
        )


toString : Route -> String
toString route =
    case route of
        Top _ ->
            "Top"

        History _ ->
            "History"


toTop : Transition { a | top : Allowed } -> Route
toTop _ =
    Top Transition


toHistory : Transition { a | history : Allowed } -> Route
toHistory _ =
    History Transition


top : Route
top =
    Top Transition


history : Route
history =
    History Transition



-- テスト


suite : Test
suite =
    describe "Route module"
        [ describe "toString"
            [ test "toStringにTopを渡すとTopと返すこと" <|
                \() ->
                    Expect.equal
                        (toString top)
                        "Top"
            , test "toStringにHistoryを渡すとHistoryと返すこと" <|
                \() ->
                    Expect.equal
                        (toString history)
                        "History"
            ]
        ]

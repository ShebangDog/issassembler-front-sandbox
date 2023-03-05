module Example exposing (..)

import Expect
import Route
import Test exposing (..)


suite : Test
suite =
    describe "Route.toString"
        [ test "TopをtoStringに渡すとTopと返すこと" <|
            \() ->
                Expect.equal
                    (Route.toString Route.top)
                    "Top"
        , test "HistoryをtoStringに渡すとHistoryと返すこと" <|
            \() ->
                Expect.equal
                    (Route.toString Route.history)
                    "History"
        ]

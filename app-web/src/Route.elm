module Route exposing (Route(..), history, routeSet, suite, toHistory, toString, toTop, top, transition)

import Expect
import Html.Styled
import Html.Styled.Attributes exposing (href)
import Test exposing (Test, describe, test)



-- Implement


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


routeSet : List Route
routeSet =
    [ top, history ]


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


transition : Route -> Html.Styled.Attribute msg
transition route =
    href ("/" ++ toString route)



-- Test


suite : Test
suite =
    describe "Route module"
        [ describe "toString"
            [ test "toStringにTopを渡すとTopと返すこと" (\() -> Expect.equal (toString top) "Top")
            , test "toStringにHistoryを渡すとHistoryと返すこと" (\() -> Expect.equal (toString history) "History")
            ]
        , describe "routeSet"
            [ test "routeSetが全てのRoute variantを基に作られたTransition型のリストであること" (\() -> Expect.equal routeSet [ top, history ])
            ]
        , describe "transition"
            [ test "transitionがTopを受け取った場合、href `/Top`を返すこと" (\() -> Expect.equal (transition top) (href "/Top"))
            , test "transitionがHistoryを受け取った場合、href `/History`を返すこと" (\() -> Expect.equal (transition history) (href "/History"))
            ]
        ]

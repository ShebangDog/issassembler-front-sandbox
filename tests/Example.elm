module Example exposing (..)

import Expect
import Main exposing (add)
import Test exposing (..)


suite : Test
suite =
    describe "add function"
        [ test "1と1を受け取った時2になること" <| \() -> Expect.equal (add 1 1) 2
        ]

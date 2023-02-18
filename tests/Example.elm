module Example exposing (..)

import Expect
import Html exposing (a)
import Main
import Test exposing (..)


suite : Test
suite =
    describe "Main.view"
        [ test "titleがIssassemblerであること" <|
            \() ->
                Expect.equal
                    (Main.view { status = Main.Loading }).title
                    "Issassemblerr"
        ]

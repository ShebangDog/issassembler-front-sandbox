module Example exposing (..)

import Expect
import Html exposing (a)
import Main
import Test exposing (..)


suite : Test
suite =
    describe "subscription function"
        [ test "subscriptionsがNoneを返すこと" <|
            \() ->
                Expect.equal
                    (Main.subscriptions
                        { status = Main.Loading }
                    )
                    Sub.none
        ]

module Example exposing (..)

import Expect
import Main
import Test exposing (..)


suite : Test
suite =
    describe "subscription function"
        [ test "subscriptionsがNoneを返すこと" <|
            \() ->
                Expect.equal
                    (Main.subscriptions
                        { statusText = "Ready" }
                    )
                    Sub.none
        ]

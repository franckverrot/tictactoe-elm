module Unit.UpdateTests exposing (updateTests)

import Test   exposing (..)
import Expect
import Array
import Player exposing (Player (A, B, Unclaimed))
import Update exposing (changePlayer, noneUnclaimed, currentPlayerWinning)

updateTests : List Test
updateTests = [ describe "Update.changePlayer"
                  [ test "switches turn from A to B" <|
                      \() ->
                          Expect.equal B <| Update.changePlayer A
                  , test "switches turn from B to A" <|
                      \() ->
                          Expect.equal A <| Update.changePlayer B
                  ]
              , describe "Update.noneUnclaimed"
                  [ test "returns True if none of the boxes are unclaimed" <|
                      \() ->
                          Expect.equal True
                            <| noneUnclaimed <| Array.fromList <| [A, B, A]
                  , test "returns False if at least one box is unclaimed" <|
                      \() ->
                          Expect.equal False
                            <| noneUnclaimed <| Array.fromList <| [A, Unclaimed, A]
                  ]
              ]

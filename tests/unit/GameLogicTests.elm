module Unit.GameLogicTests exposing (gameLogicTests)

import Test       exposing (..)
import Expect
import Array
import GameLogic  exposing (noneUnclaimed)
import Model      exposing (Model, initialModel)
import Models.Box exposing (..)
import Player     exposing (Player (A, B, Unclaimed))

gameLogicTests : List Test
gameLogicTests = [ describe "GameLogic.noneUnclaimed"
                  [ test "returns True if none of the boxes are unclaimed" <|
                      \() ->
                          Expect.equal True
                            <| noneUnclaimed <| Array.fromList <| [(Box A), (Box B), (Box A)]
                  , test "returns False if at least one box is unclaimed" <|
                      \() ->
                          Expect.equal False
                            <| noneUnclaimed <| Array.fromList <| [(Box A), (Box Unclaimed), (Box A)]
                  ]
                ]

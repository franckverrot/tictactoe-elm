module Unit.GameLogicTests exposing (gameLogicTests)

import Test       exposing (..)
import Expect
import Array
import GameLogic  exposing (areMoreTurnsInGame)
import Model      exposing (Model, initialModel)
import Models.Box exposing (..)
import Player     exposing (Player (A, B, Unclaimed))

gameLogicTests : List Test
gameLogicTests = [ describe "GameLogic.areMoreTurnsInGame"
                  [ test "returns False if none of the boxes are unclaimed" <|
                      \() ->
                          Expect.equal False
                            <| areMoreTurnsInGame <| Array.fromList <| [(Box A), (Box B), (Box A)]
                  , test "returns True if at least one box is unclaimed" <|
                      \() ->
                          Expect.equal True
                            <| areMoreTurnsInGame <| Array.fromList <| [(Box A), (Box Unclaimed), (Box A)]
                  ]
                ]

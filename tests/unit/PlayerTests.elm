module Unit.PlayerTests exposing (playerTests)

import Test   exposing (..)
import Expect
import Set    exposing (map)
import Player exposing (Player (A, B, Unclaimed))

playerTests : List Test
playerTests = [ describe "Player.show"
                [ test "player names are all different" <|
                    \() ->
                        Expect.equal 3
                          <| Set.size <| Set.fromList -- Set.map requires comparables... thank, Elm :-D
                          <| List.map Player.show [A, B, Unclaimed]
                ]
              ]

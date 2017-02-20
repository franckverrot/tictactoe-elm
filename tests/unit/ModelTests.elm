module Unit.ModelTests exposing (modelTests)

import Test   exposing (..)
import Expect
import Array
import Model  exposing (Model, initialModel)
import Player exposing (Player (A, B, Unclaimed))

modelTests : List Test
modelTests = [ describe "Model.initialModel"
                 [ test "the 9 required boxes are created" <|
                     \() ->
                         Expect.equal 9 <| Array.length initialModel.boxes
                 , test "player A starts the game" <|
                     \() ->
                         Expect.equal A initialModel.currentPlayer
                 , test "there's no winner when the game starts" <|
                     \() ->
                         Expect.equal Nothing initialModel.winner
                 ]
             ]

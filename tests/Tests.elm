module Tests  exposing (..)

import Test   exposing (..)
import Expect
import Fuzz   exposing (list, int, tuple, string)
import String

import Model  exposing (Model, initialModel)
import Player exposing (Player (A, B, Unclaimed))
import Update exposing (changePlayer, noneUnclaimed, currentPlayerWinning)
import Array
import Set    exposing (map)


all : Test
all =
    describe "Test Suite"
        [ describe "Model.initialModel"
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
        , describe "Player.show"
            [ test "player names are all different" <|
                \() ->
                    Expect.equal 3
                      <| Set.size <| Set.fromList -- Set.map requires comparables... thank, Elm :-D
                      <| List.map Player.show [A, B, Unclaimed]
            ]
        , describe "Update.changePlayer"
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

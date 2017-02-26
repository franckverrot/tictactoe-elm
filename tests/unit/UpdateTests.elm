module Unit.UpdateTests exposing (updateTests)

import Test   exposing (..)
import Expect
import Array
import Model      exposing (initialModel)
import Models.Box exposing (..)
import GameEvent  exposing (GameEvent(Clicked, CheckWinner, Reset))
import Player     exposing (Player (A, B, Unclaimed))
import Update     exposing (changePlayer, currentPlayerWinning, update)
import Time       exposing (second)

makeBoard ary = Array.map (\player -> (Box player)) ary

updateTests : List Test
updateTests = [ describe "Update.update"
                  [ test "Handles Reset" <|
                      \() ->
                          Expect.equal (initialModel ! [])
                            <| update Reset initialModel

                  , test "Handles CheckWinner -- none unclaimed -- and there's a winner" <|
                      \() ->
                        let
                            message       = (CheckWinner A False Time.second)
                            previousModel = { initialModel
                                            | boxes = makeBoard (Array.fromList [ A, A, A
                                                                      , A, B, B
                                                                      , B, B, A ])
                                            }
                            (newModel, _) = update message previousModel
                        in
                            Expect.equal (Just A) (newModel.winner)

                  , test "Handles CheckWinner -- none unclaimed -- no winner" <|
                      \() ->
                        let
                            message       = (CheckWinner A False Time.second)
                            previousModel = { initialModel
                                            | boxes = makeBoard (Array.fromList [ A, A, B
                                                                      , B, B, A
                                                                      , A, B, A ])
                                            }
                            (newModel, _) = update message previousModel
                        in
                            Expect.equal (Just Unclaimed) (newModel.winner)

                  , test "Handles CheckWinner -- legal move with winner" <|
                      \() ->
                        let
                            message       = (CheckWinner A True Time.second)
                            previousModel = { initialModel
                                            | boxes = makeBoard (Array.fromList [ A, A, A
                                                                      , B, B, Unclaimed
                                                                      , Unclaimed, Unclaimed, Unclaimed])
                                            }
                            (newModel, _) = update message previousModel
                        in
                            Expect.equal (Just A) newModel.winner

                  , test "Handles CheckWinner -- legal move with no winner" <|
                      \() ->
                        let
                            message       = (CheckWinner A True Time.second)
                            previousModel = { initialModel
                                            | boxes = makeBoard (Array.fromList [ A, A, Unclaimed
                                                                      , B, B, Unclaimed
                                                                      , Unclaimed, Unclaimed, Unclaimed])
                                            }
                            (newModel, _) = update message previousModel
                        in
                            Expect.equal Nothing newModel.winner

                  , test "Handles CheckWinner -- illegal move" <|
                      \() ->
                        let
                            msg = (CheckWinner A False Time.second)
                            model = initialModel
                        in
                            Expect.equal (initialModel ! [])
                              <| update msg model
                  ]
              ]

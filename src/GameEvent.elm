module GameEvent exposing ( GameEvent(Clicked, CheckWinner, Reset)
                          )
import Player  exposing (..)
import Time    exposing (..)

type GameEvent = Clicked Int
             | CheckWinner Player Bool Time
             | Reset

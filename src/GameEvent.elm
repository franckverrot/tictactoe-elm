module GameEvent exposing ( GameEvent(Clicked, CheckWinner, Reset)
                          )
import Player     exposing (..)
import Time       exposing (..)
import Models.Box exposing (..)

type GameEvent = Clicked Box Int
               | CheckWinner Player Bool Time
               | Reset

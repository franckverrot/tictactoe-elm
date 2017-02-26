module GameEvent exposing ( GameEvent(BoxClicked, CheckWinner, Reset)
                          )
import Player     exposing (..)
import Time       exposing (..)
import Models.Box exposing (..)

type GameEvent = BoxClicked Box Int
               | CheckWinner Player Bool Time
               | Reset

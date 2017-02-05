module MyEvent exposing ( MyEvent(Clicked, CheckWinner, Reset)
                      )
import Player  exposing (..)
import Time    exposing (..)

type MyEvent = Clicked Int
             | CheckWinner Player Bool Time
             | Reset

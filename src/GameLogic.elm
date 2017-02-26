module GameLogic exposing (areMoreTurnsInGame)

import Array      exposing (..)
import Player     exposing (..)
import Models.Box exposing (..)

areMoreTurnsInGame : Array Box -> Bool
areMoreTurnsInGame ary =
  ary
    |> filter
         (\x -> case x of
           (Box player) -> player == Unclaimed)
    |> length
    |> (flip (>) 0)

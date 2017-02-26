module GameLogic exposing (noneUnclaimed)

import Array      exposing (..)
import Player     exposing (..)
import Models.Box exposing (..)

noneUnclaimed : Array Box -> Bool
noneUnclaimed ary =
  ary
    |> filter
         (\x -> case x of
           (Box player) -> player == Unclaimed)
    |> length
    |> ((==) 0)

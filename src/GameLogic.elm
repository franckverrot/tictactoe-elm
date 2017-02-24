module GameLogic exposing (noneUnclaimed)

import Array  exposing (..)
import Player exposing (..)

noneUnclaimed : Array Player -> Bool
noneUnclaimed ary = (0 == length(filter (\x -> x == Unclaimed) ary))

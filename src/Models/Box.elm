module Models.Box exposing (..)

import Player exposing (..)

type Box = Box Player

showBox : Box -> String
showBox (Box player) = showPlayer player

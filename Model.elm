module Model exposing ( Model
                      )

import Array exposing (..)
import Player exposing (..)

type alias Model = { boxes         : Array Player
                   , currentPlayer : Player
                   , winner        : Maybe Player
                   }

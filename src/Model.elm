module Model exposing ( Model
                      , initialModel
                      )

import Array exposing (..)
import Player exposing (..)

type alias Model = { boxes         : Array Player
                   , currentPlayer : Player
                   , winner        : Maybe Player
                   }

initialModel : Model
initialModel = { boxes         = repeat 9 Unclaimed
               , currentPlayer = A
               , winner        = Nothing
               }

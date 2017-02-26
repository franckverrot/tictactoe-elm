module Model exposing ( Model
                      , initialModel
                      )

import Array      exposing (..)
import Player     exposing (..)
import Models.Box exposing (..)

type alias Model = { boxes         : Array Box
                   , currentPlayer : Player
                   , winner        : Maybe Player
                   }

initialModel : Model
initialModel = { boxes         = initialize 9 (\index -> Box Unclaimed)
               , currentPlayer = A
               , winner        = Nothing
               }

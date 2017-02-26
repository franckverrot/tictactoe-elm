import Html      exposing (program)
import Model     exposing (Model, initialModel)
import GameEvent exposing (GameEvent)
import Update    exposing (update)
import View      exposing (view)

main : Program Never Model GameEvent
main = program { init          = (initialModel, Cmd.none)
               , view          = view
               , update        = update
               , subscriptions = \x -> Sub.none
               }

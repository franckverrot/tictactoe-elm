import Html    exposing (program)
import Model   exposing (Model, initialModel)
import MyEvent exposing (MyEvent)
import Update  exposing (update)
import View    exposing (view)

main : Program Never Model MyEvent
main = program { init          = (initialModel, Cmd.none)
               , view          = view
               , update        = update
               , subscriptions = \x -> Sub.none
               }

module OnClicked exposing ( onClicked )

{-| Handlers onClick event

@docs onClicked
-}
import Array   exposing (..)
import Maybe   exposing (..)
import Model   exposing (..)
import MyEvent exposing (..)
import Player  exposing (..)
import Task    exposing (..)
import Time    exposing (..)

{-| onClicked -}
onClicked : Model -> Int -> (Model, Cmd MyEvent)
onClicked model index =
        let
            previousValue = Maybe.withDefault Unclaimed (get index model.boxes)
            boxes =
              case previousValue of
                Unclaimed -> set index model.currentPlayer model.boxes
                _         -> model.boxes
            currentPlayerShouldChange =
              case previousValue of
                Unclaimed -> True
                _         -> False

        in
            { model
            | boxes = boxes
            } ! [(Task.perform (CheckWinner model.currentPlayer currentPlayerShouldChange) Time.now)]

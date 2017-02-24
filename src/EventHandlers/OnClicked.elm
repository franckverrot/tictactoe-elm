module EventHandlers.OnClicked exposing ( onClicked )

{-| Handlers onClick event

@docs onClicked
-}
import Array     exposing (..)
import Maybe     exposing (..)
import Model     exposing (..)
import MyEvent   exposing (..)
import Player    exposing (..)
import Task      exposing (..)
import Time      exposing (..)
import GameLogic exposing (noneUnclaimed)

{-| onClicked -}
onClicked : Model -> Int -> (Model, Cmd MyEvent)
onClicked model index =
        let
            markBoxForPlayer player = set index player
            leaveBoardIntact player = identity
        in
            get index model.boxes
              |> Maybe.withDefault Unclaimed
              |> (\box -> case box of
                            Unclaimed -> (markBoxForPlayer, True)
                            _         -> (leaveBoardIntact, False))
              |> \(transformBoard, validMove) ->
                   ( transformBoard model.currentPlayer model.boxes
                   , CheckWinner model.currentPlayer validMove)
              |> \(boxes, checkToRun) ->
                   { model | boxes = boxes } ! [ Task.perform checkToRun Time.now ]

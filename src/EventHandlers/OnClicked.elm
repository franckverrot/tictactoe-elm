module EventHandlers.OnClicked exposing ( onClicked )

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
            markBoxForPlayer = set index model.currentPlayer model.boxes
            leaveBoardIntact = model.boxes
        in
            get index model.boxes
              |> Maybe.withDefault Unclaimed
              |> (\box ->
                   case box of
                     Unclaimed -> (markBoxForPlayer, True)
                     _         -> (leaveBoardIntact, False))
              |> \(boxes, validMove) ->
                   { model | boxes = boxes } ! [ Task.perform (CheckWinner model.currentPlayer validMove) Time.now ]

module Update exposing (update)

import Array                   exposing (..)
import EventHandlers.OnClicked exposing (onClicked)
import Model                   exposing (..)
import MyEvent                 exposing (..)
import Player                  exposing (..)

playerWon player model =
  let
      myGet i =  Maybe.withDefault Unclaimed (get i model.boxes)
      isPlayer x = x == player
      check a b c = (3 == length(filter isPlayer (fromList [(myGet a), (myGet b), (myGet c)])))
      row1  = check 0 1 2
      row2  = check 3 4 5
      row3  = check 6 7 8

      col1  = check 0 3 6
      col2  = check 1 4 7
      col3  = check 2 5 8

      diag1 = check 0 4 8
      diag2 = check 6 4 2
  in
     if row1 || row2 || row3 || col1 || col2 || col3 || diag1 || diag2 then
       Ok model.currentPlayer
     else
       Err "Not there yet!"

update : MyEvent -> Model -> (Model, Cmd MyEvent)
update msg model =
  let
      changePlayer p = case p of
                      A -> B
                      B -> A
                      _ -> A
      staleMate : Array Player -> Bool
      staleMate ary = (0 == length(filter (\x -> x == Unclaimed) ary))

  in
    case msg of
      Reset ->
        initialModel ! []

      CheckWinner player currentPlayerShouldChange time ->
        if staleMate model.boxes then
          { model | winner = Just Unclaimed } ! []
        else if currentPlayerShouldChange then
          case playerWon player model of
            Ok player -> { model
                         | winner = Just player
                         } ! []

            Err _     -> { model
                         | currentPlayer = changePlayer player
                         } ! []
        else
          model ! []


      Clicked index -> onClicked model index

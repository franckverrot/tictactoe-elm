module Update exposing (update)

import Array                   exposing (..)
import EventHandlers.OnClicked
import Model                   exposing (..)
import MyEvent                 exposing (..)
import Player                  exposing (..)

changePlayer : Player -> Player
changePlayer p = case p of
                   A -> B
                   B -> A
                   _ -> A

staleMate : Array Player -> Bool
staleMate ary = (0 == length(filter (\x -> x == Unclaimed) ary))

type alias GameStatus = Result String Player

playerWon : Player -> Model -> GameStatus
playerWon player model =
  let
      check : Player -> List Int -> Array Player -> Bool
      check player indices ary =
        fromList indices
          |> map (\index -> (get index ary |> Maybe.withDefault Unclaimed))
          |> filter ((==) player)
          |> length
          |> (==) 3

      currentPlayerWinning : Player -> Array Player -> Bool
      currentPlayerWinning currentPlayer boxes =
        fromList [
          -- rows     -- cols    -- diags
          [0, 1, 2] , [0, 3, 6], [0, 4, 8]
        , [3, 4, 5] , [1, 4, 7], [6, 4, 2]
        , [6, 7, 8] , [2, 5, 8]]
          |> map (\indices -> check currentPlayer indices boxes)
          |> filter ((==) True)
          |> isEmpty |> not

  in
     case currentPlayerWinning player model.boxes of
       True  -> Ok player
       False -> Err "Not there yet!"

update : MyEvent -> Model -> (Model, Cmd MyEvent)
update msg model =
  case msg of
    Reset -> initialModel ! []

    CheckWinner player currentPlayerShouldChange time ->
      if staleMate model.boxes then
        { model | winner = Just Unclaimed } ! []
      else
        case currentPlayerShouldChange of
          True -> case playerWon player model of
                    Ok player -> { model | winner        = Just player         } ! []
                    Err _     -> { model | currentPlayer = changePlayer player } ! []

          False -> model ! []

    Clicked index -> EventHandlers.OnClicked.onClicked model index

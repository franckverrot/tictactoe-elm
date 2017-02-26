module Update exposing ( update
                       , changePlayer
                       , currentPlayerWinning
                       )

import Array                   exposing (..)
import EventHandlers.OnClicked
import GameEvent               exposing (..)
import GameLogic               exposing (noneUnclaimed)
import Model                   exposing (..)
import Models.Box              exposing (..)
import Player                  exposing (..)

changePlayer : Player -> Player
changePlayer p = case p of
                   A -> B
                   B -> A
                   _ -> A

type alias GameStatus = Result String Player

winningCombos : List (List Int)
winningCombos =
  [ -- rows     -- cols    -- diags
    [0, 1, 2] , [0, 3, 6], [0, 4, 8]
  , [3, 4, 5] , [1, 4, 7], [6, 4, 2]
  , [6, 7, 8] , [2, 5, 8]]

currentPlayerWinning : Player -> Array Box -> Bool
currentPlayerWinning currentPlayer boxes =
  let
      checkPlayerPositionsInList : Player -> List Int -> Array Box -> Bool
      checkPlayerPositionsInList player indices ary =
        fromList indices
          |> map (\index -> (get index ary |> Maybe.withDefault (Box Unclaimed)))
          |> filter
               (\x -> case x of
                        (Box boxPlayer) -> boxPlayer == player)
          |> length
          |> (==) 3
  in
      winningCombos
        |> List.map (\indices -> checkPlayerPositionsInList currentPlayer indices boxes)
        |> List.filter ((==) True)
        |> List.isEmpty |> not

playerWon : Player -> Model -> GameStatus
playerWon player model =
  case currentPlayerWinning player model.boxes of
    True  -> Ok player
    False -> Err "Not there yet!"

update : GameEvent -> Model -> (Model, Cmd GameEvent)
update msg model =
  case msg of
    Reset -> initialModel ! []

    CheckWinner player currentPlayerShouldChange _ ->
      if noneUnclaimed model.boxes then
        case playerWon player model of
          -- There's a winner
          Ok player -> { model | winner = Just player         } ! []
          -- it's a draw
          Err _     -> { model | winner = Just Unclaimed } ! []

      else
        case currentPlayerShouldChange of
          -- Legal move
          True -> case playerWon player model of
                    -- There's a winner
                    Ok player -> { model | winner        = Just player         } ! []
                    -- Let's switch players
                    Err _     -> { model | currentPlayer = changePlayer player } ! []

          -- Illegal move, same player should play again
          False -> model ! []

    Clicked (Box player) index -> EventHandlers.OnClicked.onClicked model index

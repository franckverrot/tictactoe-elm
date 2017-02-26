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

update : GameEvent -> Model -> (Model, Cmd GameEvent)
update msg model =
  case msg of
    Reset -> initialModel ! []

    CheckWinner player currentPlayerShouldChange _ ->
      let
          (nextPlayer, winner) =
            if noneUnclaimed model.boxes then
              if currentPlayerWinning player model.boxes then
                -- There's a winner
                (player, Just player)
              else
                -- it's a draw
                (Unclaimed, Just Unclaimed)

            else
              case currentPlayerShouldChange of
                -- Legal move
                True ->
                  if currentPlayerWinning player model.boxes then
                    -- There's a winner
                    (player, Just player)
                  else
                    -- Let's switch players
                    (changePlayer player, Nothing)

                -- Illegal move, same player should play again
                False ->
                  (player, Nothing)

      in
          { model
          | winner        = winner
          , currentPlayer = nextPlayer
          } ! []

    BoxClicked (Box player) index -> EventHandlers.OnClicked.onClicked model index

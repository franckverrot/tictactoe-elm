module Update exposing ( update
                       , changePlayer
                       , currentPlayerWinning
                       )

import Array                   exposing (..)
import EventHandlers.OnClicked
import GameEvent               exposing (..)
import GameLogic               exposing (..)
import Model                   exposing (..)
import Models.Box              exposing (..)
import Player                  exposing (..)

changePlayer : Player -> Player
changePlayer p = case p of
                   A -> B
                   B -> A
                   _ -> A

{-| This data structure represents the list of combinations
that lead to a win, given that the board looks like:

----------------------------
-----| Col 1 | Col 2 | Col 3|
Row 1|    0  |    1  |    2 |
Row 2|    3  |    4  |    5 |
Row 3|    6  |    7  |    8 |
----------------------------
-}
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
          moreTurns       = areMoreTurnsInGame model.boxes
          moveWasValid    = currentPlayerShouldChange
          playerIsWinning = currentPlayerWinning player model.boxes
          (nextPlayer, winner) =
            case (moreTurns, moveWasValid, playerIsWinning) of

              -- Illegal move, same player should play again
              ( True, False,     _) -> (player, Nothing)

               -- Let's switch players
              ( True,  True, False) -> (changePlayer player, Nothing)

              -- There's a winner
              (    _,     _,  True) -> (player, Just player)

              -- It's a draw
              (    _,     _, False) -> (Unclaimed, Just Unclaimed)
      in
          { model
          | winner        = winner
          , currentPlayer = nextPlayer
          } ! []

    BoxClicked (Box player) index -> EventHandlers.OnClicked.onClicked model index

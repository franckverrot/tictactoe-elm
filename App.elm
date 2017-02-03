import Html exposing (..)
import Html.Events exposing (..)
import Array exposing (..)
import Maybe exposing (..)
import Result exposing (..)
import Debug exposing (..)
import Task exposing (..)
import Time exposing (..)

type Player = A
            | B
            | Unclaimed

type alias Model = { boxes  : Array Player
                   , currentPlayer   : Player
                   , winner : Maybe Player
                   }

type MyEvent = Clicked Int
             | CheckWinner Player Bool Time
             | Reset

myModel : Model
myModel = { boxes = fromList [Unclaimed,Unclaimed,Unclaimed,Unclaimed,Unclaimed,Unclaimed,Unclaimed,Unclaimed,Unclaimed]
          , currentPlayer = A
          , winner = Nothing
          }

main : Program Never Model MyEvent
main = program { init = (myModel, Cmd.none)
               , view  = view
               , update = update
               , subscriptions = \x -> Sub.none
               }

showPlayer : Player -> String
showPlayer player =
  case player of
    A -> "A"
    B -> "B"
    Unclaimed -> "?"

showcurrentPlayer player = text("Hey " ++ (showPlayer player) ++ ", it's your currentPlayer")

showBox : Int -> Model -> String
showBox index model =
  let
     player = get index model.boxes
  in
     showPlayer(Maybe.withDefault Unclaimed player)


view : Model -> Html MyEvent
view model =
  let
     box i = button [ onClick (Clicked i)] [ (text (showBox i model)) ]
  in
     case model.winner of
       Nothing -> div [] [ box 0
                         , box 1
                         , box 2
                         , br [][]
                         , box 3
                         , box 4
                         , box 5
                         , br [][]
                         , box 6
                         , box 7
                         , box 8
                         , br [][]
                         , showcurrentPlayer model.currentPlayer]
       Just Unclaimed -> div [] [ text("Stalemate!!1!1!")
                                , button [ onClick Reset ] [ text "Reset" ] ]
       Just winner -> div [] [ text("Player " ++ (showPlayer winner) ++ " wins!")
                             , button [ onClick Reset ] [ text "Reset" ] ]

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
        myModel ! []

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


      Clicked index ->
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

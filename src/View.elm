module View exposing ( view
                     )

import Array           exposing (..)
import CssTypes        exposing (..)
import Html            exposing (..)
import Html.Attributes exposing (..)
import Html.Events     exposing (..)
import Model           exposing (..)
import GameEvent       exposing (..)
import Player          exposing (..)

{ id, class, classList } =
  indexNamespace

view : Model -> Html GameEvent
view model =
  let
     box index = get index model.boxes
                   |> Maybe.withDefault Unclaimed
                   |> \currentBox ->
                        button
                          [ onClick (Clicked index), class [ Box, (PlayerColor currentBox) ] ]
                          [ (text <| Player.show currentBox) ]

     showPlayer player = div
                           [ class [ Footer ] ]
                           [ text("Hey " ++ (Player.show player) ++ ", it's your turn") ]

     showDeadEnd msg   = div [ class [ DeadEndMessage ] ]
                           [ h2 [] [ text msg ]
                           , button [ onClick Reset, class [ Box, ResetButton ] ] [ text "Reset" ] ]

     boxes = case model.winner of
               Nothing        -> div [ class [ Container ] ]
                                   [ box 0 , box 1 , box 2 , br [][]
                                   , box 3 , box 4 , box 5 , br [][]
                                   , box 6 , box 7 , box 8 , br [][]
                                   , showPlayer model.currentPlayer]

               Just Unclaimed -> showDeadEnd
                                   <| "Draw!!1!1!"

               Just winner    -> showDeadEnd
                                   <| "Player " ++ (Player.show winner) ++ " wins!"
  in
     div
       [ id Page ]
       [ h1 [ class [ Header ] ] [ text "Tic Tac Toe in Elm" ]
       , p
           [ class [ GithubLink ] ]
           [ a
               [ href "https://github.com/franckverrot/tictactoe-elm" ]
               [ text "Source code on GitHub" ]
           ]
       , boxes
       ]

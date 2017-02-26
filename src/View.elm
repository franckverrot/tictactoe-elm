module View exposing ( view
                     )

import Array           exposing (..)
import CssTypes        exposing (..)
import Html            exposing (..)
import Html.Attributes exposing (..)
import Html.Events     exposing (..)
import Model           exposing (..)
import Models.Box as M exposing (..)
import GameEvent       exposing (..)
import Player          exposing (..)

{ id, class, classList } =
  indexNamespace

view : Model -> Html GameEvent
view model =
  let
     boxAttributes : Int -> (Player, List (Attribute GameEvent))
     boxAttributes index = case get index model.boxes of
                             Just (M.Box Unclaimed) -> (Unclaimed, [ onClick (BoxClicked (M.Box Unclaimed) index) ])
                             Just (M.Box a)         -> (a, [])
                             Nothing                -> (Unclaimed, [])

     boxHtml : Int -> Html GameEvent
     boxHtml index = boxAttributes index
                       |> \(player, attributes) ->
                             button
                               ([ class [ CssTypes.Box, (PlayerColor player) ] ] ++ attributes)
                               [ text <| showPlayer player ]

     showTurn player = div
                           [ class [ Footer ] ]
                           [ text("Hey " ++ (showPlayer player) ++ ", it's your turn") ]

     showDeadEnd msg   = div [ class [ DeadEndMessage ] ]
                           [ h2 [] [ text msg ]
                           , button [ onClick Reset, class [ CssTypes.Box, ResetButton ] ] [ text "Reset" ] ]

     boxes = case model.winner of
               Nothing        -> div [ class [ Container ] ]
                                   [ boxHtml 0, boxHtml 1, boxHtml 2, br [][]
                                   , boxHtml 3, boxHtml 4, boxHtml 5, br [][]
                                   , boxHtml 6, boxHtml 7, boxHtml 8, br [][]
                                   , showTurn model.currentPlayer]

               Just Unclaimed -> showDeadEnd
                                   <| "Draw!!1!1!"

               Just winner    -> showDeadEnd
                                   <| "Player " ++ (showPlayer winner) ++ " wins!"
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

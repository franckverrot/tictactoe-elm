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

boxCssClass : Box -> Classes
boxCssClass (M.Box player) = PlayerColor player

view : Model -> Html GameEvent
view model =
  let
     boxButton index = get index model.boxes
                         |> Maybe.withDefault (M.Box Unclaimed)
                         |> \currentBox ->
                              button
                                [ onClick (BoxClicked currentBox index)
                                , class [ CssTypes.Box, (boxCssClass currentBox) ]
                                ]
                                [ (text <| showBox currentBox) ]

     showTurn player = div
                           [ class [ Footer ] ]
                           [ text("Hey " ++ (showPlayer player) ++ ", it's your turn") ]

     showDeadEnd msg   = div [ class [ DeadEndMessage ] ]
                           [ h2 [] [ text msg ]
                           , button [ onClick Reset, class [ CssTypes.Box, ResetButton ] ] [ text "Reset" ] ]

     boxes = case model.winner of
               Nothing        -> div [ class [ Container ] ]
                                   [ boxButton 0, boxButton 1, boxButton 2, br [][]
                                   , boxButton 3, boxButton 4, boxButton 5, br [][]
                                   , boxButton 6, boxButton 7, boxButton 8, br [][]
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

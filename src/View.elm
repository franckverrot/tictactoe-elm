module View exposing ( view
                     )

import Array       exposing (..)
import CssTypes    exposing (..)
import Html        exposing (..)
import Html.Events exposing (..)
import Model       exposing (..)
import MyEvent     exposing (..)
import Player      exposing (..)

{ id, class, classList } =
  indexNamespace

view : Model -> Html MyEvent
view model =
  let
     showBox : Int -> Model -> String
     showBox index model = get index model.boxes
                             |> Maybe.withDefault Unclaimed
                             |> Player.show

     box i = div
               [ onClick (Clicked i), class [ Box ] ]
               [ (text (showBox i model)) ]

     showPlayer player = div
                           [ class [ Footer ] ]
                           [ text("Hey " ++ (Player.show player) ++ ", it's your turn") ]

     boxes = case model.winner of
               Nothing        -> div [ class [ Container ] ]
                                   [ box 0 , box 1 , box 2 , br [][]
                                   , box 3 , box 4 , box 5 , br [][]
                                   , box 6 , box 7 , box 8 , br [][]
                                   , showPlayer model.currentPlayer]

               Just Unclaimed -> div [ ]
                                   [ text("Draw!!1!1!")
                                   , button [ onClick Reset ] [ text "Reset" ] ]

               Just winner    -> div [ ]
                                   [ text("Player " ++ (Player.show winner) ++ " wins!")
                                   , button [ onClick Reset ] [ text "Reset" ] ]

  in
     div
       [ id Page ]
       [ h1 [ class [ Header ] ] [ text "Tic Tac Toe in Elm" ]
       , boxes ]

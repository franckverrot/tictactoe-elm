module View exposing (..)

import Array       exposing (..)
import Html        exposing (..)
import Html.Events exposing (..)
import Model       exposing (..)
import MyEvent     exposing (..)
import Player      exposing (..)
import Result      exposing (..)

view : Model -> Html MyEvent
view model =
  let
     showBox : Int -> Model -> String
     showBox index model = get index model.boxes
                             |> Maybe.withDefault Unclaimed
                             |> Player.show

     box i = button [ onClick (Clicked i)] [ (text (showBox i model)) ]

     showPlayer player = text("Hey " ++ (Player.show player) ++ ", it's your turn")

  in
     case model.winner of
       Nothing        -> div [] [ box 0 , box 1 , box 2 , br [][]
                                , box 3 , box 4 , box 5 , br [][]
                                , box 6 , box 7 , box 8 , br [][]
                                , showPlayer model.currentPlayer]

       Just Unclaimed -> div [] [ text("Draw!!1!1!")
                                , button [ onClick Reset ] [ text "Reset" ] ]

       Just winner    -> div [] [ text("Player " ++ (Player.show winner) ++ " wins!")
                                , button [ onClick Reset ] [ text "Reset" ] ]


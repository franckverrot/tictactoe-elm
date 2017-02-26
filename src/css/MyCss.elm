module MyCss exposing (..)

import Css           exposing (..)
import Css.Colors    exposing (..)
import Css.Elements  exposing (body, li)
import Css.Namespace exposing (namespace)
import CssTypes      exposing (..)
import Player        exposing (..)

css =
  (stylesheet << namespace indexNamespace.name)
  [ body
    [
    ]
  , id Page
    [ padding2 (pct 4) (pct 10)
    , margin zero
    , fontFamilies  ["Verdana", "Arial"]
    ]
  , class Header
    [
      textAlign center
    ]
  , class GithubLink
    [
      textAlign center
    ]
  , class Container
    [
      textAlign center
    ]
  , class DeadEndMessage
    [
      textAlign center
    , fontSize (px 24)
    , padding (pct 5)
    ]
  , class Box
    [ display inlineBlock
    , backgroundColor blue
    , margin4 (px 10) (px 0) (px 0) (pct 2)
    , flexGrow (int 1)
    , width (pct 20)
    , textAlign center
    , fontSize (px 30)
    , fontWeight bold
    , padding2 (pct 5) (pct 0)
    , color silver
    , textDecoration none
    , borderStyle none
    , cursor pointer
    , outline none
    ]
  , class (PlayerColor A)
    [
      backgroundColor red
    , cursor notAllowed
    ]
  , class (PlayerColor B)
    [
      backgroundColor blue
    , cursor notAllowed
    ]
  , class (PlayerColor Unclaimed)
    [
      backgroundColor silver
      , hover [
          backgroundColor gray
        ]
    ]
  , class ResetButton
    [ display inlineBlock
    , width (pct 100)
    , margin (pct 0)
    ]
  , class Footer
    [ fontSize (px 25)
    , padding (px 20)
    ]
  ]

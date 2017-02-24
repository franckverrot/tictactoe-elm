module CssTypes exposing ( Classes(..)
                         , Ids(..)
                         , indexNamespace)

import Html.CssHelpers exposing (withNamespace)
import Player          exposing (..)

type Classes
  = Box
  | Header
  | GithubLink
  | Container
  | Footer
  | DeadEndMessage
  | ResetButton
  | PlayerColor Player

type Ids
  = Page

indexNamespace : Html.CssHelpers.Namespace String class id msg
indexNamespace =
  withNamespace "index"


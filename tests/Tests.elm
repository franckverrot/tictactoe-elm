module Tests  exposing (..)

import Test   exposing (..)
import Expect
import Fuzz   exposing (list, int, tuple, string)
import String
import List   exposing (append)

import Unit.ModelTests  exposing (modelTests)
import Unit.PlayerTests exposing (playerTests)
import Unit.UpdateTests exposing (updateTests)


all : Test
all =
  modelTests
  |> append playerTests
  |> append updateTests
  |> describe "Test Suite"

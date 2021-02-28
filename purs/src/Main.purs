module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)

import Geo3x3 as Geo3x3

main :: Effect Unit
main = do
  log (Geo3x3.encode 35.65858 139.745433 14)
  log (show (Geo3x3.decode "E3793653391822"))

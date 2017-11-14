module Main where

import Lib

main :: IO ()
main = do
  parser "1+1"
  parser "1 * 2 + 4"

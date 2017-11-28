module Main where

import Lib

main :: IO ()
main = do
  res <- parseFile "test/data/program-1.c"
  case res of
    Left e -> putStrLn e
    Right p -> print p

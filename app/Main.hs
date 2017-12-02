module Main where

import System.Environment (getArgs)

import qualified Repl


main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> Repl.repl "test/data/program-1.c"
    (a:_) -> Repl.repl a

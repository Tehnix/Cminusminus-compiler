module Main where

import qualified Parser.Lexer
import qualified Parser.Parser

main :: IO ()
main = do
  Parser.Lexer.main
  Parser.Parser.main

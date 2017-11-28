module Main where

import qualified Parser.LexerTest
import qualified Parser.ParserTest

main :: IO ()
main = do
  Parser.LexerTest.main
  Parser.ParserTest.main

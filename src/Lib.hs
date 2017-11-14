module Lib where

import qualified Parser.Lexer as Lexer
import qualified Parser.Parser as Parser

parser :: String -> IO ()
parser = print . Parser.parse . Lexer.lexer



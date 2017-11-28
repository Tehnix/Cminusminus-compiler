module Parser.ParserTest where

import Data.List.NonEmpty
import Test.Hspec

import Parser.Common
import Parser.Lexer
import Parser.Literal
import Parser.Parser
import Parser.Syntax

parse = parseTokens . lexer

main :: IO ()
main =
  hspec $
  describe "Parser.parse" $
  it "parses declaration" $
  parse "extern void hey(void);" `shouldBe`
  (Decl (DclVoid Extern (DclParmDcl (Identifier "hey") ParmTypeVoid :| [])) EOF)

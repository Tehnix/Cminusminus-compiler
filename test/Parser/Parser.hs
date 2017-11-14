module Parser.Parser where
  
import Control.Exception (evaluate)
import Test.Hspec
import Data.List.NonEmpty

import Parser.Lexer
import Parser.Parser
import Parser.Syntax
import Parser.Common
import Parser.Literal

parser = parse . lexer

main :: IO ()
main =
  hspec $
  describe "Parser.parse" $ do
    it "parses declaration" $
      parser "extern void hey(void);" `shouldBe` (Decl (DclVoid Extern ((Identifier "hey",ParmTypeVoid) :| [])) EOF)

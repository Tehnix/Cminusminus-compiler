module Parser.Lexer where

import Control.Exception (evaluate)
import Test.Hspec

import Parser.Lexer
import Parser.Token
import Parser.Literal
import Parser.Common

main :: IO ()
main =
  hspec $
  describe "Lexer.lexer" $ do
    it "tokenizes characters" $
      lexer "'c' 'h' '\n' '\0'" `shouldBe`
      [TokenChar (CharCon 'c'), TokenChar (CharCon 'h'), TokenChar (CharCon '\n'), TokenChar (CharCon '\0')]
    it "tokenizes strings" $ do
      let tokens = lexer "\"Heythere\" \"Another\""
      tokens `shouldBe` [TokenString (StringCon "Heythere"), TokenString (StringCon "Another")]
    it "tokenizes digits" $
      lexer "10 30 22" `shouldBe` [TokenInt (IntCon 10), TokenInt (IntCon 30), TokenInt (IntCon 22)]
    it "tokenizes variables" $ lexer "myVar" `shouldBe` [TokenId (Identifier "myVar")]
    it "tokenizes // line comments" $
      lexer "10 // Checking it out\n 20" `shouldBe`
      [TokenInt (IntCon 10), TokenComment " Checking it out", TokenInt (IntCon 20)]
    it "tokenizes /* */ block comments" $
      lexer "10 /* Checking it out*/ 20" `shouldBe`
      [TokenInt (IntCon 10), TokenMultiLineComment " Checking it out", TokenInt (IntCon 20)]
    it "tokenizes /* */ block comments with newlines in them" $
      lexer "10 /* Checking it \nout */ 20" `shouldBe`
      [TokenInt (IntCon 10), TokenMultiLineComment " Checking it \nout ", TokenInt (IntCon 20)]
    it "tokenizes strings with space in them" $ do
      let tokens = lexer "\"Hey there\" \"Another\""
      tokens `shouldBe` [TokenString (StringCon "Hey there"), TokenString (StringCon "Another")]
    it "throws error on ' (single quote) in char" $ do
      let tokens = lexer "'\''"
      (evaluate tokens) `shouldThrow` anyErrorCall
    it "throws error on \\ (backslash) in char" $ do
      let tokens = lexer "'\\'"
      (evaluate tokens) `shouldThrow` anyErrorCall
    it "throws error on \\n (newline) in string" $ do
      let tokens = lexer "\"\n\""
      (evaluate tokens) `shouldThrow` anyErrorCall
    it "tokenizes keywords before identifiers" $ do
      lexer "extern" `shouldBe` [TokenReserved TokenExtern]
      lexer "if" `shouldBe` [TokenReserved TokenIf]
      lexer "else" `shouldBe` [TokenReserved TokenElse]
      lexer "while" `shouldBe` [TokenReserved TokenWhile]
      lexer "for" `shouldBe` [TokenReserved TokenFor]
      lexer "return" `shouldBe` [TokenReserved TokenReturn]
    it "tokenizes binary operators" $ do
      lexer "+" `shouldBe` [TokenBinOp Plus]
      lexer "-" `shouldBe` [TokenBinOp Minus]
      lexer "*" `shouldBe` [TokenBinOp Mul]
      lexer "/" `shouldBe` [TokenBinOp Div]
    it "tokenizes relational operators" $ do
      lexer "==" `shouldBe` [TokenRelOp Equal]
      lexer "!=" `shouldBe` [TokenRelOp NotEqual]
      lexer "<=" `shouldBe` [TokenRelOp LessThanEqual]
      lexer "<" `shouldBe` [TokenRelOp LessThan]
      lexer ">=" `shouldBe` [TokenRelOp GreaterThanEqual]
      lexer ">" `shouldBe` [TokenRelOp GreaterThan]
    it "tokenizes logical operators" $ do
      lexer "&&" `shouldBe` [TokenLogicalOp And]
      lexer "||" `shouldBe` [TokenLogicalOp Or]
    it "tokenizes unary operators" $ do
      lexer "!" `shouldBe` [TokenUnaryOp BoolNegation]
      -- Unary negation is a bit of a special case since it's handled in 
      -- the parser.
      lexer "-1" `shouldBe` [TokenBinOp Minus,TokenInt (IntCon 1)]
    it "tokenizes types" $ do
      lexer "char" `shouldBe` [TokenType TTypeChar]
      lexer "int" `shouldBe` [TokenType TTypeInt]
      lexer "void" `shouldBe` [TokenType TTypeVoid]
    it "tokenizes symbols" $ do
      lexer "," `shouldBe` [TokenComma]
      lexer ";" `shouldBe` [TokenSemiColon]
      lexer "=" `shouldBe` [TokenAssign]
    it "tokenizes brackets" $ do
      lexer "(" `shouldBe` [TokenBracket LeftSide Paren]
      lexer ")" `shouldBe` [TokenBracket RightSide Paren]
      lexer "[" `shouldBe` [TokenBracket LeftSide Bracket]
      lexer "]" `shouldBe` [TokenBracket RightSide Bracket]
      lexer "{" `shouldBe` [TokenBracket LeftSide Brace]
      lexer "}" `shouldBe` [TokenBracket RightSide Brace]

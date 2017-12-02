module Render.Token where

import Text.PrettyPrint

import Parser.Common
import Parser.Token
import Render.Common

-- | Render a token to a string.
renderToken :: Token -> String
renderToken = render . ppr 0

instance Pretty Reserved where
  ppr p e =
    case e of
      TokenIf -> text "if"
      TokenElse -> text "else"
      TokenWhile -> text "while"
      TokenFor -> text "for"
      TokenReturn -> text "return"
      TokenExtern -> text "extern"

instance Pretty TType where
  ppr p e =
    case e of
      TTypeChar -> text "char"
      TTypeInt -> text "int"
      TTypeFloat -> text "float"
      TTypeDouble -> text "double"
      TTypeLong -> text "long"
      TTypeVoid -> text "void"

instance Pretty Token where
  ppr p e =
    case e of
      TokenBinOp binOp -> ppr p binOp
      TokenUnaryOp unOp -> ppr p unOp
      TokenRelOp relOp -> ppr p relOp
      TokenLogicalOp logOp -> ppr p logOp
      TokenComment com -> text com
      TokenMultiLineComment mulCom -> text mulCom
      TokenPrintf -> text "printf"
      TokenId i -> ppr p i
      TokenInt i -> ppr p i
      TokenFloat i -> ppr p i
      TokenDouble i -> ppr p i
      TokenLong i -> ppr p i
      TokenChar c -> ppr p c
      TokenString s -> ppr p s
      TokenAssign -> text "="
      TokenBracket LeftSide Paren -> lparen
      TokenBracket RightSide Paren -> rparen
      TokenBracket LeftSide Bracket -> lbrack
      TokenBracket RightSide Bracket -> rbrack
      TokenBracket LeftSide Brace -> lbrace
      TokenBracket RightSide Brace -> rbrace
      TokenComma -> text ","
      TokenSemiColon -> text ";"
      TokenReserved r -> ppr p r
      TokenType t -> ppr p t

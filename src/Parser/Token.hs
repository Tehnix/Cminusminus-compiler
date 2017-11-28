module Parser.Token where

import Parser.Common
import Parser.Literal

data TokenLoc = TokenLoc
  { lineNumber :: !Int
  , columnNumber :: !Int
  , preceedingChars :: !Int
  } deriving (Eq, Show)

-- | Reserved keywords.
data Reserved
  = TokenIf
  | TokenElse
  | TokenWhile
  | TokenFor
  | TokenReturn
  | TokenExtern
  deriving (Eq, Show)

-- | Types.
data TType
  = TTypeChar
  | TTypeInt
  | TTypeVoid
  deriving (Eq, Show)

-- | All terminals neeeds to be representable as a token.
data Token
  = TokenBinOp BinOperator
  | TokenUnaryOp UnaryOperator
  | TokenRelOp RelOperator -- 
  | TokenLogicalOp LogicalOperator -- logical_op
  | TokenComment String -- // comments
  | TokenMultiLineComment String -- /* comments */
  | TokenId Identifier -- id
  | TokenInt IntCon -- intcon
  | TokenChar CharCon -- charcon
  | TokenString StringCon -- stringcon
  | TokenAssign -- '=' as in assignment
  | TokenBracket Side -- All braces, '(', ')', '[', ']', '{', '}'
                 Bracket
  | TokenComma -- ','
  | TokenSemiColon -- ';'
  | TokenReserved Reserved
  | TokenType TType
  deriving (Eq, Show)

module Parser.Common where

import Data.List.NonEmpty

-- | Represent either no value or one-or-many values.
data Many a
  = Many (NonEmpty a)
  | Empty
  deriving (Eq, Show)

-- | Represent the index as an expression, or no index if it's not an array.
data ArrayIndex a
  = Index a
  | NotArray
  deriving (Eq, Show)

-- | Represent if a parameter is an array or not.
data IsArrayParameter
  = IsArrayParm
  | IsNotArrayParm
  deriving (Eq, Show)

-- | Represent the prototype declaration type.
data DeclarationType
  = Normal
  | Extern
  deriving (Eq, Show)

-- | Unary Operators.
data UnaryOperator =
  BoolNegation
  deriving (Eq, Show)

-- | Binary Operators.
data BinOperator
  = Plus
  | Minus
  | Mul
  | Div
  deriving (Eq, Show)

-- | Relational Operators.
data RelOperator
  = Equal
  | NotEqual
  | LessThanEqual
  | LessThan
  | GreaterThanEqual
  | GreaterThan
  deriving (Eq, Show)

-- | Logical Operators.
data LogicalOperator
  = And
  | Or
  deriving (Eq, Show)

-- | General enclosures/brackets.
data Bracket
  = Paren -- ()
  | Bracket -- []
  | Brace -- {}
  deriving (Eq, Show)

-- | Specifying which side the brackets are found on.
data Side
  = LeftSide
  | RightSide
  deriving (Eq, Show)

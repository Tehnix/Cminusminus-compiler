module Parser.Common where

import Data.List.NonEmpty (NonEmpty)
import qualified Data.List.NonEmpty as NonE


manyToList :: Many a -> [a]
manyToList m = 
  case m of
    Empty -> []
    Many ms -> NonE.toList ms

-- | Represent either no value or one-or-many values.
data Many a
  = Many (NonEmpty a)
  | Empty
  deriving (Eq, Show)

data IsPtr
  = IsRefPtr
  | IsDerefPtr
  | IsNotPtr
  deriving (Eq, Show, Ord)

-- | Represent if a parameter is an array or not.
data IsArrayParameter
  = IsArrayParm
  | IsNotArrayParm
  deriving (Eq, Show)

-- | Represent the prototype declaration type.
data Visibility
  = Normal
  | Extern
  deriving (Eq, Show)

-- | Unary Operators.
data UnaryOperator
  = BoolNegation
  | Increment
  | Decrement
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

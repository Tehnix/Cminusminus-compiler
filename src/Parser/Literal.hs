module Parser.Literal where

import Parser.Common

-- | An integer literal, __intcon__, defined as:
--     digit { digit }
-- with _digit_ being defined as:
--     digit	::=	0 | 1 | ... | 9
-- FIXME: This should be a Data.Int.Int32
newtype IntCon =
  IntCon Int
  deriving (Eq, Show, Ord)

newtype FloatCon =
  FloatCon Float
  deriving (Eq, Show, Ord)

newtype DoubleCon =
  DoubleCon Double
  deriving (Eq, Show, Ord)

-- FIXME: This should be a Data.Int.Int64
newtype LongCon =
  LongCon Double
  deriving (Eq, Show, Ord)

-- | A character literal, __charcon__, defined as:
--     'ch' | '\n' | '\0'
-- where _ch_ denotes any printable ASCII character, as specified by
-- `isprint()`, other than \ (backslash) and ' (single quote).
newtype CharCon =
  CharCon Char
  deriving (Eq, Show, Ord)

-- | A string literal, __stringcon__, defined as:
--     "{ch}"
-- where _ch_ denotes any printable ASCII character (as specified by
-- `isprint()`) other than " (double quotes) and the newline character.
newtype StringCon =
  StringCon String
  deriving (Eq, Show, Ord)

-- | An identifier, __id__, defined as:
--     letter { letter | digit | _ }
-- with _letter_ being defined as:
--     a | b | ... | z | A | B | ... | Z
-- See `IntCon` for the definition of _digit_.
data Identifier =
  Identifier IsPtr
             String
  deriving (Show)

-- We want identifiers to match on name, so we implement our own equality/ordering
-- instances.
instance Eq Identifier where
  (Identifier _ name1) == (Identifier _ name2) = name1 == name2
instance Ord Identifier where
  (Identifier _ name1) `compare` (Identifier _ name2) = name1 `compare` name2

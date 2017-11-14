module Parser.Literal where

-- | An integer literal, __intcon__, defined as:
--     digit { digit }
-- with _digit_ being defined as:
--     digit	::=	0 | 1 | ... | 9
newtype IntCon =
  IntCon Int
  deriving (Eq, Show)

-- | A character literal, __charcon__, defined as:
--     'ch' | '\n' | '\0'
-- where _ch_ denotes any printable ASCII character, as specified by 
-- `isprint()`, other than \ (backslash) and ' (single quote).
newtype CharCon =
  CharCon Char
  deriving (Eq, Show)

-- | A string literal, __stringcon__, defined as:
--     "{ch}"
-- where _ch_ denotes any printable ASCII character (as specified by 
-- `isprint()`) other than " (double quotes) and the newline character.
newtype StringCon =
  StringCon String
  deriving (Eq, Show)

-- | An identifier, __id__, defined as:
--     letter { letter | digit | _ }
-- with _letter_ being defined as:
--     a | b | ... | z | A | B | ... | Z
-- See `IntCon` for the definition of _digit_.
newtype Identifier =
  Identifier String
  deriving (Eq, Show)

module Render.Common where

import Data.Foldable
import Data.List.NonEmpty
import Text.PrettyPrint

import Parser.Common
import Parser.Literal

tabWidth :: Int
tabWidth = 2

newline :: Doc
newline = text "\n"

newlineSemi :: Doc
newlineSemi = semi <> newline

newlineBraces :: Int -> Doc -> Doc
newlineBraces n d =
  lbrace <> newline <> indent n <> d <> newline <> rbrace <> newline

indent :: Int -> Doc
indent n = text $ replicate n ' '

class Pretty p where
  pprs :: Doc -> Int -> p -> Doc
  pprs s i p = s <> ppr i p
  ppr :: Int -> p -> Doc
  pp :: p -> Doc
  pp = ppr 0

instance (Pretty a) => Pretty (Maybe a) where
  ppr p e =
    case e of
      Nothing -> empty
      Just a -> ppr p a

instance (Pretty a) => Pretty (NonEmpty a) where
  ppr = pprs (comma <> space)
  pprs sep p e =
    case e of
      a :| [] -> ppr p a
      a :| as -> ppr p a <> sep <> pprs sep p as

instance {-# OVERLAPPABLE #-} (Pretty a) => Pretty [a] where
  ppr = pprs (comma <> space)
  pprs sep p e =
    case e of
      [] -> empty
      (a:[]) -> ppr p a
      (a:as) -> pprs sep p [a] <> pprs sep p as

instance (Pretty a) => Pretty (Many a) where
  ppr = pprs (comma <> space)
  pprs sep p e =
    case e of
      Empty -> empty
      Many as -> pprs sep p as

instance Pretty UnaryOperator where
  ppr p e =
    case e of
      BoolNegation -> text "!"
      Increment -> text "++"
      Decrement -> text "--"

instance Pretty BinOperator where
  ppr p e =
    case e of
      Plus -> text "+"
      Minus -> text "-"
      Mul -> text "*"
      Div -> text "/"

instance Pretty RelOperator where
  ppr p e =
    case e of
      Equal -> text "=="
      NotEqual -> text "!="
      LessThanEqual -> text "<="
      LessThan -> text "<"
      GreaterThanEqual -> text ">="
      GreaterThan -> text ">"

instance Pretty LogicalOperator where
  ppr p e =
    case e of
      And -> text "&&"
      Or -> text "||"

instance Pretty IntCon where
  ppr p e =
    case e of
      IntCon i -> int i

instance Pretty FloatCon where
  ppr p e =
    case e of
      FloatCon i -> float i

instance Pretty DoubleCon where
  ppr p e =
    case e of
      DoubleCon i -> double i

instance Pretty LongCon where
  ppr p e =
    case e of
      LongCon i -> double i

instance Pretty CharCon where
  ppr p e =
    case e of
      CharCon c -> quotes (char c)

instance Pretty StringCon where
  ppr p e =
    case e of
      StringCon s -> doubleQuotes (text s)

instance Pretty Identifier where
  ppr p e =
    case e of
      Identifier isPtr i -> ppr p isPtr <> text i

instance Pretty IsPtr where
  ppr p e =
    case e of
      IsRefPtr -> text "&"
      IsDerefPtr -> text "*"
      IsNotPtr -> empty

instance Pretty Visibility where
  ppr p e =
    case e of
      Normal -> empty
      Extern -> text "extern" <> space

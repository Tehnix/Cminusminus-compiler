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
newlineBraces n d = lbrace <> d <> newline <> indent n <> rbrace

indent :: Int -> Doc
indent n = text $ replicate n ' '

class Pretty p where
  ppr :: Int -> p -> Doc
  pp :: p -> Doc
  pp = ppr 0

instance (Pretty a) => Pretty (Maybe a) where
  ppr p e =
    case e of
      Nothing -> empty
      Just a -> ppr p a

instance (Pretty a) => Pretty (NonEmpty a) where
  ppr p e =
    case e of
      a :| [] -> ppr p a
      a :| as ->
        ppr p a <> foldl' (\p1 p2 -> p1 <> comma <> space <> ppr p p2) empty as

instance (Pretty a) => Pretty (Many a) where
  ppr p e =
    case e of
      Empty -> empty
      Many as -> ppr p as

instance Pretty UnaryOperator where
  ppr p e =
    case e of
      BoolNegation -> text "!"

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
      Identifier i -> text i

instance Pretty IsArrayParameter where
  ppr p e =
    case e of
      IsArrayParm -> lbrack <> rbrack
      IsNotArrayParm -> empty

instance (Pretty a) => Pretty (ArrayIndex a) where
  ppr p e =
    case e of
      Index index -> brackets (ppr p index)
      NotArray -> empty

instance Pretty DeclarationType where
  ppr p e =
    case e of
      Normal -> empty
      Extern -> text "extern" <> space

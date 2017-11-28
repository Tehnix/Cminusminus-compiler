module Render.Syntax where

import Text.PrettyPrint

import Parser.Common
import Parser.Syntax
import Render.Common

-- | Render the program AST to a string.
renderProg :: Prog -> String
renderProg = render . ppr 0

instance Pretty VarDeclaration where
  ppr p e =
    case e of
      Var i index -> ppr p i <> ppr p index

instance Pretty Type where
  ppr p e =
    case e of
      TypeChar -> text "char" <> space
      TypeInt -> text "int" <> space

instance Pretty ParmTypes where
  ppr p e =
    case e of
      ParmTypeVoid -> text "void"
      ParmTypes parms -> ppr p parms

instance Pretty ParmType where
  ppr p e =
    case e of
      ParmType t i isArray -> ppr p t <> space <> ppr p i <> ppr p isArray

instance Pretty Assignment where
  ppr p e =
    case e of
      AssignId i index e -> ppr p i <> ppr p index <> equals <> ppr p e

instance Pretty Expr where
  ppr p e =
    case e of
      Negate e -> text "-" <> ppr p e
      NegateBool e -> text "!" <> ppr p e
      BinOp op e1 e2 -> ppr p e1 <> ppr p op <> ppr p e2
      RelOp op e1 e2 -> ppr p e1 <> ppr p op <> ppr p e2
      LogOp op e1 e2 -> ppr p e1 <> ppr p op <> ppr p e2
      IdFun i e -> ppr p i <> parens (ppr p e)
      Id index i -> ppr p i <> ppr p index
      Brack e -> parens $ ppr p e
      LitInt i -> ppr p i
      LitChar c -> ppr p c
      LitString s -> ppr p s

instance Pretty Stmt where
  ppr p e =
    case e of
      If e s ->
        newline <> indent p <> text "if" <> space <> parens (ppr p e) <> space <>
        ppr p s
      IfElse e s1 s2 ->
        newline <> indent p <> text "if" <> space <> parens (ppr p e) <> space <>
        ppr p s1 <>
        space <>
        text "else" <>
        space <>
        ppr p s2
      While e s ->
        newline <> indent p <> text "while" <> parens (ppr p e) <> ppr p s
      For a1 e a2 s ->
        newline <> indent p <> text "for" <>
        parens (ppr p a1 <> semi <> ppr p e <> semi <> ppr p a2) <>
        ppr p s
      StmtAssgn a -> newline <> indent p <> ppr p a <> semi
      Return e ->
        newline <> indent p <> text "return" <> space <> ppr p e <> semi
      StmtId i e ->
        newline <> indent p <> ppr p i <> parens (ppr p e) <> newlineSemi
      StmtBlock s -> newlineBraces p (ppr (p + tabWidth) s)
      EmptyStmt -> indent p <> semi

instance Pretty FunVarDcl where
  ppr p e =
    case e of
      FunVarDcl Empty -> empty
      FunVarDcl vs -> ppr p vs <> semi

instance Pretty FunVarTypeDcl where
  ppr p e =
    case e of
      FunVarTypeDcl t v -> ppr p t <> ppr p v

instance Pretty Function where
  ppr p e =
    case e of
      Fun t i parms v s ->
        ppr p t <> space <> ppr p i <> parens (ppr p parms) <> space <>
        newlineBraces p (ppr (p + tabWidth) v <> ppr (p + tabWidth) s)
      FunVoid i parms v s ->
        text "void" <> space <> ppr p i <> parens (ppr p parms) <> space <>
        newlineBraces p (ppr (p + tabWidth) v <> ppr (p + tabWidth) s)

instance Pretty DclParmDcl where
  ppr p e =
    case e of
      DclParmDcl i parms -> ppr p i <> parens (ppr p parms)

instance Pretty Declaration where
  ppr p e =
    case e of
      Dcl dt t parms -> ppr p dt <> ppr p t <> ppr p parms
      DclVoid dt parms -> ppr p dt <> ppr p parms
      DclVar t v -> ppr p t <> ppr p v

instance Pretty Prog where
  ppr p e =
    case e of
      Decl d parms -> ppr p d <> newlineSemi <> newline <> ppr p parms
      Func f parms -> ppr p f <> ppr p parms
      EOF -> empty

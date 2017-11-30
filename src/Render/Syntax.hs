{-# LANGUAGE FlexibleInstances #-}

module Render.Syntax where

import Prelude hiding (exp)

import Data.List.NonEmpty
import Text.PrettyPrint
import qualified Data.Map.Strict as Map

import Parser.Common
import Parser.Literal
import Parser.Syntax
import Render.Common

-- | Render the program AST to a string.
renderProg :: Prog -> String
renderProg = render . ppr 0

instance Pretty ArrayIndex where
  ppr p e =
    case e of
      Index index -> brackets (ppr p index)
      NotArray -> empty

instance Pretty VarDeclaration where
  ppr p e =
    case e of
      Var ident index -> ppr p ident <> ppr p index

instance Pretty Type where
  ppr p e =
    case e of
      TypeChar -> text "char" <> space
      TypeInt -> text "int" <> space
      TypeFloat -> text "float" <> space
      TypeDouble -> text "double" <> space
      TypeLong -> text "long" <> space
      TypeVoid -> text "void" <> space
      TypeArray ty -> text "*" <> ppr p ty

instance Pretty Parameter where
  ppr p e =
    case e of
      EmptyParam -> text "void"
      Param parms -> ppr p (Map.toList parms)

instance Pretty (Identifier, Type) where
  ppr p e =
    case e of
      (ident, (TypeArray ty)) ->
        ppr p ty <> space <> ppr p ident <> lbrack <> rbrack
      (ident, ty) ->
        ppr p ty <> space <> ppr p ident

instance Pretty Assignment where
  ppr p e =
    case e of
      AssignId ty ident index exp ->
        ppr p ty <> ppr p ident <> ppr p index <> equals <> ppr p exp
      PrefixInc ident -> text "++" <> ppr p ident
      PostfixInc ident -> ppr p ident <> text "++"
      PrefixDec ident -> text "--" <> ppr p ident
      PostfixDec ident -> ppr p ident <> text "--"

instance Pretty Expr where
  ppr p e =
    case e of
      Negate exp -> text "-" <> ppr p exp
      NegateBool exp -> text "!" <> ppr p exp
      BinOp op exp1 exp2 -> ppr p exp1 <> ppr p op <> ppr p exp2
      RelOp op exp1 exp2 -> ppr p exp1 <> ppr p op <> ppr p exp2
      LogOp op exp1 exp2 -> ppr p exp1 <> ppr p op <> ppr p exp2
      IdFun ident exp -> ppr p ident <> parens (pprs comma p exp)
      Id index ident -> ppr p ident <> ppr p index
      Brack exp -> parens $ ppr p exp
      LitInt i -> ppr p i
      LitFloat i -> ppr p i
      LitDouble i -> ppr p i
      LitLong i -> ppr p i
      LitChar c -> ppr p c
      LitString s -> ppr p s

instance Pretty Stmt where
  ppr p e =
    case e of
      If exp stmt ->
        newline <> indent p <> text "if" <> space <> parens (ppr p exp) <> space <>
        ppr p stmt
      IfElse exp stmt1 stmt2 ->
        newline <> indent p <> text "if" <> space <> parens (ppr p exp) <> space <>
        ppr p stmt1 <>
        space <>
        text "else" <>
        space <>
        ppr p stmt2
      While exp stmt ->
        newline <> indent p <> text "while" <> parens (ppr p exp) <> space <>
        ppr p stmt
      For a1 exp a2 stmt ->
        newline <> indent p <> text "for" <>
        parens
          (ppr p a1 <> semi <> space <> ppr p exp <> semi <> space <> ppr p a2) <>
        space <>
        ppr p stmt
      StmtAssgn assgn -> newline <> indent p <> ppr p assgn <> semi
      Return exp ->
        newline <> indent p <> text "return" <> space <> ppr p exp <> semi
      StmtId ident exp ->
        newline <> indent p <> ppr p ident <> parens (ppr p exp) <> newlineSemi
      StmtBlock stmt ->
        lbrace <> (ppr (p + tabWidth) stmt) <> newline <> indent p <> rbrace
      EmptyStmt -> indent p <> semi

instance Pretty FunVarDcl where
  ppr p e =
    case e of
      FunVarDcl Empty -> empty
      FunVarDcl (Many (v :| vs)) -> ppr p v <> semi <> newline <> ppr p vs

instance Pretty [FunVarTypeDcl] where
  ppr p e =
    case e of
      [] -> empty
      (FunVarTypeDcl ty vars:[]) -> indent p <> ppr p ty <> ppr p vars <> semi
      (fv:fvs) -> ppr p [fv] <> newline <> ppr p fvs

instance Pretty FunVarTypeDcl where
  ppr p e =
    case e of
      FunVarTypeDcl ty vars -> ppr p ty <> ppr p vars

instance Pretty Function where
  ppr p e =
    case e of
      Fun ty ident parms varDecl stmt ->
        ppr p ty <> ppr p ident <> parens (ppr p parms) <> space <>
        newlineBraces
          (p + tabWidth)
          (ppr (p + tabWidth) varDecl <> ppr (p + tabWidth) stmt)

instance Pretty DclParmDcl where
  ppr p e =
    case e of
      DclParmDcl ident parms -> ppr p ident <> parens (ppr p parms)

instance Pretty Declaration where
  ppr p e =
    case e of
      Dcl visibility ty parms -> ppr p visibility <> ppr p ty <> ppr p parms
      DclVar visibility ty var -> ppr p visibility <> ppr p ty <> ppr p var

instance Pretty Prog where
  ppr p e =
    case e of
      Decl dcl prog -> ppr p dcl <> newlineSemi <> newline <> ppr p prog
      Func func prog -> ppr p func <> ppr p prog
      EOF -> empty

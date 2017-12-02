module Parser.Syntax where

import Data.List.NonEmpty
import Data.Map.Strict (Map)

import Parser.Common
import Parser.Literal

-- | Grammar Production: _prog_.
data Prog
  = Decl Declaration -- 	{ dcl ';'  |  func }
         Prog
  | Func Function
         Prog
  | EOF
  deriving (Eq, Show)

-- | Grammar Production: _dcl_.
data Declaration
  = Dcl Visibility -- [ extern ] type id '(' parm_types ')' { ',' id '(' parm_types ')' }
        Type
        (NonEmpty DclParmDcl)
  | DclVar Visibility -- [ extern ] type var_decl { ',' var_decl }
           Type
           (NonEmpty VarDeclaration)
  deriving (Eq, Show)

-- | Grammar Production: _func_.
data Function =
  Fun Type -- type id '(' parm_types ')' '{' { type var_decl { ',' var_decl } ';' } { stmt } '}'
      Identifier
      Parameter
      FunVarDcl
      (Many Stmt)
  deriving (Eq, Show)

data DclParmDcl =
  DclParmDcl Identifier
             Parameter
  deriving (Eq, Show)

-- | Grammar Production: _var_decl_.
data VarDeclaration =
  Var Identifier -- id [ '[' intcon ']' ]
      ArrayIndex
  deriving (Eq, Show)

newtype FunVarDcl =
  FunVarDcl (Many FunVarTypeDcl)
  deriving (Eq, Show)

data FunVarTypeDcl =
  FunVarTypeDcl Type
                (NonEmpty VarDeclaration)
  deriving (Eq, Show)

-- | Grammar Production: _type_.
data Type
  = TypeChar -- char
  | TypeString -- string
  | TypeInt -- int
  | TypeFloat -- float
  | TypeDouble -- double
  | TypeLong -- long
  | TypeVoid -- void
  | TypeArray Type -- array of any type
  deriving (Eq, Show)

-- | Grammar Production: _parm_types_.
data Parameter
  = EmptyParam -- void
  | Param (Map Identifier Type) -- A parameter type, if not void, can be either one or many
  deriving (Eq, Show)

-- | Grammar Production: _stmt_.
data Stmt
  = If Expr -- 	if '(' expr ')' stmt [ else stmt ]
       Stmt
  | IfElse Expr
           Stmt
           Stmt
  | While Expr -- while '(' expr ')' stmt
          Stmt
  | For (Maybe Assignment) -- for '(' [ assg ] ';' [ expr ] ';' [ assg ] ')' stmt
        (Maybe Expr)
        (Maybe Assignment)
        Stmt
  | StmtAssgn Assignment -- assg ';'
  | Return (Maybe Expr) -- return [ expr ] ';'
  | StmtId Identifier -- id '(' [expr { ',' expr } ] ')' ';'
           (Many Expr)
  | StmtPrintf (Many Expr) -- 'printf' '(' [expr { ',' expr } ] ')' ';'
  | StmtBlock (Many Stmt) -- '{' { stmt } '}'
  | EmptyStmt -- ';'
  deriving (Eq, Show)

-- | Grammar Production: _assg_.
data Assignment
  = AssignId (Maybe Type) -- id '[' expr ']' '=' expr
             Identifier
             ArrayIndex
             Expr
  | PrefixInc Identifier -- '++' expr
  | PostfixInc Identifier -- expr '++'
  | PrefixDec Identifier -- '--' expr
  | PostfixDec Identifier -- expr '--'
  deriving (Eq, Show)

-- | Grammar Production: _expr_.
data Expr
  = Negate Expr -- '-' expr
  | NegateBool Expr -- '!' expr
  | BinOp BinOperator -- expr binop expr
          Expr
          Expr
  | RelOp RelOperator
          Expr
          Expr -- expr relop expr
  | LogOp LogicalOperator
          Expr
          Expr -- expr logical_op expr
  | IdFun Identifier -- id [ '(' [expr { ',' expr } ] ')' ]
          (Many Expr)
  | Id ArrayIndex -- id [ '[' expr ']' ]
       Identifier
  | Brack Expr -- '(' expr ')'
  | LitInt IntCon -- intcon
  | LitFloat FloatCon -- floatcon
  | LitDouble DoubleCon -- doublecon
  | LitLong LongCon -- longcon
  | LitChar CharCon -- charcon
  | LitString StringCon -- strincon
  deriving (Eq, Show)

-- | Represent the index as an expression, or no index if it's not an array.
data ArrayIndex
  = Index Expr
  | NotArray
  deriving (Eq, Show)

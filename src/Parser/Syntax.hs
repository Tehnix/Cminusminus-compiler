module Parser.Syntax where

import Data.List.NonEmpty

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
  = Dcl DeclarationType -- [ extern ] type id '(' parm_types ')' { ',' id '(' parm_types ')' }
        Type
        (NonEmpty DclParmDcl)
  | DclVoid DeclarationType -- [ extern ] 'void' id '(' parm_types ')' { ',' id '(' parm_types ')' }
            (NonEmpty DclParmDcl)
  | DclVar Type -- type var_decl { ',' var_decl }
           (NonEmpty VarDeclaration)
  deriving (Eq, Show)

data DclParmDcl =
  DclParmDcl Identifier
             ParmTypes
  deriving (Eq, Show)

-- | Grammar Production: _var_decl_.
data VarDeclaration =
  Var Identifier -- id [ '[' intcon ']' ]
      (ArrayIndex IntCon)
  deriving (Eq, Show)

-- | Grammar Production: _func_.
data Function
  = Fun Type -- type id '(' parm_types ')' '{' { type var_decl { ',' var_decl } ';' } { stmt } '}'
        Identifier
        ParmTypes
        FunVarDcl
        (Many Stmt)
  | FunVoid Identifier -- void id '(' parm_types ')' '{' { type var_decl { ',' var_decl } ';' } { stmt } '}'
            ParmTypes
            FunVarDcl
            (Many Stmt)
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
  | TypeInt -- int
  deriving (Eq, Show)

-- | Grammar Production: _parm_types_.
data ParmTypes
  = ParmTypeVoid -- void
  | ParmTypes (NonEmpty ParmType) -- A parameter type, if not void, can be either one or many
  deriving (Eq, Show)

-- | Internally used in `ParmTypes`
data ParmType =
  ParmType Type -- type id [ '[' ']' ] { ',' type id [ '[' ']' ] }
           Identifier
           IsArrayParameter
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
  | Return (Maybe Expr) -- 	return [ expr ] ';'
  | StmtId Identifier -- 	id '(' [expr { ',' expr } ] ')' ';'
           (Many Expr)
  | StmtBlock (Many Stmt) -- '{' { stmt } '}'
  | EmptyStmt -- ';'
  deriving (Eq, Show)

-- | Grammar Production: _assg_.
data Assignment =
  AssignId Identifier -- id '[' expr ']' '=' expr
           (ArrayIndex Expr)
           Expr
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
  | Id (ArrayIndex Expr) -- id [ '[' expr ']' ]
       Identifier
  | Brack Expr -- '(' expr ')'
  | LitInt IntCon -- intcon
  | LitChar CharCon -- charcon
  | LitString StringCon -- strincon
  deriving (Eq, Show)

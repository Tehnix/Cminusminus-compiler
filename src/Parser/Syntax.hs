module Parser.Syntax where

import Data.List.NonEmpty

import Parser.Literal
import Parser.Common

-- | Grammar Production: _prog_.
data Prog
  = Decl Declaration Prog
  | Func Function Prog
  | EOF
  deriving (Eq, Show)

-- | Grammar Production: _dcl_.
data Declaration 
  = Dcl DeclarationType -- [ extern ] type id '(' parm_types ')' { ',' id '(' parm_types ')' }
        Type
        (NonEmpty (Identifier, ParmTypes))
  | DclVoid DeclarationType -- [ extern ] 'void' id '(' parm_types ')' { ',' id '(' parm_types ')' }
            (NonEmpty (Identifier, ParmTypes))
  deriving (Eq, Show)

-- | Grammar Production: _var_decl_.
data VarDeclaration =
  Var Identifier -- id [ '[' intcon ']' ]
      (ArrayIndex IntCon)
  deriving (Eq, Show)

-- | Grammar Production: _func_.
data Function 
  = Fun Type Identifier ParmTypes FunctionVarDeclaration (Many Stmt)
  | FunVoid Identifier ParmTypes FunctionVarDeclaration (Many Stmt)
  deriving (Eq, Show)

type FunctionVarDeclaration 
  = Many (Type, NonEmpty VarDeclaration)

-- | Grammar Production: _type_.
data Type
  = TypeChar
  | TypeInt
  deriving (Eq, Show)

-- | Grammar Production: _parm_types_.
data ParmTypes
  = ParmTypeVoid
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
  = If Expr
       Stmt
  | IfElse Expr
           Stmt
           Stmt
  | While Expr
          Stmt
  | For (Maybe Assignment)
        (Maybe Expr)
        (Maybe Assignment)
        Stmt
  | Return (Maybe Expr)
  | StmtId Identifier
           (Many Expr)
  | StmtBlock (Many Stmt)
  | EmptyStmt
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

{
module Parser.Parser (parseTokens) where
import Parser.Syntax
import Parser.Token
import Parser.Literal
import Parser.Common
import qualified Data.List.NonEmpty as NonE
import Data.List.NonEmpty (NonEmpty(..))
import qualified Parser.Lexer as Lexer

}

%name parseTokens
%tokentype { Lexer.TokenPos }
%monad { Either Lexer.TokenPos }
%error { parseError }
{- %lexer { Lexer.lexer } { EOF } -}

{- As with the lexer, all our terminals have to be specified here as well. -}
%token 
      {- Literals. -}
      id              { (TokenId $$, _) }
      intcon          { (TokenInt $$, _) }
      charcon         { (TokenChar $$, _) }
      stringcon       { (TokenString $$, _) }
      {- Symbols. -}
      '('             { (TokenBracket LeftSide Paren, _) }
      ')'             { (TokenBracket RightSide Paren, _) }
      '{'             { (TokenBracket LeftSide Brace, _) }
      '}'             { (TokenBracket RightSide Brace, _) }
      '['             { (TokenBracket LeftSide Bracket, _) }
      ']'             { (TokenBracket RightSide Bracket, _) }
      '='             { (TokenAssign, _) }
      ';'             { (TokenSemiColon, _) }
      ','             { (TokenComma, _) }
      {- Unary operators.-}
      '!'             { (TokenUnaryOp BoolNegation, _) }
      {- Binary operator(s. , _)-}
      '+'             { (TokenBinOp Plus, _) }
      '-'             { (TokenBinOp Minus, _) }
      '*'             { (TokenBinOp Mul, _) }
      '/'             { (TokenBinOp Div, _) }
      {- Relational operators.-}
      '=='            { (TokenRelOp Equal, _) }
      '!='            { (TokenRelOp NotEqual, _) }
      '<='            { (TokenRelOp LessThanEqual, _) }
      '<'             { (TokenRelOp LessThan, _) }
      '>='            { (TokenRelOp GreaterThanEqual, _) }
      '>'             { (TokenRelOp GreaterThan, _) }
      {- Logical operators.-}
      '&&'            { (TokenLogicalOp And, _) }
      '||'            { (TokenLogicalOp Or, _) }
      {- Reserved keywords.-}
      'if'            { (TokenReserved TokenIf, _) }
      'else'          { (TokenReserved TokenElse, _) }
      'while'         { (TokenReserved TokenWhile, _) }
      'for'           { (TokenReserved TokenFor, _) }
      'return'        { (TokenReserved TokenReturn, _) }
      'extern'        { (TokenReserved TokenExtern, _) }
      {- Types. -}
      'char'          { (TokenType TTypeChar, _) }
      'int'           { (TokenType TTypeInt, _) }
      'void'          { (TokenType TTypeVoid, _) }

{- Set precedence for the tokens. -}
%left '||'
%left '&&'
%left '==' '!='
%left '<' '<=' '>' '>='
%left '+' '-'
%left '*' '/'
%right NEG '!'
%right '{'
%right 'else'

%%

{-
The $-sign notation works as follows,
let    var   '='    Exp    in     Exp  { Let $2 $4 $6 }
$1     $2    $3     $4     $5     $6
-}

prog :: { Prog }
prog  : dcl ';' prog                            { Decl $1 $3 }
      | func prog                               { Func $1 $2 }
      | {- empty -}                             { EOF }

dcl :: { Declaration }
dcl  : 'extern' type some_id_parm_types         { Dcl Extern $2 (NonE.fromList $3) }
     | 'extern' 'void' some_id_parm_types       { DclVoid Extern (NonE.fromList $3) }
     | type some_id_parm_types                  { Dcl Normal $1 (NonE.fromList $2) }
     | 'void' some_id_parm_types                { DclVoid Normal (NonE.fromList $2) }
     | type some_var_decl                       { DclVar $1 (NonE.fromList $2) }

var_decl :: { VarDeclaration }
var_decl  : id '[' intcon ']'                   { Var $1 (Index $3) }
          | id                                  { Var $1 NotArray }

type :: { Type }
type  : 'char'                                  { TypeChar }
      | 'int'                                   { TypeInt }

parm_types :: { ParmTypes }
parm_types  : 'void'                            { ParmTypeVoid }
            | some_parm_type                    { ParmTypes (NonE.fromList $1) }

func :: { Function } 
func  : type id '(' parm_types ')' '{' many_fun_var_decl many_stmt '}'  
                                                { Fun $1 $2 $4 (funVarToMany $7) (listToMany $8) }
      | 'void' id '(' parm_types ')' '{' many_fun_var_decl many_stmt '}'  
                                                { FunVoid $2 $4 (funVarToMany $7) (listToMany $8) }

stmt :: { Stmt } 
stmt  : 'if' '(' expr ')' stmt_block                    { If $3 $5 }
      | 'if' '(' expr ')' stmt_block 'else' stmt_block  { IfElse $3 $5 $7 }
      | 'while' '(' expr ')' stmt_block                 { While $3 $5 }
      | 'for' '(' maybe_assg ';' maybe_expr 
              ';' maybe_assg ')' stmt_block             { For $3 $5 $7 $9 }
      | stmt_block                                      { $1 }

{- To avoid shift-reduce (mainly on '{' stmt '}'), we extract the stmt
productions that can stand alone, out of _stmt_.
-}
stmt_block :: { Stmt }
stmt_block  : assg ';'                                   { StmtAssgn $1 }
            | '{' many_stmt '}'                          { StmtBlock (listToMany $2) }
            | 'return' maybe_expr ';'                    { Return $2 }
            | id '(' many_expr ')' ';'                   { StmtId $1 (listToMany $3) }
            | ';'                                        { EmptyStmt }

assg :: { Assignment }
assg  : id '[' expr ']' '=' expr                { AssignId $1 (Index $3) $6 }
      | id '=' expr                             { AssignId $1 NotArray $3}

expr :: { Expr }
expr  : '-' expr %prec NEG                      { Negate $2 }
      | '!' expr                                { NegateBool $2 }
      {- We have to expand binop because of different precendences. -}
      | expr '+' expr                           { BinOp Plus $1 $3 }
      | expr '-' expr                           { BinOp Minus $1 $3 }
      | expr '*' expr                           { BinOp Mul $1 $3 }
      | expr '/' expr                           { BinOp Div $1 $3 }
      {- The same with relop, -}
      | expr '==' expr                          { RelOp Equal $1 $3 }
      | expr '!=' expr                          { RelOp NotEqual $1 $3 }
      | expr '<=' expr                          { RelOp LessThanEqual $1 $3 }
      | expr '<' expr                           { RelOp LessThan $1 $3 }
      | expr '>=' expr                          { RelOp GreaterThanEqual $1 $3 }
      | expr '>' expr                           { RelOp GreaterThan $1 $3 }
      {- and logical_op. -}
      | expr '&&' expr                          { LogOp And $1 $3 }
      | expr '||' expr                          { LogOp Or $1 $3 }
      | id '(' many_expr ')'                    { IdFun $1 (listToMany $3) }
      | id '[' expr ']'                         { Id (Index $3) $1 }
      | id                                      { Id (NotArray) $1 }
      | '(' expr ')'                            { Brack $2 }
      | intcon                                  { LitInt $1 }
      | charcon                                 { LitChar $1 }
      | stringcon                               { LitString $1 }



{- An optional `stmt`, i.e. zero or many. In a grammar production this'll 
look something like: { stmt }
-}
many_stmt :: { [Stmt] }
many_stmt  : stmt many_stmt          { $1 : $2 }
           | {- empty -}             { [] }

{- An optional `assg`, i.e. zero or one. In a grammar production this'll 
look something like: [ assg ]
-}
maybe_assg :: { Maybe Assignment }
maybe_assg : assg                    { Just $1 }
           | {- empty -}             { Nothing }

{- An optional `expr`, i.e. zero or one. In a grammar production this'll 
look something like: [ expr ]
-}
maybe_expr :: { Maybe Expr }
maybe_expr : expr                    { Just $1 }
           | {- empty -}             { Nothing }

{- Either zero `expr`, i.e. zero or many. In a grammar production this'll 
look something like: [expr { ',' expr } ]
-}
many_expr :: { [Expr] }
many_expr  : expr ',' many_expr      { $1 : $3 }
           | expr                    { [$1] }
           | {- empty -}             { [] }

{- Either one or many `parm_type`. In a grammar production this'll
look something like: type id [ '[' ']' ] { ',' type id [ '[' ']' ] }
-}
some_parm_type :: { [ParmType] }
some_parm_type  : type id '[' ']' ',' some_parm_type      { ParmType $1 $2 IsArrayParm : $6 }
                | type id '[' ']'                    { [ParmType $1 $2 IsArrayParm] }
                | type id ',' some_parm_type              { ParmType $1 $2 IsNotArrayParm : $4 }
                | type id                            { [ParmType $1 $2 IsNotArrayParm] }

some_id_parm_types :: { [DclParmDcl] }
some_id_parm_types  : id '(' parm_types ')' ',' some_id_parm_types  { DclParmDcl $1 $3 : $6}
                    | id '(' parm_types ')'                         { [DclParmDcl $1 $3] }

{- Either one or many `var_decl`. In a grammar production this'll
look something like: var_decl { ',' var_decl }
-}
some_var_decl :: { [VarDeclaration] }
some_var_decl  : var_decl ',' some_var_decl { $1 : $3 }
               | var_decl                   { [$1] }

{- Either zero or many `type some_var_decl`. In a grammar production this'll
look something like: { type var_decl { ',' var_decl } ';' }
-}
many_fun_var_decl :: { [(Type, [VarDeclaration])] }
many_fun_var_decl : type some_var_decl ';' many_fun_var_decl { ($1, $2) : $4 }
                  | {- empty -}                              { [] }


{

-- | Convert a list to a `Many`, which is either `Empty` or a `NonEmpty a`.
listToMany :: [a] -> Many a   
listToMany [] = Empty
listToMany as = Many (NonE.fromList as)

-- | Construct the `FunctionVarDeclaration`. Note that we rely on 
-- `some_var_decl` to never be an empty list!
funVarToMany :: [(Type, [VarDeclaration])] -> FunVarDcl
funVarToMany []      = FunVarDcl Empty
funVarToMany as      = FunVarDcl $ Many $ NonE.fromList $ sndToSome as
  where 
    sndToSome :: [(Type, [VarDeclaration])] -> [FunVarTypeDcl]
    sndToSome [] = []
    sndToSome ((t, vs):vds) = FunVarTypeDcl t (NonE.fromList vs) : sndToSome vds

-- lexwrap :: (Token -> P a) -> P a
-- lexwrap cont = Lexer.lexer `thenP` \token -> cont token

-- | Express that we encountered a parser error.
parseError :: [Lexer.TokenPos] -> Either Lexer.TokenPos a
parseError [] = error "Parser ended in error!"
parseError (t : ts) = Left t
}

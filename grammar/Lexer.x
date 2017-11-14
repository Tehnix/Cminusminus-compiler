{
module Parser.Lexer (lexer) where
import Parser.Token
import Parser.Literal
import Parser.Common
}

%wrapper "basic"

$digit = 0-9          -- digits
$letter = [a-zA-Z]    -- alphabetic characters
$specialChar = [\'\\]
$specialString = [\"\n]
-- $specialComment = (\/\*)
$graphic = $printable # $white
$graphicComment = [$graphic\n]

@escape = '\\' ($printable | $digit+)
@string = \" ($printable # $specialString)* \"
@char = \' ([$printable\n\0] # $specialChar) \'
@comment = "//".*
@multilineComment = \/\* [$printable\n]* \*\/


tokens :-
  -- We are whitespace insensitive.
  $white+                           ;
  -- Comments.
  @comment                          { \s -> TokenComment (stripComment s) }
  @multilineComment                 { \s -> TokenMultiLineComment (stripMultiLineComment s) }
  -- Symbols.
  "("                               { \_ -> TokenBracket LeftSide Paren }
  ")"                               { \_ -> TokenBracket RightSide Paren }
  "{"                               { \_ -> TokenBracket LeftSide Brace }
  "}"                               { \_ -> TokenBracket RightSide Brace }
  "["                               { \_ -> TokenBracket LeftSide Bracket }
  "]"                               { \_ -> TokenBracket RightSide Bracket }
  ","                               { \_ -> TokenComma }
  ";"                               { \_ -> TokenSemiColon }
  "="                               { \_ -> TokenAssign }
  -- Binary Operators.
  "+"                               { \s -> TokenBinOp Plus}
  "-"                               { \s -> TokenBinOp Minus}
  "*"                               { \s -> TokenBinOp Mul}
  "/"                               { \s -> TokenBinOp Div}
  -- Unary operators.
  "!"                               { \s -> TokenUnaryOp BoolNegation }
  -- Relational Operators.
  "=="                              { \s -> TokenRelOp Equal }
  "!="                              { \s -> TokenRelOp NotEqual }
  "<="                              { \s -> TokenRelOp LessThanEqual }
  "<"                               { \s -> TokenRelOp LessThan }
  ">="                              { \s -> TokenRelOp GreaterThanEqual }
  ">"                               { \s -> TokenRelOp GreaterThan }
  -- Logical Operators.
  "&&"                              { \s -> TokenLogicalOp And }
  "||"                              { \s -> TokenLogicalOp Or }
  -- Reserved keywords.
  "if"                              { \_ -> TokenReserved TokenIf } 
  "else"                            { \_ -> TokenReserved TokenElse }
  "while"                           { \_ -> TokenReserved TokenWhile } 
  "for"                             { \_ -> TokenReserved TokenFor } 
  "return"                          { \_ -> TokenReserved TokenReturn } 
  "extern"                          { \_ -> TokenReserved TokenExtern }
  -- Types.
  "char"                            { \_ -> TokenType TTypeChar }
  "int"                             { \_ -> TokenType TTypeInt }
  "void"                            { \_ -> TokenType TTypeVoid }
  -- Literals.
  $digit+                           { \s -> TokenInt (IntCon (read s)) }
  @char                             { \s -> TokenChar (CharCon (stripChar s)) }
  @string                           { \s -> TokenString (StringCon (stripString s)) }
  $letter [$letter $digit \_]*      { \s -> TokenId (Identifier s) }


{
stripChar :: String -> Char
stripChar (_:c:_) = c

stripString :: String -> String
stripString s = tail (init s)

stripComment :: String -> String
stripComment (_:_:s) = s

stripMultiLineComment :: String -> String
stripMultiLineComment (_:_:s) = (init . init) s

lexer :: String -> [Token]
lexer = alexScanTokens
}

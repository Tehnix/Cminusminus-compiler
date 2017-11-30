{
module Parser.Lexer (lexer, tokenPosition, TokenPos) where
import Parser.Token
import Parser.Literal
import Parser.Common

}

%wrapper "posn"

$digit = 0-9          -- digits
$letter = [a-zA-Z]    -- alphabetic characters
$specialChar = [\'\\]
$specialString = [\"\n]
-- $specialComment = (\/\*)
$graphic = $printable # $white
$graphicComment = [$graphic\n]
$deref = [\*]

@digit = $digit+
@expon = [eE] [\-\+]? @digit
@float = @digit \. @digit @expon? | @digit @expon
@escape = '\\' ($printable | $digit+)
@string = \" ($printable # $specialString)* \"
@char = \' ([$printable\n\0] # $specialChar) \'
@comment = "//".*
@multilineComment = \/\* [$printable\n]* \*\/
@identifier = $letter [$letter $digit \_]*


tokens :-
  -- We are whitespace insensitive.
  $white+                           ;
  -- Comments.
  @comment                          { \p s -> (TokenComment (stripComment s), p) }
  @multilineComment                 { \p s -> (TokenMultiLineComment (stripMultiLineComment s), p) }
  -- Symbols.
  "("                               { \p _ -> (TokenBracket LeftSide Paren, p) }
  ")"                               { \p _ -> (TokenBracket RightSide Paren, p) }
  "{"                               { \p _ -> (TokenBracket LeftSide Brace, p) }
  "}"                               { \p _ -> (TokenBracket RightSide Brace, p) }
  "["                               { \p _ -> (TokenBracket LeftSide Bracket, p) }
  "]"                               { \p _ -> (TokenBracket RightSide Bracket, p) }
  ","                               { \p _ -> (TokenComma, p) }
  ";"                               { \p _ -> (TokenSemiColon, p) }
  "="                               { \p _ -> (TokenAssign, p) }
  -- Binary Operators.
  "+"                               { \p s -> (TokenBinOp Plus, p) }
  "-"                               { \p s -> (TokenBinOp Minus, p) }
  "*"                               { \p s -> (TokenBinOp Mul, p) }
  "/"                               { \p s -> (TokenBinOp Div, p) }
  -- Unary operators.
  "!"                               { \p s -> (TokenUnaryOp BoolNegation, p) }
  "++"                              { \p s -> (TokenUnaryOp Increment, p) }
  "--"                              { \p s -> (TokenUnaryOp Decrement, p) }
  -- Relational Operators.
  "=="                              { \p s -> (TokenRelOp Equal, p) }
  "!="                              { \p s -> (TokenRelOp NotEqual, p) }
  "<="                              { \p s -> (TokenRelOp LessThanEqual, p) }
  "<"                               { \p s -> (TokenRelOp LessThan, p) }
  ">="                              { \p s -> (TokenRelOp GreaterThanEqual, p) }
  ">"                               { \p s -> (TokenRelOp GreaterThan, p) }
  -- Logical Operators.
  "&&"                              { \p s -> (TokenLogicalOp And, p) }
  "||"                              { \p s -> (TokenLogicalOp Or, p) }
  -- Reserved keywords.
  "if"                              { \p _ -> (TokenReserved TokenIf, p) }
  "else"                            { \p _ -> (TokenReserved TokenElse, p) }
  "while"                           { \p _ -> (TokenReserved TokenWhile, p) }
  "for"                             { \p _ -> (TokenReserved TokenFor, p) }
  "return"                          { \p _ -> (TokenReserved TokenReturn, p) }
  "extern"                          { \p _ -> (TokenReserved TokenExtern, p) }
  -- Types.
  "char"                            { \p _ -> (TokenType TTypeChar, p) }
  "int"                             { \p _ -> (TokenType TTypeInt, p) }
  "double"                          { \p _ -> (TokenType TTypeDouble, p) }
  "float"                           { \p _ -> (TokenType TTypeFloat, p) }
  "long"                            { \p _ -> (TokenType TTypeLong, p) }
  "void"                            { \p _ -> (TokenType TTypeVoid, p) }
  -- Literals. FIXME: long and double are missing.
  @float                            { \p s -> (TokenFloat (FloatCon (read s)), p) }
  @digit                            { \p s -> (TokenInt (IntCon (read s)), p) }
  @char                             { \p s -> (TokenChar (CharCon (stripChar s)), p) }
  @string                           { \p s -> (TokenString (StringCon (stripString s)), p) }
  "*" @identifier                   { \p s -> (TokenId (Identifier IsDerefPtr (tail s)), p) }
  "&" @identifier                   { \p s -> (TokenId (Identifier IsRefPtr (tail s)), p) }
  @identifier                       { \p s -> (TokenId (Identifier IsNotPtr s), p) }


{
stripChar :: String -> Char
stripChar (_:c:_) = c
stripChar s = error $ "stripChar: Failed stripping character: " ++ s

stripString :: String -> String
stripString s = tail (init s)

stripComment :: String -> String
stripComment (_:_:s) = s
stripComment s = error $ "stripComment: Failed stripping comment: " ++ s

stripMultiLineComment :: String -> String
stripMultiLineComment (_:_:s) = (init . init) s
stripMultiLineComment s = error $ "stripMultiLineComment: Failed stripping comment: " ++ s

tokenPosition :: TokenPos -> TokenLoc
tokenPosition (_, AlexPn pc l c) = TokenLoc { lineNumber = l, columnNumber = c, preceedingChars = pc }

type TokenPos = (Token, AlexPosn)

lexer :: String -> [TokenPos]
lexer = alexScanTokens
}

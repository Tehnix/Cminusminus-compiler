module Parser where
  
import qualified Parser.Lexer as Lexer
import qualified Parser.Parser as Parser
import Parser.Syntax
import Parser.Token
import Render.Token

-- | Parse a string.
parseString :: String -> (Either String Prog)
parseString s =
  let res = (Parser.parseTokens . Lexer.lexer) s
  in case res of
        Left e -> Left (formatParseError "" s e)
        Right p -> Right p

-- | Parse a file.
parseFile :: FilePath -> IO (Either String Prog)
parseFile f = do
  contents <- readFile f
  let res = (Parser.parseTokens . Lexer.lexer) contents
  case res of
    Left e -> return $ Left (formatParseError f contents e)
    Right p -> return $ Right p

-- | Format the parse error to a user friendly string. The output will look 
-- something like:
-- 
-- test/data/program-1.c:1:24: error:
-- parse error on input ‘*’
-- 
-- int avg(int count, int *value) {
--                        ^
--
formatParseError :: FilePath -> String -> Lexer.TokenPos -> String
formatParseError f contents tokPos@(t, _) =
  let tokL = Lexer.tokenPosition tokPos
      lineN = lineNumber tokL
      colN = columnNumber tokL
      line = (lines contents) !! (lineN - 1)
      tokLength = length $ renderToken t
  in f ++
    ":" ++
    show lineN ++
    ":" ++
    show colN ++
    ": error:\n    " ++
    "parse error on input ‘" ++
    renderToken t ++
    "’" ++ "\n\n" ++ line ++ "\n" ++ (replicate (colN - 1) ' ') ++ (replicate tokLength '^') ++ "\n"

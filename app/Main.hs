module Main where

import Text.Pretty.Simple (pPrint)
import qualified Data.Map.Strict as Map

import Lib
import Render.Syntax
import Parser.Syntax
import Eval.SymbolTable
import Eval.Eval
import qualified Repl


main :: IO ()
main = Repl.repl "test/data/program-1.c"

parseProgram :: (Prog -> IO ()) -> IO ()
parseProgram handler = do
  res <- parser "test/data/program-1.c"
  case res of
    Left e -> putStrLn e
    Right p -> handler p

main1 :: IO ()
main1 = parseProgram pPrint

main2 :: IO ()
main2 = parseProgram $ putStrLn . renderProg

main3 :: IO ()
main3 = parseProgram $ \p -> do
  let (SymbolTable _ table) = symbolTable p
  pPrint $ Map.keys table

main4 :: IO ()
main4 = parseProgram $ \p -> do
  let (SymbolTable _ table) = symbolTable p
  case lookupIdent "main" table of
    Nothing -> putStrLn "main function not found!"
    Just fun -> pPrint $ executionLines fun

main5 :: String -> IO [Evaluable]
main5 f = do
  res <- parser "test/data/program-1.c"
  case res of
    Left _ -> error "Ugh, didn't go well!"
    Right p -> do
      let (SymbolTable _ table) = symbolTable p
      case lookupIdent f table of
        Nothing -> error $ f ++ " function not found!"
        Just fun -> return $ executionLines fun

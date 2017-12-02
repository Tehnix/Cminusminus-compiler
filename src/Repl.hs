module Repl where

import System.Console.Haskeline

import Eval.Eval
import Eval.SymbolTable
import Parser


-- | Start a repl by jumping into the `main` function of the program.
repl :: String -> IO ()
repl filename = do
  -- Parse the program.
  res <- parseFile filename
  case res of
    Left e -> putStrLn e
    Right p -> do
      -- Build up the global symbol table.
      let globalSymTable@(SymbolTable _ table) = symbolTable p
          funName = "main"
      -- Step into the `main` function.
      case lookupIdent funName table of
        Nothing -> error $ funName ++ " function not found!"
        Just fun -> do
          -- Step into the function and convert the function to execution
          -- lines.
          let newSymTable = stepIntoScope globalSymTable
              ex = executionLines fun
          (_, _, _, finalSymbolTable) <- scopedRepl newSymTable 1 0 ex
          putStrLn "End of Program"
          endOfProgramLoop finalSymbolTable
  where
    endOfProgramLoop sTable = do
      cmd <- runInputT defaultSettings getInput
      case cmd of
        Next _ -> do
          putStrLn "Next cannot be used at the end of the program."
          endOfProgramLoop sTable
        Trace ident -> do
          traceIdentifier ident sTable
          endOfProgramLoop sTable
        Print ident -> do
          printIdentifier ident sTable
          endOfProgramLoop sTable
        Invalid -> do
          putStrLn "Incorrect command usage: try 'next [lines]'"
          endOfProgramLoop sTable

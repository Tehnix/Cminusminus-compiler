module Repl where

import Eval.Eval (scopedRepl, executionLines)
import Eval.SymbolTable
import Parser


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
          let newSymTable = stepIntoFunction globalSymTable
              ex = executionLines fun
          scopedRepl newSymTable 0 ex
          return ()

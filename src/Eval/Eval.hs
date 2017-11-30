{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE StandaloneDeriving      #-}
module Eval.Eval where

import qualified Data.List.NonEmpty as NonE
import qualified Data.Map.Strict as Map
import Text.Pretty.Simple (pPrint)
import Text.Read (readMaybe)

import Eval.SymbolTable
import Parser.Syntax
import Parser.Common
import Parser.Literal


class (Show a) => Eval a where
  eval :: Int -> SymbolTable -> a -> SymbolTable
  eval _ symTable _ =  symTable

-- | We use an existential quantification to allow `ExecutionLine` to be 
-- a heterogenerous list, which can have any value, `a`, which is `Evaluable`.
data Evaluable = forall a . (Show a, Eval a) => MkEvaluable a
-- Because we are dealing with existential quantification, we can't derive
-- `Show` directly, but we can make a standalone derived instance of it.
deriving instance Show Evaluable

data LiteralValue 
  = IntVal Int 
  | FloatVal Float 
  | DoubleVal Double
  | LongVal Double
  | CharVal Char
  | StringVal String
  deriving (Eq, Show)

-- | A builder function for our evaluables.
mkEvaluable :: (Eval a) => a -> Evaluable
mkEvaluable = MkEvaluable

executionLines :: SymbolTableData -> [Evaluable]
executionLines (FunctionAttr _ parms (FunVarDcl varDcls) stmts) = do
  let parms' = [mkEvaluable parms]
      varDcls' = map mkEvaluable (manyToList varDcls)
      stmts' = map mkEvaluable (manyToList stmts)
  parms' ++ varDcls' ++ stmts'
executionLines _ = error "Not yet implemented!"

instance Eval Parameter where
  eval _ symTable EmptyParam = symTable
  eval execLine (SymbolTable parent symData) (Param parms) =
    let traceHistory = TraceHistory {executionLine = execLine, traceValue = TraceNotAssigned}
        parmsAttr = Map.map (\ty -> IdentifierAttr (Just ty) NotArray [traceHistory]) parms
    in SymbolTable { symbolTableParent = parent
                   , symbolTableData = Map.unionWith mergeAttr symData parmsAttr
                   }

instance Eval FunVarTypeDcl where
  eval execLine (SymbolTable parent symData) (FunVarTypeDcl ty varDcls) =
    let traceHistory = TraceHistory {executionLine = execLine, traceValue = TraceNotAssigned}
        varAttr = Map.fromList $ map (\(Var ident isArray) -> (ident, IdentifierAttr (Just ty) isArray [traceHistory])) (NonE.toList varDcls)
    in SymbolTable { symbolTableParent = parent
                   , symbolTableData = Map.unionWith mergeAttr symData varAttr
                   }

instance Eval Stmt where
  eval execLine (SymbolTable parent symData) stmt =
    SymbolTable { symbolTableParent = parent
                , symbolTableData = Map.unionWith mergeAttr symData stmtAttr
                }
    where
      stmtAttr = 
        case stmt of 
          StmtAssgn (AssignId ty ident isArray exp) -> 
            let traceHistory = TraceHistory {executionLine = execLine, traceValue = TraceValue exp}
            in Map.fromList [(ident, IdentifierAttr ty isArray [traceHistory])]
          _ -> Map.empty


evalExpr :: t -> SymbolTable -> Expr -> (SymbolTable, LiteralValue)
evalExpr execLine (SymbolTable parent symData) expr =
  (SymbolTable { symbolTableParent = parent
               , symbolTableData = Map.unionWith mergeAttr symData exprAttr
               }
  , val)
  where
    (exprAttr, val) =
      case expr of
        LitInt (IntCon i) -> (symData, IntVal i)
        _ -> (symData, IntVal 0)

data Cmd
  = Next Int
  | Trace String
  | Print String
  | Invalid

parseCmd :: String -> Cmd
parseCmd cmd =
  case words cmd of
    [] -> Next 1
    ("next":[]) -> Next 1
    ("next":steps:[]) ->
      case readMaybe steps :: Maybe Int of
        Nothing -> Invalid
        Just s -> Next s
    ("trace":ident:[]) -> Trace ident
    ("print":ident:[]) -> Print ident
    _ -> Invalid

scopedRepl :: SymbolTable -> Int -> [Evaluable] -> IO SymbolTable
scopedRepl startSymTable exLineNo execLines = do
  putStrLn "Loading main..."
  -- Step through each line.
  loop exLineNo 1 startSymTable execLines
  where
    loop :: Int -> Int -> SymbolTable -> [Evaluable] -> IO SymbolTable
    loop n _ symTable@(SymbolTable _ symData) [] = do
      putStr $ (show n) ++ ": "
      pPrint $ symData
      putStrLn "END OF PROGrAM"
      return symTable
    loop n 1 symTable ex@((MkEvaluable e):exs) = do
      -- Await user input.
      putStr "next> "
      cmd <- getLine
      case parseCmd cmd of
        Next stepsToTake -> do
          let newSymTable@(SymbolTable _ newSymData) = eval n symTable e
          putStr $ (show n) ++ ": "
          pPrint $ newSymData
          pPrint e
          -- Continue stepping through the lines.
          loop (n + 1) stepsToTake newSymTable exs
        Trace ident -> do
          case lookupIdent ident (symbolTableData symTable) of
            Nothing -> putStrLn "Identifier not found"
            Just lSymData ->
              case extractHistory lSymData of
                Nothing -> putStrLn "Trying to trace something that is not an identifier!"
                Just history -> mapM_ (printTrace ident) (reverse history)
          loop n 1 symTable ex
        Print ident -> do
          case lookupIdent ident (symbolTableData symTable) of
            Nothing -> putStrLn "Identifier not found"
            Just lSymData -> 
              case extractValue lSymData of
                Nothing -> putStrLn "Trying to print something that is not an identifier!"
                Just val -> pPrint val
          loop n 1 symTable ex
        Invalid -> do
          putStrLn "Invalid command"
          loop n 1 symTable ex
    loop n step symTable ((MkEvaluable e):exs) = do
      let newSymTable = eval n symTable e
      loop (n + 1) (step - 1) newSymTable exs

    printTrace :: String -> TraceHistory -> IO ()
    printTrace name TraceHistory{executionLine=execLine, traceValue=val} =
      putStrLn $ "  " ++ name ++ " = " ++ show val ++ " at line " ++ show execLine

module Eval.SymbolTable where

import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import qualified Data.List.NonEmpty as NonE

import Parser.Syntax
import Parser.Common
import Parser.Literal

-- | The symbol table consist of an optional parent symbol table, and a Map containing
-- the symbol names as key and the data as values.
data SymbolTable = SymbolTable
  { symbolTableParent :: Maybe SymbolTable
  , symbolTableData :: (Map Identifier SymbolTableData)
  }
  deriving (Show)

data TraceHistory = TraceHistory
  { executionLine :: Int
  , traceValue :: TraceValue
  }
  deriving (Show)

data TraceValue = TraceValue Expr | TraceNotAssigned

instance Show TraceValue where
  show TraceNotAssigned = "N/A"
  show (TraceValue expr) = show expr

-- | The attributes a symbol can have.
data SymbolTableData
  = PrototypeAttr Visibility
                  (Maybe Type)
                  Parameter
  | PrototypVarAttr Visibility (Maybe Type) ArrayIndex
  | FunctionAttr (Maybe Type) Parameter FunVarDcl (Many Stmt)
  | IdentifierAttr (Maybe Type) ArrayIndex [TraceHistory]
  deriving (Show)


-- | Create the starting global symbol table from the main program, by flattening
-- the `Prog` AST, exposing the global functions/variables as keys in the map.
symbolTable :: Prog -> SymbolTable
symbolTable prog = do
  let p = flattenProgram prog
  SymbolTable { symbolTableParent = Nothing
              , symbolTableData = (Map.fromList p)
              }
  where
    flattenProgram :: Prog -> [(Identifier, SymbolTableData)]
    flattenProgram p =
      case p of
        Decl (Dcl dclTy ty dcls) prog ->
          map (\(DclParmDcl ident parms) -> (ident, PrototypeAttr dclTy (Just ty) parms)) (NonE.toList dcls) ++ flattenProgram prog
        Decl (DclVar dclTy ty varDcls) prog ->
          map (\(Var ident index) -> (ident, PrototypVarAttr dclTy (Just ty) index)) (NonE.toList varDcls) ++ flattenProgram prog
        Func (Fun ty ident parms varDcls stmts) prog ->
          (ident, FunctionAttr (Just ty) parms varDcls stmts) : flattenProgram prog
        EOF -> []

-- | Step into a function, by making the current symbol table the parent, and
-- starting a new clean symbol table.
stepIntoFunction :: SymbolTable -> SymbolTable
stepIntoFunction parentSymTable =
  SymbolTable { symbolTableParent = Just parentSymTable
              , symbolTableData = Map.empty
              }

-- | Step out of a function, by making the current symbol table's parent
-- the new symbol table, and the new symbol table's parent, the current parent.
exitFunction :: SymbolTable -> SymbolTable
exitFunction symTable = 
  case symbolTableParent symTable of
    Nothing -> symTable
    Just newSymTable -> newSymTable

-- | Look up an identifier in the SymbolTable.
lookupIdent :: String -> Map Identifier SymbolTableData -> Maybe SymbolTableData
lookupIdent f symMap = 
  case Map.lookup (Identifier IsNotPtr f) symMap of 
    Just m -> Just m
    Nothing -> 
      case Map.lookup (Identifier IsRefPtr f) symMap of
        Just m -> Just m
        Nothing -> 
          case Map.lookup (Identifier IsDerefPtr f) symMap of
            Just m -> Just m
            Nothing -> Nothing 

-- | Look up an identifier in the SymbolTable.
lookupIdentPtr :: String -> IsPtr -> Map Identifier SymbolTableData -> Maybe SymbolTableData
lookupIdentPtr f isPtr = Map.lookup (Identifier isPtr f)

-- | Insert an attribute into the symbol table data map.
insertAttr :: Identifier -> SymbolTableData -> Map Identifier SymbolTableData -> Map Identifier SymbolTableData
insertAttr ident attrData = Map.insertWith mergeAttr ident attrData

-- | Merge two symbol table attributes.
mergeAttr :: SymbolTableData -> SymbolTableData -> SymbolTableData
mergeAttr (IdentifierAttr _ _ newHist) (IdentifierAttr originalTy originalIndex originalHist) = 
  IdentifierAttr originalTy originalIndex (originalHist ++ newHist)
mergeAttr _ _ = undefined

-- | Extract a value from a trace history.
extractValue :: SymbolTableData -> Maybe TraceValue
extractValue (IdentifierAttr _ _ traceHistory) = 
  case traceHistory of
    [] -> Nothing
    hist -> Just $ traceValue $ head hist
extractValue _ = Nothing

-- | Extract a value from a trace history.
extractHistory :: SymbolTableData -> Maybe [TraceHistory]
extractHistory (IdentifierAttr _ _ traceHistory) = Just traceHistory
extractHistory _ = Nothing

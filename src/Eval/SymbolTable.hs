module Eval.SymbolTable where

import qualified Data.List.NonEmpty as NonE
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import GHC.Float (float2Double, double2Float)

import Parser.Common
import Parser.Literal
import Parser.Syntax


-- | The lookup identifier of a return value in a symbol table data. The `0` in front
-- makes sure we don't hit any other identifiers, since this is illegal syntax for
-- an identifier (i.e. a parse error).
returnValueIdString :: String
returnValueIdString = "0RETURN"
returnValueId :: Identifier
returnValueId = Identifier IsNotPtr returnValueIdString

-- | The symbol table consist of an optional parent symbol table, and a Map containing
-- the symbol names as key and the data as values.
data SymbolTable = SymbolTable
  { symbolTableParent :: Maybe SymbolTable
  , symbolTableAttrMap :: SymbolAttrMap
  } deriving (Show)

type SymbolAttrMap = Map Identifier SymbolAttr

-- | The attributes a symbol can have.
data SymbolAttr
  = PrototypeAttr Visibility
                  (Maybe Type)
                  Parameter
  | PrototypVarAttr Visibility
                    (Maybe Type)
                    ArrayIndex
  | FunctionAttr (Maybe Type)
                 Parameter
                 FunVarDcl
                 (Many Stmt)
  | IdentifierAttr (Maybe Type)
                   ArrayIndex
                   [TraceHistory]
  | ReturnValueAttr LiteralValue
  deriving (Show)

data TraceHistory = TraceHistory
  { executionLine :: Int
  , traceValue :: TraceValue
  } deriving (Show)

data TraceValue
  = TraceValue LiteralValue
  | TraceNotAssigned

data LiteralValue
  = IntVal Int
  | FloatVal Float
  | DoubleVal Double
  | LongVal Double
  | CharVal Char
  | StringVal String
  | ArrayVal [LiteralValue]

type ExecLineNoIncrease = Int
type ExecLineNo = Int
type Steps = Int
type ExtendedSymbolAttrMap = SymbolAttrMap
type UpdatedSymbolAttrMap = SymbolAttrMap

instance Show LiteralValue where
  show (IntVal n) = show n
  show (FloatVal n) = show n
  show (DoubleVal n) = show n
  show (LongVal n) = show n
  show (CharVal n) = show n
  show (StringVal n) = show n
  show (ArrayVal n) = show n

instance Eq LiteralValue where
  (IntVal i1) == (IntVal i2) = i1 == i2
  (FloatVal i1) == (FloatVal i2) = i1 == i2
  (DoubleVal i1) == (DoubleVal i2) = i1 == i2
  (LongVal i1) == (LongVal i2) = i1 == i2
  (FloatVal i1) == (IntVal i2) = i1 == fromIntegral i2
  (IntVal i1) == (FloatVal i2) = fromIntegral i1 == i2
  (DoubleVal i1) == (IntVal i2) = i1 == (float2Double $ fromIntegral i2)
  (IntVal i1) == (DoubleVal i2) = (float2Double $ fromIntegral i1) == i2
  (DoubleVal i1) == (FloatVal i2) = i1 == float2Double i2
  (FloatVal i1) == (DoubleVal i2) = float2Double i1 == i2
  (LongVal i1) == (IntVal i2) = i1 == (float2Double $ fromIntegral i2)
  (IntVal i1) == (LongVal i2) = (float2Double $ fromIntegral i1) == i2
  (LongVal i1) == (FloatVal i2) = i1 == float2Double i2
  (LongVal i1) == (DoubleVal i2) = i1 == i2
  (DoubleVal i1) == (LongVal i2) = i1 == i2
  (FloatVal i1) == (LongVal i2) = float2Double i1 == i2
  (StringVal s1) == (StringVal s2) = s1 == s2
  (CharVal c1) == (CharVal c2) = c1 == c2
  (ArrayVal l1) == (ArrayVal l2) = l1 == l2
  _ == _ = False

instance Ord LiteralValue where
  (IntVal i1) `compare` (IntVal i2) = i1 `compare` i2
  (FloatVal i1) `compare` (FloatVal i2) = i1 `compare` i2
  (DoubleVal i1) `compare` (DoubleVal i2) = i1 `compare` i2
  (LongVal i1) `compare` (LongVal i2) = i1 `compare` i2
  (FloatVal i1) `compare` (IntVal i2) = i1 `compare` fromIntegral i2
  (IntVal i1) `compare` (FloatVal i2) = fromIntegral i1 `compare` i2
  (DoubleVal i1) `compare` (IntVal i2) = i1 `compare` (float2Double $ fromIntegral i2)
  (IntVal i1) `compare` (DoubleVal i2) = (float2Double $ fromIntegral i1) `compare` i2
  (DoubleVal i1) `compare` (FloatVal i2) = i1 `compare` float2Double i2
  (FloatVal i1) `compare` (DoubleVal i2) = float2Double i1 `compare` i2
  (LongVal i1) `compare` (IntVal i2) = i1 `compare` (float2Double $ fromIntegral i2)
  (IntVal i1) `compare` (LongVal i2) = (float2Double $ fromIntegral i1) `compare` i2
  (LongVal i1) `compare` (FloatVal i2) = i1 `compare` float2Double i2
  (LongVal i1) `compare` (DoubleVal i2) = i1 `compare` i2
  (DoubleVal i1) `compare` (LongVal i2) = i1 `compare` i2
  (FloatVal i1) `compare` (LongVal i2) = float2Double i1 `compare` i2
  (StringVal s1) `compare` (StringVal s2) = s1 `compare` s2
  (CharVal c1) `compare` (CharVal c2) = c1 `compare` c2
  (ArrayVal l1) `compare` (ArrayVal l2) = l1 `compare` l2
  _ `compare` _ = False `compare` True

instance Show TraceValue where
  show TraceNotAssigned = "N/A"
  show (TraceValue expr) = show expr

-- | Extract the type of a literal.
typeOfLiteral :: LiteralValue -> Maybe Type
typeOfLiteral (IntVal _) = Just TypeInt
typeOfLiteral (FloatVal _) = Just TypeFloat
typeOfLiteral (DoubleVal _) = Just TypeDouble
typeOfLiteral (LongVal _) = Just TypeLong
typeOfLiteral (CharVal _) = Just TypeChar
typeOfLiteral (StringVal _) = Just TypeString
typeOfLiteral (ArrayVal []) = Just TypeVoid
typeOfLiteral (ArrayVal (lit:_)) =
  case typeOfLiteral lit of
    Nothing -> Just TypeVoid
    Just litTy -> Just $ TypeArray litTy

-- | Type cast a literal value.
typeCastLiteral :: Type -> LiteralValue -> Maybe LiteralValue
-- Cast IntVal.
typeCastLiteral TypeInt (IntVal i) = Just $ IntVal i
typeCastLiteral TypeFloat (IntVal i) = Just $ FloatVal $ fromIntegral i
typeCastLiteral TypeDouble (IntVal i) = Just $ DoubleVal $ fromIntegral i
typeCastLiteral TypeLong (IntVal i) = Just $ LongVal $ fromIntegral i
-- Cast FloatVal.
typeCastLiteral TypeInt (FloatVal i) = Just $ IntVal $ round i
typeCastLiteral TypeFloat (FloatVal i) = Just $ FloatVal i
typeCastLiteral TypeDouble (FloatVal i) = Just $ DoubleVal $ float2Double i
typeCastLiteral TypeLong (FloatVal i) = Just $ LongVal $ float2Double i
-- Cast DoubleVal.
typeCastLiteral TypeInt (DoubleVal i) = Just $ IntVal $ round i
typeCastLiteral TypeFloat (DoubleVal i) = Just $ FloatVal $ double2Float i
typeCastLiteral TypeDouble (DoubleVal i) = Just $ DoubleVal i
typeCastLiteral TypeLong (DoubleVal i) = Just $ LongVal i
-- Cast LongVal.
typeCastLiteral TypeInt (LongVal i) = Just $ IntVal $ round i
typeCastLiteral TypeFloat (LongVal i) = Just $ FloatVal $ double2Float i
typeCastLiteral TypeDouble (LongVal i) = Just $ DoubleVal i
typeCastLiteral TypeLong (LongVal i) = Just $ LongVal i
-- Cast ArrayVal.
typeCastLiteral _ _ = Nothing

-- | Create the starting global symbol table from the main program, by flattening
-- the `Prog` AST, exposing the global functions/variables as keys in the map.
symbolTable :: Prog -> SymbolTable
symbolTable program = do
  let p = flattenProgram program
  SymbolTable {symbolTableParent = Nothing, symbolTableAttrMap = (Map.fromList p)}
  where
    flattenProgram :: Prog -> [(Identifier, SymbolAttr)]
    flattenProgram p =
      case p of
        Decl (Dcl dclTy ty dcls) prog ->
          map
            (\(DclParmDcl ident parms) ->
               (ident, PrototypeAttr dclTy (Just ty) parms))
            (NonE.toList dcls) ++
          flattenProgram prog
        Decl (DclVar dclTy ty varDcls) prog ->
          map
            (\(Var ident index) ->
               (ident, PrototypVarAttr dclTy (Just ty) index))
            (NonE.toList varDcls) ++
          flattenProgram prog
        Func (Fun ty ident parms varDcls stmts) prog ->
          (ident, FunctionAttr (Just ty) parms varDcls stmts) :
          flattenProgram prog
        EOF -> []

-- | Step into a scope (e.g. function), by making the current symbol table the
-- parent, and starting a new clean symbol table.
stepIntoScope :: SymbolTable -> SymbolTable
stepIntoScope parentSymTable =
  SymbolTable
  {symbolTableParent = Just parentSymTable, symbolTableAttrMap = Map.empty}

-- | Step into a scope (e.g. function), with a initial symbol table data, by making the
-- current symbol table the parent.
stepIntoScopeWithMap :: SymbolTable -> SymbolAttrMap -> SymbolTable
stepIntoScopeWithMap parentSymTable symDataMap =
  SymbolTable
  {symbolTableParent = Just parentSymTable, symbolTableAttrMap = symDataMap}

-- | Step out of a function, by making the current symbol table's parent
-- the new symbol table, and the new symbol table's parent, the current parent.
exitFunction :: SymbolTable -> SymbolTable
exitFunction symTable =
  case symbolTableParent symTable of
    Nothing -> symTable
    Just newSymTable -> newSymTable

stepIntoGlobalScope :: SymbolTable -> SymbolTable
stepIntoGlobalScope symTable =
  case symbolTableParent symTable of
    Nothing -> symTable
    Just newSymTable -> stepIntoGlobalScope newSymTable

-- | Insert an attribute into the symbol table data map.
insertAttr ::
     Identifier
  -> SymbolAttr
  -> SymbolAttrMap
  -> SymbolAttrMap
insertAttr ident attrData = Map.insertWith mergeAttr ident attrData

-- | Merge two symbol table attributes by keeping the array index information,
-- and prepending the new trace history onto the original trace history.
mergeAttr :: SymbolAttr -> SymbolAttr -> SymbolAttr
mergeAttr (IdentifierAttr originalTy originalIndex originalHist) (IdentifierAttr _ newIndex newHist) =
  let arrayIndex = case originalIndex of
        NotArray ->
          case newIndex of
            NotArray -> NotArray
            i -> i
        i -> i
  in IdentifierAttr originalTy arrayIndex (newHist ++ originalHist)
mergeAttr _ _ = undefined

recUpdateIdent :: Identifier -> ExecLineNo -> LiteralValue -> SymbolTable -> SymbolTable
recUpdateIdent ident@(Identifier _ name) exLine val symTable = do
  -- If the identifier is not found in the current scope, check
  -- its parent scope by recursively going up.
  let attrMap = symbolTableAttrMap symTable
  case lookupIdent name attrMap of
    Nothing ->
      case symbolTableParent symTable of
        Nothing -> symTable
        Just sParentTable ->
          symTable{symbolTableParent = Just (recUpdateIdent ident exLine val sParentTable)}
    Just (IdentifierAttr mTy isArray _) ->
      let traceHistory v = TraceHistory {executionLine = exLine, traceValue = TraceValue v}
          castedVal = case mTy of
            Nothing -> val
            Just ty ->
              case typeCastLiteral ty val of
                Just v -> v
                Nothing -> val
          extendedAttrMap = Map.fromList [(ident, IdentifierAttr mTy isArray [traceHistory castedVal])]
      in symTable{symbolTableAttrMap = Map.unionWith mergeAttr attrMap extendedAttrMap}
    Just _ -> error $ "Error: Cannot update value of non-identifier!"

recUpdateIdentWith :: Identifier -> (TraceValue -> SymbolAttr) -> SymbolTable -> SymbolTable
recUpdateIdentWith ident@(Identifier _ name) attrUpdater symTable = do
  -- If the identifier is not found in the current scope, check
  -- its parent scope by recursively going up.
  let attrMap = symbolTableAttrMap symTable
  case lookupIdent name attrMap of
    Nothing ->
      case symbolTableParent symTable of
        Nothing -> symTable
        Just sParentTable ->
          symTable{symbolTableParent = Just (recUpdateIdentWith ident attrUpdater sParentTable)}
    Just sAttr ->
      let newSAttr = case extractValue sAttr of
            Nothing -> sAttr
            Just tValue -> attrUpdater tValue
          extendedAttrMap = Map.fromList [(ident, newSAttr)]
      in symTable{symbolTableAttrMap = Map.unionWith mergeAttr attrMap extendedAttrMap}

recLookupIdent :: String -> SymbolTable -> Maybe SymbolAttr
recLookupIdent name symTable = do
  -- If the identifier is not found in the current scope, check
  -- its parent scope by recursively going up.
  let attrMap = symbolTableAttrMap symTable
  case lookupIdent name attrMap of
    Nothing ->
      case symbolTableParent symTable of
        Nothing -> Nothing
        Just sParentTable -> recLookupIdent name sParentTable
    Just sAttrMap -> Just sAttrMap

-- | Look up an identifier in the SymbolTable.
lookupIdent :: String -> SymbolAttrMap -> Maybe SymbolAttr
lookupIdent name symMap =
  case Map.lookup (Identifier IsNotPtr name) symMap of
    Just m -> Just m
    Nothing ->
      case Map.lookup (Identifier IsRefPtr name) symMap of
        Just m -> Just m
        Nothing ->
          case Map.lookup (Identifier IsDerefPtr name) symMap of
            Just m -> Just m
            Nothing -> Nothing

-- | Look up an identifier in the SymbolTable.
lookupIdentPtr :: String -> IsPtr -> SymbolAttrMap -> Maybe SymbolAttr
lookupIdentPtr name isPtr = Map.lookup (Identifier isPtr name)

-- | Get the return value from the symbol table data.
returnValue :: SymbolAttrMap -> Maybe LiteralValue
returnValue symMap =
  case lookupIdent returnValueIdString symMap of
    Nothing -> Nothing
    Just (ReturnValueAttr val) -> Just val
    Just _ -> error "Invalid return value!"

-- | Extract a value from a trace history.
extractValue :: SymbolAttr -> Maybe TraceValue
extractValue (IdentifierAttr _ _ traceHistory) =
  case traceHistory of
    [] -> Nothing
    hist -> Just $ traceValue $ head hist
extractValue _ = Nothing

-- | Extract a value from a trace history.
extractHistory :: SymbolAttr -> Maybe [TraceHistory]
extractHistory (IdentifierAttr _ _ traceHistory) = Just traceHistory
extractHistory _ = Nothing

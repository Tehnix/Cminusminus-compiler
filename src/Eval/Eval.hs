{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE StandaloneDeriving      #-}
module Eval.Eval where

import qualified Data.List.NonEmpty as NonE
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Text.Pretty.Simple (pPrint)
import Text.Read (readMaybe)
import Control.Monad (zipWithM)
import System.Console.Haskeline
import Control.Monad.IO.Class

import Eval.SymbolTable
import Eval.Operators
import Parser.Syntax
import Parser.Common
import Parser.Literal


debug :: (MonadIO m, Show a) => a -> m ()
-- debug s = pPrint s
debug s = return ()

class (Show a) => Eval a where
  eval :: ExecLineNo -> Steps -> SymbolTable -> a -> IO (ExecLineNoIncrease, Steps, SymbolTable)

-- | We use an existential quantification to allow `ExecutionLine` to be
-- a heterogenerous list, which can have any value, `a`, which is `Evaluable`.
data Evaluable = forall a . (Show a, Eval a) => MkEvaluable a
-- Because we are dealing with existential quantification, we can't derive
-- `Show` directly, but we can make a standalone derived instance of it.
deriving instance Show Evaluable

-- | A builder function for our evaluables.
mkEvaluable :: (Eval a) => a -> Evaluable
mkEvaluable = MkEvaluable

executionLines :: SymbolAttr -> [Evaluable]
executionLines (FunctionAttr _ parms (FunVarDcl varDcls) stmts) = do
  let parms' = [mkEvaluable parms]
      varDcls' = map mkEvaluable (manyToList varDcls)
      stmts' = map mkEvaluable (manyToList stmts)
  parms' ++ varDcls' ++ stmts'
executionLines _ = error "Error: You can only execute functions!"

instance Eval Parameter where
  eval _ stepsToTake symTable EmptyParam = pure (0, stepsToTake-1, symTable)
  eval execLine stepsToTake (SymbolTable parent symData) (Param parms) =
    pure $ (0, stepsToTake-1, SymbolTable { symbolTableParent = parent
                       , symbolTableAttrMap = Map.unionWith mergeAttr symData parmsAttr
                       })
    where
      -- After converting the parameters to proper symbol attributes, we filter out the
      -- ones that already exist in the symbol table, since these would be parameters
      -- to the function.
      parmsAttr :: ExtendedSymbolAttrMap
      parmsAttr = Map.filterWithKey (\k _ -> Map.notMember k symData) $ Map.map (\ty -> IdentifierAttr (Just ty) NotArray [TraceHistory execLine TraceNotAssigned]) parms

instance Eval FunVarTypeDcl where
  eval execLine stepsToTake (SymbolTable parent symData) (FunVarTypeDcl ty varDcls) =
    pure $ (0, stepsToTake-1, SymbolTable { symbolTableParent = parent
                       , symbolTableAttrMap = Map.unionWith mergeAttr symData varAttr
                       })
    where
      varAttr :: ExtendedSymbolAttrMap
      varAttr = Map.fromList $ map (\(Var ident isArray) -> (ident, IdentifierAttr (Just ty) isArray [TraceHistory execLine TraceNotAssigned])) (NonE.toList varDcls)

instance Eval Stmt where
  eval execLine stepsToTake symTable@(SymbolTable parent symData) stmt = do
    (exLineNoIncrease, stepsLeft, stmtMap) <- stmtAttr
    -- If the map has been updated, we overwrite it, otherwise we take the
    -- union (extend it) of the original and new map.
    pure $
      case stmtMap of
        Left updatedTable -> (exLineNoIncrease, stepsLeft, updatedTable)
        Right extendedMap -> (exLineNoIncrease, stepsLeft, SymbolTable { symbolTableParent = parent
                                , symbolTableAttrMap = Map.unionWith mergeAttr symData extendedMap
                                })
    where
      exprVal expr = evalExpr execLine stepsToTake symTable expr

      traceHistory :: LiteralValue -> TraceHistory
      traceHistory val = TraceHistory {executionLine = execLine, traceValue = TraceValue val}

      updateValAtIndex :: String -> LiteralValue -> Int -> IO [LiteralValue]
      updateValAtIndex ident val index =
        case recLookupIdent ident symTable of
          Nothing -> error $ "Error trying to assign value to " ++ ident ++ "[" ++ show index ++ "]: Identifier not found!"
          Just symAttr@(IdentifierAttr mTy (Index arraySize) _) ->
            case extractValue symAttr of
              Nothing -> error $ "Error trying to assign value to " ++ ident ++ "[" ++ show index ++ "]: Variable not declared yet!"
              Just v -> do
                arraySize' <- exprVal arraySize
                pure $ case arraySize' of
                  IntVal indexSize -> do
                    let array = case v of
                          TraceNotAssigned -> replicate indexSize (IntVal 0)
                          TraceValue (ArrayVal lits) -> lits
                          -- TODO: Implement for char/string.
                          TraceValue _ -> error $ "Error trying to assign value to " ++ ident ++ "[" ++ show index ++ "]: Trying to assign to index on non-array type."
                    if index < indexSize && index >= 0
                        then take index array ++ [val] ++ drop (index + 1) array
                        else error $ "Error trying to assign value to " ++ ident ++ "[" ++ show index ++ "]: Index is out of bounds!"
                  _ -> error "Error: Array size is not an integer!"
          Just _ -> error $ "Error trying to assign value to " ++ ident ++ "[" ++ show index ++ "]: Not an array identifier!"

      enterStatement :: ExecLineNo -> Steps -> SymbolTable -> [Stmt] -> IO (ExecLineNoIncrease, Steps, Either SymbolTable ExtendedSymbolAttrMap)
      enterStatement eLineNo sToTake sTable ss = do
        -- We throw away the value from the scoped repl, because if it is relevant
        -- it will exist in the symbol table.
        (newExLineNo, stepsLeft, _, scopeSymbolTable) <- scopedRepl (stepIntoScope sTable) sToTake eLineNo (map mkEvaluable ss)
        let exLineNoInc = newExLineNo - execLine
        -- newSymTable <- eval execLine (SymbolTable parent symData) s
        case symbolTableParent scopeSymbolTable of
          Nothing -> pure $ (exLineNoInc, stepsLeft, Right Map.empty)
          Just parentSymbolTable -> pure $ (exLineNoInc, stepsLeft, Left parentSymbolTable)

      attrUpdater :: (LiteralValue -> LiteralValue) -> TraceValue -> SymbolAttr
      attrUpdater f tValue =
        case tValue of
          TraceNotAssigned -> IdentifierAttr Nothing NotArray [traceHistory (IntVal 0)]
          TraceValue val -> IdentifierAttr Nothing NotArray [traceHistory (f val)]

      stmtAttr :: IO (ExecLineNoIncrease, Steps, Either SymbolTable ExtendedSymbolAttrMap)
      stmtAttr =
        case stmt of
          EmptyStmt -> pure (0, stepsToTake-1, Right Map.empty)
          Return Nothing -> pure (0, stepsToTake-1, Right Map.empty)
          Return (Just expr) -> do
            val <- exprVal expr
            pure $ (0, stepsToTake-1, Right $ Map.fromList [(returnValueId, ReturnValueAttr val)])
          -- TODO: Test stmt assignment on arrays.
          StmtAssgn (AssignId mTy ident@(Identifier _ name) isArray expr) -> do
            v <- exprVal expr
            val <- case isArray of
              NotArray -> pure v
              Index i -> do
                index <- exprVal i
                case index of
                  IntVal index' -> do
                    updateArray <- updateValAtIndex name v index'
                    pure $ ArrayVal updateArray
                  _ -> error "Error: Trying to access index with non-integer!"
            debug $ "Assigning " ++ name ++ " = " ++ show val ++ ";"
            pure $ (0, stepsToTake-1, Left $ recUpdateIdent ident execLine val symTable)
          -- FIXME: Handle statements like `int a = x++;` i.e. assignment with assignment in expr.
          StmtAssgn (PrefixInc ident) -> do
            pure $ (0, stepsToTake-1, Left $ recUpdateIdentWith ident (attrUpdater incrementE) symTable)
          StmtAssgn (PostfixInc ident) -> do
            pure $ (0, stepsToTake-1, Left $ recUpdateIdentWith ident (attrUpdater incrementE) symTable)
          StmtAssgn (PrefixDec ident) -> do
            pure $ (0, stepsToTake-1, Left $ recUpdateIdentWith ident (attrUpdater decrementE) symTable)
          StmtAssgn (PostfixDec ident) -> do
            pure $ (0, stepsToTake-1, Left $ recUpdateIdentWith ident (attrUpdater decrementE) symTable)
          If expr s -> do
            debug "Inside if"
            val <- exprVal expr
            if val /= IntVal 0
              then do
                -- Before going in, we increment execLine by 1 to factor in the `if ...` line.
                (exLinNoInc, stepsLeft, eSym) <- enterStatement (execLine+1) stepsToTake symTable [s]
                -- And once more after because of the ending `}`.
                pure $ (exLinNoInc+1, stepsLeft, eSym)
              else pure (0, stepsToTake-1, Right Map.empty)
          IfElse expr s1 s2 -> do
            debug "Inside if-else"
            val <- exprVal expr
            let s = if val /= IntVal 0 then s1 else s2
            -- Before going in, we increment execLine by 1 to factor in the `if/else ...` line.
            (exLinNoInc, stepsLeft, eSym) <- enterStatement (execLine+1) stepsToTake symTable [s]
            -- And once more after because of the ending `}`.
            pure $ (exLinNoInc+1, stepsLeft, eSym)
          StmtBlock Empty -> pure (0, stepsToTake, Right Map.empty)
          StmtBlock (Many ss) -> enterStatement execLine stepsToTake symTable (NonE.toList ss)
          StmtId (Identifier _ funName) parmExprs -> do
            debug $ "Stepping into function: " ++ funName
            let globalSymbolTable = stepIntoGlobalScope symTable
            case lookupIdent funName (symbolTableAttrMap globalSymbolTable) of
              Nothing -> error $ "Error while trying to call function '" ++ funName ++ ": Function does not exist!"
              Just funAttr@(FunctionAttr mTy parms _ _) -> do
                initialSymData <-
                  case parms of
                    EmptyParam -> pure Map.empty
                    (Param parmMap) ->
                      let givenArgs = length $ manyToList parmExprs
                          expectedArgs = Map.size parmMap
                      in if givenArgs /= expectedArgs
                          then error $ "Error while trying to call function '" ++ funName ++ "': Incorrect number of arguments, expected " ++ show expectedArgs ++ " but was given " ++ show givenArgs
                          else do
                            -- TODO: Type check the parameters.
                            let mergParams parmExpr (ident, ty) = do
                                  val <- exprVal parmExpr
                                  pure $ (ident, IdentifierAttr (Just ty) NotArray [traceHistory val])
                            parmVals <- zipWithM mergParams (manyToList parmExprs) (Map.toList parmMap)
                            pure $ Map.fromList parmVals
                let funSymbolTable = stepIntoScopeWithMap globalSymbolTable initialSymData
                    ex = executionLines funAttr
                (newExLineNo, stepsLeft, _, _) <- scopedRepl funSymbolTable stepsToTake 0 ex
                pure $ (newExLineNo, stepsLeft, Right Map.empty)
              Just _ -> error $ "Error while trying to call function '" ++ funName ++ ": Identifier is not a function!"
          StmtPrintf Empty -> pure $ (0, stepsToTake-1, Right Map.empty)
          StmtPrintf (Many parmExprs) -> do
            -- TODO: Type check the parameters.
            parms <- mapM (evalExpr execLine stepsToTake symTable) parmExprs
            case NonE.toList parms of
              [] -> error $ "Error while trying to call function 'printf': Incorrect number of arguments, expected at least 1 but was given 0"
              (format:ps) -> do
                sPrintfList format ps
            pure (0, stepsToTake-1, Right Map.empty)
          While expr s -> do
            debug "Inside while"
            loop 1 stepsToTake symTable
            where
              loop :: ExecLineNoIncrease -> Steps -> SymbolTable -> IO (ExecLineNoIncrease, Steps, Either SymbolTable ExtendedSymbolAttrMap)
              loop exLinNoInc sToTake sTable = do
                val <- evalExpr execLine stepsToTake sTable expr
                if val /= IntVal 0
                  then do
                    (exLinNoInc, stepsLeft, eSym) <- enterStatement (execLine+1) sToTake sTable [s]
                    case eSym of
                      Left upSym -> loop exLinNoInc stepsLeft upSym
                      Right exSym -> loop exLinNoInc stepsLeft $ SymbolTable parent (Map.unionWith mergeAttr symData exSym)
                  else pure (exLinNoInc+1, sToTake, Left sTable)
          For mAssgnInital Nothing mAssign s -> pure (0, stepsToTake-1, Right Map.empty)
          For mAssgnInital (Just expr) mAssign s -> do
            debug "Inside for"
            case mAssgnInital of
              Nothing -> loop 1 stepsToTake symTable
              Just initAssgn -> do
                (_, _, eSym) <- enterStatement (execLine) stepsToTake symTable [StmtAssgn initAssgn]
                case eSym of
                  Left upSym -> loop 1 stepsToTake upSym
                  Right exSym -> loop 1 stepsToTake $ SymbolTable parent (Map.unionWith mergeAttr symData exSym)
            where
              loop :: ExecLineNoIncrease -> Steps -> SymbolTable -> IO (ExecLineNoIncrease, Steps, Either SymbolTable ExtendedSymbolAttrMap)
              loop exLinNoInc sToTake sTable = do
                val <- evalExpr execLine stepsToTake sTable expr
                if val /= IntVal 0
                  then do
                    (exLinNoInc, stepsLeft, eSym) <- enterStatement (execLine+1) sToTake sTable [s]
                    let exprSymTable = case eSym of
                          Left upSym -> upSym
                          Right exSym -> SymbolTable parent (Map.unionWith mergeAttr symData exSym)
                    case mAssign of
                      Nothing -> loop exLinNoInc stepsLeft exprSymTable
                      Just postAssign -> do
                        (_, _, pAssgnSym) <- enterStatement (execLine) (stepsLeft+1) exprSymTable [StmtAssgn postAssign]
                        case pAssgnSym of
                          Left upSym -> loop exLinNoInc stepsLeft upSym
                          Right exSym -> loop exLinNoInc stepsLeft $ SymbolTable { symbolTableParent = parent
                                    , symbolTableAttrMap = Map.unionWith mergeAttr symData exSym
                                    }
                  else pure (exLinNoInc+1, sToTake, Left sTable)

-- | Evaluate expressions down to an updated symbol table, along with a literal.
evalExpr :: ExecLineNo -> Steps -> SymbolTable -> Expr -> IO LiteralValue
evalExpr execLine stepsToTake symTable expr =
  case expr of
    Negate e -> do
      val <- evalE e
      pure $ negateE val
    NegateBool e -> do
      val <- evalE e
      pure $ if val == IntVal 0 then IntVal 1 else IntVal 0
    BinOp binOp e1 e2 -> do
      val1 <- evalE e1
      val2 <- evalE e2
      pure $ case binOp of
        Plus -> val1 `plusE` val2
        Minus -> val1 `minusE` val2
        Mul -> val1 `mulE` val2
        Div -> val1 `divE` val2
    -- We represent our truthyness as `IntVal 1` and false as `IntVal 0`.
    RelOp relOp e1 e2 -> do
      val1 <- evalE e1
      val2 <- evalE e2
      pure $ case relOp of
        Equal -> if val1 == val2 then IntVal 1 else IntVal 0
        NotEqual -> if val1 /= val2 then IntVal 1 else IntVal 0
        LessThanEqual -> if val1 <= val2 then IntVal 1 else IntVal 0
        LessThan -> if val1 < val2 then IntVal 1 else IntVal 0
        GreaterThanEqual -> if val1 >= val2 then IntVal 1 else IntVal 0
        GreaterThan -> if val1 > val2 then IntVal 1 else IntVal 0
    -- We mimic the fact that `&&` and `||` return 1 on true and 0 on false in C.
    LogOp logOp e1 e2 -> do
      val1 <- evalE e1
      val2 <- evalE e2
      pure $ case logOp of
        And -> if (val1 /= IntVal 0) && (val2 /= IntVal 0) then IntVal 1 else IntVal 0
        Or -> if (val1 /= IntVal 0) || (val2 /= IntVal 0) then IntVal 1 else IntVal 0
    -- A function call in an expression *has* to return a value. Something like `print("Hello");`
    -- would be a `StmtId`, while this would look e.g. like `int val = avg(10);`.
    -- The process of the function call goes something like:
    --   1) Look up the function in the global symbol table
    --   2) Check its parameter names and types
    --   3) Evaluate each expression, at the param position
    --   4) Create a new symbol table containing each param identifier assigned with the
    --      values of the evaluated expressions.
    IdFun (Identifier _ funName) parmExprs -> do
      debug $ "Stepping into function: " ++ funName
      let globalSymbolTable = stepIntoGlobalScope symTable
      case lookupIdent funName (symbolTableAttrMap globalSymbolTable) of
        Nothing -> error $ "Error while trying to call function '" ++ funName ++ ": Function does not exist!"
        Just funAttr@(FunctionAttr mTy parms _ _) -> do
          initialSymData <-
            case parms of
              EmptyParam -> pure Map.empty
              (Param parmMap) ->
                let givenArgs = length $ manyToList parmExprs
                    expectedArgs = Map.size parmMap
                in if givenArgs /= expectedArgs
                    then error $ "Error while trying to call function '" ++ funName ++ ": Incorrect number of arguments, expected " ++ show expectedArgs ++ " but was given " ++ show givenArgs
                    else do
                      -- TODO: Type check the parameters.
                      let traceHistory val = TraceHistory {executionLine = 0, traceValue = TraceValue val}
                          mergParams parmExpr (ident, ty) = do
                            val <- evalE parmExpr
                            pure $ (ident, IdentifierAttr (Just ty) NotArray [traceHistory val])
                      parmVals <- zipWithM mergParams (manyToList parmExprs) (Map.toList parmMap)
                      pure $ Map.fromList parmVals
          let funSymbolTable = stepIntoScopeWithMap globalSymbolTable initialSymData
              ex = executionLines funAttr
          -- We can throw away both the new symbol table and the exec line no, since we are resetting
          -- to the previous function anyways.
          (_, stepsLef, mVal, _) <- scopedRepl funSymbolTable stepsToTake 0 ex
          case mVal of
            Nothing -> error $ "Error while trying to call function '" ++ funName ++ ": Function has to return something!"
            Just val -> do
              -- putStrLn $ "Type of return value was: " ++ show val ++ " (" ++ show (typeOfLiteral val) ++ "), and function return type was: " ++ show mTy
              let val' = case mTy of
                    Nothing -> val
                    Just ty ->
                      case typeCastLiteral ty val of
                        Just v -> v
                        Nothing -> val
              pure val'
        Just _ -> error $ "Error while trying to call function '" ++ funName ++ ": Identifier is not a function!"
    Id NotArray (Identifier _ name) ->
      case recLookupIdent name symTable of
        Nothing -> error $ "Trying to access undefined variable '" ++ name ++ "'"
        Just symData' ->
          pure $ case extractValue symData' of
            Nothing -> error $ "Trying to access undefined variable '" ++ name ++ "'"
            Just TraceNotAssigned -> error $ "Error while using " ++ name ++ " in an expression: " ++ name ++ " has not been assigned a value yet!"
            Just (TraceValue val) -> val
    Id (Index indexExpr) (Identifier _ name) ->
      case recLookupIdent name symTable of
        Nothing -> error $ "Trying to access undefined variable '" ++ name ++ "'"
        Just symData' ->
          case extractValue symData' of
            -- We can only use the array[] syntax on identifiers.
            Nothing -> error $ "Error while trying to access " ++ name ++ ": You can only access indexes on identifiers!"
            -- If there is no value assigned yet, we default to 0.
            Just TraceNotAssigned -> pure $ IntVal 0
            Just (TraceValue (ArrayVal vals)) -> do
              val <- evalE indexExpr
              case val of
                IntVal i -> if length vals < i then error ("Error while trying to access " ++ name ++ ": Index is out of bounds!") else pure (vals !! i)
                _ -> error $ "Error while trying to access " ++ name ++ ": Indexes must be integers!"
            Just (TraceValue _) -> error $ "Error while trying to access " ++ name ++ ": You can only access indexes on arrays!"
    Brack e -> evalE e
    LitInt (IntCon i) -> pure $ IntVal i
    LitFloat (FloatCon i) -> pure $ FloatVal i
    LitDouble (DoubleCon i) -> pure $ DoubleVal i
    LitLong (LongCon i) -> pure $ LongVal i
    LitChar (CharCon i) -> pure $ CharVal i
    LitString (StringCon i) -> pure $ StringVal i
  where
    evalE = evalExpr execLine stepsToTake symTable

data Cmd
  = Next Int
  | Trace String
  | Print String
  | Invalid

getInput :: InputT IO Cmd
getInput = do
  cmd <- getInputLine ">> "
  return $ parseCmd cmd
  where
    parseCmd :: Maybe String -> Cmd
    parseCmd Nothing = Next 1
    parseCmd (Just cmd) =
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

scopedRepl :: SymbolTable -> Steps -> ExecLineNo -> [Evaluable] -> IO (ExecLineNoIncrease, Steps, Maybe LiteralValue, SymbolTable)
scopedRepl startSymTable takeSteps exLineNo exLines = do
  -- Step through each line.
  loop exLineNo takeSteps startSymTable exLines
  where
    loop :: ExecLineNo -> Steps -> SymbolTable -> [Evaluable] -> IO (ExecLineNoIncrease, Steps, Maybe LiteralValue, SymbolTable)
    loop n stepsLeft symTable@(SymbolTable _ symData) [] = do
      debug "END OF FUNCTION/SCOPE: "
      debug $ returnValue symData
      -- Return the current execution line number, so that we can calculate the increase
      -- in line numbers.
      pure $ (n-1, stepsLeft, returnValue symData, symTable)
    loop n stepsToTake symTable execLines@((MkEvaluable line):exs) =
      if stepsToTake <= 1
        then do
          -- Await user input.
          cmd <- runInputT defaultSettings getInput
          case cmd of
            Next stepsToTake -> do
              (exLineNoInc, stepsLeft, newSymTable) <- eval n stepsToTake symTable line
              debug $ (show n) ++ ": "
              debug line
              -- Continue stepping through the lines.
              loop (n + exLineNoInc + 1) stepsLeft newSymTable exs
            Trace ident -> do
              traceIdentifier ident symTable
              loop n 1 symTable execLines
            Print ident -> do
              printIdentifier ident symTable
              loop n 1 symTable execLines
            Invalid -> do
              putStrLn "Incorrect command usage: try 'next [lines]'"
              loop n 1 symTable execLines
        else do
          (exLineNoInc, stepsLeft, newSymTable) <- eval n stepsToTake symTable line
          loop (n + exLineNoInc + 1) (stepsLeft-1) newSymTable exs

printTrace :: String -> TraceHistory -> IO ()
printTrace name TraceHistory{executionLine=execLine, traceValue=val} =
  putStrLn $ "  " ++ name ++ " = " ++ show val ++ " at line " ++ show execLine

-- | Recursively look up the identifier, up the symbol table tree.
traceIdentifier :: String -> SymbolTable -> IO ()
traceIdentifier name sTable = do
  case lookupIdent name (symbolTableAttrMap sTable) of
    Nothing ->
      case symbolTableParent sTable of
        Nothing -> putStrLn "Invisible"
        Just sTable' -> traceIdentifier name sTable'
    Just lSymData ->
      case extractHistory lSymData of
        Nothing -> putStrLn "Trying to trace something that is not an identifier (e.g. function)!"
        Just history -> mapM_ (printTrace name) (reverse history)

-- | Recursively look up the identifier, up the symbol table tree.
printIdentifier :: String -> SymbolTable -> IO ()
printIdentifier name sTable = do
  case lookupIdent name (symbolTableAttrMap sTable) of
    Nothing -> case symbolTableParent sTable of
      Nothing -> putStrLn "Invisible"
      Just sTable' -> printIdentifier name sTable'
    Just lSymData ->
      case extractValue lSymData of
        Nothing -> putStrLn "Trying to print something that is not an identifier (e.g. function)!"
        Just val -> pPrint val

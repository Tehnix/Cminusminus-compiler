module Eval.Operators where

import Eval.SymbolTable
import Parser.Syntax
import GHC.Float (float2Double, double2Float)
import Text.Printf
import Data.List (intercalate)
import Data.List.Split (splitOn)

-- Unary operators.
negateE :: LiteralValue -> LiteralValue
negateE (IntVal i) = IntVal (-i)
negateE (FloatVal i) = FloatVal (-i)
negateE (DoubleVal i) = DoubleVal (-i)
negateE (LongVal i) = LongVal (-i)
negateE (StringVal _) = error "Type mismatch: You cannot negate a string"
negateE (CharVal _) = error "Type mismatch: You cannot negate a char"
negateE (ArrayVal _) = error "Type mismatch: You cannot negate an array"

incrementE :: LiteralValue -> LiteralValue
incrementE (IntVal i) = IntVal (i + 1)
incrementE (FloatVal i) = FloatVal (i + 1)
incrementE (DoubleVal i) = DoubleVal (i + 1)
incrementE (LongVal i) = LongVal (i + 1)
incrementE (StringVal _) = error "Type mismatch: You cannot increment a string"
incrementE (CharVal _) = error "Type mismatch: You cannot increment a char"
incrementE (ArrayVal _) = error "Type mismatch: You cannot increment an array"

decrementE :: LiteralValue -> LiteralValue
decrementE (IntVal i) = IntVal (i - 1)
decrementE (FloatVal i) = FloatVal (i + 1)
decrementE (DoubleVal i) = DoubleVal (i + 1)
decrementE (LongVal i) = LongVal (i + 1)
decrementE (StringVal _) = error "Type mismatch: You cannot decrement a string"
decrementE (CharVal _) = error "Type mismatch: You cannot decrement a char"
decrementE (ArrayVal _) = error "Type mismatch: You cannot decrement an array"

-- | Binary operators. We bruteforce our way through type casting.
plusE :: LiteralValue -> LiteralValue -> LiteralValue
plusE (IntVal i1) (IntVal i2) = IntVal (i1 + i2)
plusE (FloatVal i1) (FloatVal i2) = FloatVal (i1 + i2)
plusE (DoubleVal i1) (DoubleVal i2) = DoubleVal (i1 + i2)
plusE (LongVal i1) (LongVal i2) = LongVal (i1 + i2)
-- FloatVal promotions.
plusE (FloatVal i1) (IntVal i2) = FloatVal (i1 + fromIntegral i2)
plusE (IntVal i1) (FloatVal i2) = FloatVal (fromIntegral i1 + i2)
-- DoubleVal promotions.
plusE (DoubleVal i1) (IntVal i2) = DoubleVal (i1 + fromIntegral i2)
plusE (IntVal i1) (DoubleVal i2) = DoubleVal (fromIntegral i1 + i2)
plusE (DoubleVal i1) (FloatVal i2) = DoubleVal (i1 + float2Double i2)
plusE (FloatVal i1) (DoubleVal i2) = DoubleVal (float2Double i1 + i2)
-- LongVal promotions.
plusE (LongVal i1) (IntVal i2) = LongVal (i1 + fromIntegral i2)
plusE (IntVal i1) (LongVal i2) = LongVal (fromIntegral i1 + i2)
plusE (LongVal i1) (FloatVal i2) = LongVal (i1 + float2Double i2)
plusE (LongVal i1) (DoubleVal i2) = LongVal (i1 + i2)
plusE (DoubleVal i1) (LongVal i2) = LongVal (i1 + i2)
plusE (FloatVal i1) (LongVal i2) = LongVal (float2Double i1 + i2)
-- Type mismatches.
plusE (StringVal _) _ = error "Type mismatch: You cannot plus a string"
plusE _ (StringVal _) = error "Type mismatch: You cannot plus a string"
plusE (CharVal _) _ = error "Type mismatch: You cannot plus a char"
plusE _ (CharVal _) = error "Type mismatch: You cannot plus a char"
plusE (ArrayVal _) _ = error "Type mismatch: You cannot plus an array"
plusE _ (ArrayVal _) = error "Type mismatch: You cannot plus an array"

minusE :: LiteralValue -> LiteralValue -> LiteralValue
minusE (IntVal i1) (IntVal i2) = IntVal (i1 - i2)
minusE (FloatVal i1) (FloatVal i2) = FloatVal (i1 - i2)
minusE (DoubleVal i1) (DoubleVal i2) = DoubleVal (i1 - i2)
minusE (LongVal i1) (LongVal i2) = LongVal (i1 - i2)
-- FloatVal promotions.
minusE (FloatVal i1) (IntVal i2) = FloatVal (i1 - fromIntegral i2)
minusE (IntVal i1) (FloatVal i2) = FloatVal (fromIntegral i1 - i2)
-- DoubleVal promotions.
minusE (DoubleVal i1) (IntVal i2) = DoubleVal (i1 - fromIntegral i2)
minusE (IntVal i1) (DoubleVal i2) = DoubleVal (fromIntegral i1 - i2)
minusE (DoubleVal i1) (FloatVal i2) = DoubleVal (i1 - float2Double i2)
minusE (FloatVal i1) (DoubleVal i2) = DoubleVal (float2Double i1 - i2)
-- LongVal promotions.
minusE (LongVal i1) (IntVal i2) = LongVal (i1 - fromIntegral i2)
minusE (IntVal i1) (LongVal i2) = LongVal (fromIntegral i1 - i2)
minusE (LongVal i1) (FloatVal i2) = LongVal (i1 - float2Double i2)
minusE (LongVal i1) (DoubleVal i2) = LongVal (i1 - i2)
minusE (DoubleVal i1) (LongVal i2) = LongVal (i1 - i2)
minusE (FloatVal i1) (LongVal i2) = LongVal (float2Double i1 - i2)
-- Type mismatches.
minusE (StringVal _) _ = error "Type mismatch: You cannot subtract a string"
minusE _ (StringVal _) = error "Type mismatch: You cannot subtract a string"
minusE (CharVal _) _ = error "Type mismatch: You cannot subtract a char"
minusE _ (CharVal _) = error "Type mismatch: You cannot subtract a char"
minusE (ArrayVal _) _ = error "Type mismatch: You cannot subtract an array"
minusE _ (ArrayVal _) = error "Type mismatch: You cannot subtract an array"

mulE :: LiteralValue -> LiteralValue -> LiteralValue
mulE (IntVal i1) (IntVal i2) = IntVal (i1 * i2)
mulE (FloatVal i1) (FloatVal i2) = FloatVal (i1 * i2)
mulE (DoubleVal i1) (DoubleVal i2) = DoubleVal (i1 * i2)
mulE (LongVal i1) (LongVal i2) = LongVal (i1 * i2)
-- FloatVal promotions.
mulE (FloatVal i1) (IntVal i2) = FloatVal (i1 * fromIntegral i2)
mulE (IntVal i1) (FloatVal i2) = FloatVal (fromIntegral i1 * i2)
-- DoubleVal promotions.
mulE (DoubleVal i1) (IntVal i2) = DoubleVal (i1 * fromIntegral i2)
mulE (IntVal i1) (DoubleVal i2) = DoubleVal (fromIntegral i1 * i2)
mulE (DoubleVal i1) (FloatVal i2) = DoubleVal (i1 * float2Double i2)
mulE (FloatVal i1) (DoubleVal i2) = DoubleVal (float2Double i1 * i2)
-- LongVal promotions.
mulE (LongVal i1) (IntVal i2) = LongVal (i1 * fromIntegral i2)
mulE (IntVal i1) (LongVal i2) = LongVal (fromIntegral i1 * i2)
mulE (LongVal i1) (FloatVal i2) = LongVal (i1 * float2Double i2)
mulE (LongVal i1) (DoubleVal i2) = LongVal (i1 * i2)
mulE (DoubleVal i1) (LongVal i2) = LongVal (i1 * i2)
mulE (FloatVal i1) (LongVal i2) = LongVal (float2Double i1 * i2)
-- Type mismatches.
mulE (StringVal _) _ = error "Type mismatch: You cannot multiply a string"
mulE _ (StringVal _) = error "Type mismatch: You cannot multiply a string"
mulE (CharVal _) _ = error "Type mismatch: You cannot multiply a char"
mulE _ (CharVal _) = error "Type mismatch: You cannot multiply a char"
mulE (ArrayVal _) _ = error "Type mismatch: You cannot multiply an array"
mulE _ (ArrayVal _) = error "Type mismatch: You cannot multiply an array"

divE :: LiteralValue -> LiteralValue -> LiteralValue
divE (IntVal i1) (IntVal i2) = IntVal (i1 `quot` i2)
divE (FloatVal i1) (FloatVal i2) = FloatVal (i1 / i2)
divE (DoubleVal i1) (DoubleVal i2) = DoubleVal (i1 / i2)
divE (LongVal i1) (LongVal i2) = LongVal (i1 / i2)
-- FloatVal promotions.
divE (FloatVal i1) (IntVal i2) = FloatVal (i1 / fromIntegral i2)
divE (IntVal i1) (FloatVal i2) = FloatVal (fromIntegral i1 / i2)
-- DoubleVal promotions.
divE (DoubleVal i1) (IntVal i2) = DoubleVal (i1 / fromIntegral i2)
divE (IntVal i1) (DoubleVal i2) = DoubleVal (fromIntegral i1 / i2)
divE (DoubleVal i1) (FloatVal i2) = DoubleVal (i1 / float2Double i2)
divE (FloatVal i1) (DoubleVal i2) = DoubleVal (float2Double i1 / i2)
-- LongVal promotions.
divE (LongVal i1) (IntVal i2) = LongVal (i1 / fromIntegral i2)
divE (IntVal i1) (LongVal i2) = LongVal (fromIntegral i1 / i2)
divE (LongVal i1) (FloatVal i2) = LongVal (i1 / float2Double i2)
divE (LongVal i1) (DoubleVal i2) = LongVal (i1 / i2)
divE (DoubleVal i1) (LongVal i2) = LongVal (i1 / i2)
divE (FloatVal i1) (LongVal i2) = LongVal (float2Double i1 / i2)
-- Type mismatches.
divE (StringVal _) _ = error "Type mismatch: You cannot divide a string"
divE _ (StringVal _) = error "Type mismatch: You cannot divide a string"
divE (CharVal _) _ = error "Type mismatch: You cannot divide a char"
divE _ (CharVal _) = error "Type mismatch: You cannot divide a char"
divE (ArrayVal _) _ = error "Type mismatch: You cannot divide an array"
divE _ (ArrayVal _) = error "Type mismatch: You cannot divide an array"

instance PrintfArg LiteralValue where
  formatArg (IntVal i) fmt
    | fmtChar (vFmt 'd' fmt) == 'd' = formatInt i (fmt { fmtChar = 'd', fmtPrecision = Nothing })
    | fmtChar (vFmt 'v' fmt) == 'v' = formatInt i (fmt { fmtChar = 'v', fmtPrecision = Nothing })
  formatArg (FloatVal f) fmt
    | fmtChar (vFmt 'f' fmt) == 'f' = formatRealFloat f (fmt { fmtChar = 'f', fmtPrecision = Nothing })
    | fmtChar (vFmt 'F' fmt) == 'F' = formatRealFloat f (fmt { fmtChar = 'F', fmtPrecision = Nothing })
    | fmtChar (vFmt 'g' fmt) == 'g' = formatRealFloat f (fmt { fmtChar = 'g', fmtPrecision = Nothing })
    | fmtChar (vFmt 'G' fmt) == 'G' = formatRealFloat f (fmt { fmtChar = 'G', fmtPrecision = Nothing })
    | fmtChar (vFmt 'v' fmt) == 'v' = formatRealFloat f (fmt { fmtChar = 'v', fmtPrecision = Nothing })
  formatArg (DoubleVal d) fmt
    | fmtChar (vFmt 'f' fmt) == 'f' = formatRealFloat d (fmt { fmtChar = 'f', fmtPrecision = Nothing })
    | fmtChar (vFmt 'v' fmt) == 'v' = formatRealFloat d (fmt { fmtChar = 'v', fmtPrecision = Nothing })
  formatArg (LongVal d) fmt
    | fmtChar (vFmt 'f' fmt) == 'f' = formatRealFloat d (fmt { fmtChar = 'f', fmtPrecision = Nothing })
    | fmtChar (vFmt 'v' fmt) == 'v' = formatRealFloat d (fmt { fmtChar = 'v', fmtPrecision = Nothing })
  formatArg (CharVal c) fmt
    | fmtChar (vFmt 'c' fmt) == 'c' = formatChar c (fmt { fmtChar = 'c', fmtPrecision = Nothing })
    | fmtChar (vFmt 'v' fmt) == 'v' = formatChar c (fmt { fmtChar = 'v', fmtPrecision = Nothing })
  formatArg (StringVal s) fmt
    | fmtChar (vFmt 's' fmt) == 's' = formatString s (fmt { fmtChar = 's', fmtPrecision = Nothing })
    | fmtChar (vFmt 'v' fmt) == 'v' = formatString s (fmt { fmtChar = 'v', fmtPrecision = Nothing })
  formatArg _ fmt = errorBadFormat $ fmtChar fmt

replace :: String -> String -> String -> String
replace old new = intercalate new . splitOn old

fixNewline :: String -> String
fixNewline s = replace "\\n" "\n" s

-- | Expand a list of values to a series of arguments to printf
sPrintfList :: LiteralValue -> [LiteralValue] -> IO ()
sPrintfList (StringVal format) [] = printf (fixNewline format)
sPrintfList (StringVal format) (s:[]) = printf (fixNewline format) s
sPrintfList (StringVal format) (s:s1:[]) = printf (fixNewline format) s s1
sPrintfList (StringVal format) (s:s1:s2:[]) = printf (fixNewline format) s s1 s2
sPrintfList (StringVal format) (s:s1:s2:s3:[]) = printf (fixNewline format) s s1 s2 s3
sPrintfList (StringVal format) (s:s1:s2:s3:s4:[]) = printf (fixNewline format) s s1 s2 s3 s4
sPrintfList (StringVal format) (s:s1:s2:s3:s4:s5:[]) = printf (fixNewline format) s s1 s2 s3 s4 s5
sPrintfList (StringVal format) (s:s1:s2:s3:s4:s5:s6:[]) = printf (fixNewline format) s s1 s2 s3 s4 s5 s6
sPrintfList (StringVal format) (s:s1:s2:s3:s4:s5:s6:s7:[]) = printf (fixNewline format) s s1 s2 s3 s4 s5 s6 s7
sPrintfList (StringVal format) (s:s1:s2:s3:s4:s5:s6:s7:s8:[]) = printf (fixNewline format) s s1 s2 s3 s4 s5 s6 s7 s8
sPrintfList (StringVal format) (s:s1:s2:s3:s4:s5:s6:s7:s8:s9:[]) = printf (fixNewline format) s s1 s2 s3 s4 s5 s6 s7 s8 s9
sPrintfList (StringVal format) (s:s1:s2:s3:s4:s5:s6:s7:s8:s9:s10:[]) = printf (fixNewline format) s s1 s2 s3 s4 s5 s6 s7 s8 s9 s10
sPrintfList _ _ = error $ "Error while calling 'printf': Printf needs a string as the first argument!"

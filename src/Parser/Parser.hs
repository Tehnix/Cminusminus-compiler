{-# OPTIONS_GHC -w #-}
{-# OPTIONS -XMagicHash -XBangPatterns -XTypeSynonymInstances -XFlexibleInstances -cpp #-}
#if __GLASGOW_HASKELL__ >= 710
{-# OPTIONS_GHC -XPartialTypeSignatures #-}
#endif
module Parser.Parser (parseTokens) where
import Parser.Syntax
import Parser.Token
import Parser.Literal
import Parser.Common
import qualified Data.List.NonEmpty as NonE
import Data.List.NonEmpty (NonEmpty(..))
import qualified Data.Map.Strict as Map
import qualified Parser.Lexer as Lexer
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import qualified GHC.Exts as Happy_GHC_Exts
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.8

newtype HappyAbsSyn  = HappyAbsSyn HappyAny
#if __GLASGOW_HASKELL__ >= 607
type HappyAny = Happy_GHC_Exts.Any
#else
type HappyAny = forall a . a
#endif
happyIn4 :: (Prog) -> (HappyAbsSyn )
happyIn4 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn4 #-}
happyOut4 :: (HappyAbsSyn ) -> (Prog)
happyOut4 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut4 #-}
happyIn5 :: (Declaration) -> (HappyAbsSyn )
happyIn5 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn5 #-}
happyOut5 :: (HappyAbsSyn ) -> (Declaration)
happyOut5 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut5 #-}
happyIn6 :: (VarDeclaration) -> (HappyAbsSyn )
happyIn6 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn6 #-}
happyOut6 :: (HappyAbsSyn ) -> (VarDeclaration)
happyOut6 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut6 #-}
happyIn7 :: (Type) -> (HappyAbsSyn )
happyIn7 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn7 #-}
happyOut7 :: (HappyAbsSyn ) -> (Type)
happyOut7 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut7 #-}
happyIn8 :: (Parameter) -> (HappyAbsSyn )
happyIn8 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn8 #-}
happyOut8 :: (HappyAbsSyn ) -> (Parameter)
happyOut8 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut8 #-}
happyIn9 :: (Function) -> (HappyAbsSyn )
happyIn9 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn ) -> (Function)
happyOut9 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut9 #-}
happyIn10 :: (Stmt) -> (HappyAbsSyn )
happyIn10 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn ) -> (Stmt)
happyOut10 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut10 #-}
happyIn11 :: (Stmt) -> (HappyAbsSyn )
happyIn11 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn ) -> (Stmt)
happyOut11 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut11 #-}
happyIn12 :: (Assignment) -> (HappyAbsSyn )
happyIn12 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn ) -> (Assignment)
happyOut12 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut12 #-}
happyIn13 :: (Expr) -> (HappyAbsSyn )
happyIn13 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn13 #-}
happyOut13 :: (HappyAbsSyn ) -> (Expr)
happyOut13 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut13 #-}
happyIn14 :: ([Stmt]) -> (HappyAbsSyn )
happyIn14 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn ) -> ([Stmt])
happyOut14 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut14 #-}
happyIn15 :: (Maybe Assignment) -> (HappyAbsSyn )
happyIn15 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn ) -> (Maybe Assignment)
happyOut15 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: (Maybe Expr) -> (HappyAbsSyn )
happyIn16 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn ) -> (Maybe Expr)
happyOut16 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: ([Expr]) -> (HappyAbsSyn )
happyIn17 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> ([Expr])
happyOut17 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: ([(Identifier, Type)]) -> (HappyAbsSyn )
happyIn18 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> ([(Identifier, Type)])
happyOut18 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: ([DclParmDcl]) -> (HappyAbsSyn )
happyIn19 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> ([DclParmDcl])
happyOut19 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: ([VarDeclaration]) -> (HappyAbsSyn )
happyIn20 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn ) -> ([VarDeclaration])
happyOut20 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut20 #-}
happyIn21 :: ([(Type, [VarDeclaration])]) -> (HappyAbsSyn )
happyIn21 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn ) -> ([(Type, [VarDeclaration])])
happyOut21 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut21 #-}
happyInTok :: (Lexer.TokenPos) -> (HappyAbsSyn )
happyInTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> (Lexer.TokenPos)
happyOutTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOutTok #-}


happyExpList :: HappyAddr
happyExpList = HappyA# "\x00\x00\x00\x00\x00\x00\x00\xfc\x00\x00\x00\x00\x00\x00\x00\xc0\x0f\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf8\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x22\x00\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x00\x00\x22\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf8\x01\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf8\x01\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x20\x00\x00\x00\x00\x00\x00\x00\x20\x02\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x00\x06\x08\x19\x00\xba\x6f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf8\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x60\x80\x90\x01\xa0\xfb\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\xa2\x18\x00\x00\x00\x00\x00\x60\x80\x90\x01\xa0\xfb\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfe\x1f\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x20\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\xc0\x3f\x40\x04\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\x40\x00\x80\x01\x00\xf8\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\xc0\x3f\x40\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\xc0\x3f\x40\x04\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\xc0\x3f\x40\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\x00\x00\x20\xfe\x1f\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfe\x1f\x00\x00\x00\x00\x00\x40\xe0\xff\x01\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x00\xfe\x1f\x00\x00\x00\x00\x00\x04\xe0\xff\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x8a\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\xe0\xff\x01\x00\x00\x00\xc0\x3f\x40\x04\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\xc0\x3f\x40\x04\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\xc0\x3f\x40\x04\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\xc0\x3f\x40\x04\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\xc0\x3f\x40\x04\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\xc0\x3f\x40\x04\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\xc0\x3f\x40\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfe\x0f\x00\x00\x00\x00\x00\x00\xe0\x7f\x00\x00\x00\x00\x00\x00\x00\x1e\x00\x00\x00\x00\x00\x00\x00\xe0\x01\x00\x00\x00\x00\x00\x00\x00\x1e\x00\x00\x00\x00\x00\x00\x00\xe0\x01\x00\x00\x00\x00\x00\x00\x00\x9e\x07\x00\x00\x00\x00\x00\x00\xe0\x79\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00\x00\x00\x80\x01\x00\x00\x00\x00\x00\x00\x04\xfe\x1f\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\x60\x80\x90\x01\x00\xfa\x06\x00\x00\x06\x08\x19\x00\xa0\x6f\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x80\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\x00\x00\x00\xfe\x1f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\x03\x44\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x00\x80\x01\x00\xf8\x00\x00\x00\x06\x08\x19\x00\xa0\x6f\x00\x00\x00\x00\x00\xfe\x1f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x06\x08\x19\x00\xa0\x6f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parseTokens","prog","dcl","var_decl","type","parm_types","func","stmt","stmt_block","assg","expr","many_stmt","maybe_assg","maybe_expr","many_expr","some_parm_type","some_id_parm_types","some_var_decl","many_fun_var_decl","'printf'","id","intcon","floatcon","doublecon","longcon","charcon","stringcon","'('","')'","'{'","'}'","'['","']'","'='","';'","','","'!'","'++'","'--'","'+'","'-'","'*'","'/'","'=='","'!='","'<='","'<'","'>='","'>'","'&&'","'||'","'if'","'else'","'while'","'for'","'return'","'extern'","'char'","'int'","'float'","'double'","'long'","'void'","lineCom","multiLineCom","%eof"]
        bit_start = st * 68
        bit_end = (st + 1) * 68
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..67]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x79\x00\x79\x00\xf7\xff\x18\x00\x07\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xec\xff\x86\x00\x79\x00\x00\x00\x47\x00\x00\x00\x00\x00\x14\x00\x87\x00\x1a\x00\x79\x00\x00\x00\xe5\x00\xaf\x00\x00\x00\x00\x00\xe5\x00\xb1\x00\x00\x00\xa7\x00\xd3\x00\x32\x00\x00\x00\x00\x00\xc6\x00\xd0\x00\xda\x00\x00\x00\xf9\xff\xc5\x00\xec\x00\x07\x01\x07\x01\xf1\x00\x00\x00\xfe\x00\x06\x01\x01\x00\x00\x00\xf8\x00\x07\x01\x1a\x01\x01\x00\x00\x00\xf0\x00\x08\x01\x20\x01\xc4\x00\x01\x00\x00\x00\x28\x01\x29\x01\x2d\x01\x31\x01\x37\x01\x7b\x00\x00\x00\x00\x00\x33\x01\x07\x01\xac\x00\x34\x01\x81\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7b\x00\x7b\x00\x7b\x00\x2b\x00\x7b\x00\x7b\x00\x00\x00\x00\x00\x35\x01\x7b\x00\x7b\x00\x7b\x00\x00\x00\x00\x00\x7b\x00\x00\x00\x00\x00\x00\x00\x38\x01\x00\x00\x7b\x00\xa0\x00\x3b\x01\xac\x00\x7d\x00\x3c\x01\x00\x00\x2e\x00\x45\x00\x00\x00\x39\x01\xf7\x00\x00\x00\x00\x00\x5c\x00\x7b\x00\x7b\x00\x00\x00\x7b\x00\x7b\x00\x7b\x00\x7b\x00\x7b\x00\x7b\x00\x7b\x00\x7b\x00\x7b\x00\x7b\x00\x7b\x00\x7b\x00\x00\x00\xc7\x00\x52\x00\x26\x01\x26\x01\x26\x01\x26\x01\xd2\x00\xd2\x00\x00\x00\x00\x00\x39\x00\x39\x00\x90\x00\x3e\x01\x00\x00\x7b\x00\x0c\x00\x0c\x00\x3a\x01\x3d\x01\x3f\x01\x7b\x00\xac\x00\x00\x00\x00\x00\x7b\x00\x00\x00\x2e\x01\x00\x00\x41\x01\x00\x00\x00\x00\x2b\x00\x0c\x00\xac\x00\x00\x00\x43\x01\x0c\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x12\x01\x56\x00\x00\x00\x03\x00\x48\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\x00\x18\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x09\x00\x00\x00\x1e\x01\x00\x00\x82\x00\x00\x00\x00\x00\x00\x00\xcb\x00\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2d\x00\x05\x00\x44\x01\x00\x00\x00\x00\x0e\x00\xef\x00\x00\x00\x00\x00\xcd\x00\x00\x00\xf5\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfb\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfd\xff\x00\x00\x00\x00\x00\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x45\x01\x49\x01\x4b\x01\x84\x00\x4c\x01\x4d\x01\x00\x00\x00\x00\x00\x00\x0d\x01\x4e\x01\x4f\x01\x00\x00\x00\x00\x2a\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x50\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2b\x01\x51\x01\x00\x00\x52\x01\x53\x01\x54\x01\x55\x01\x56\x01\x57\x01\x58\x01\x59\x01\x5a\x01\x5b\x01\x5c\x01\x5d\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x36\x01\x3a\x00\x1d\x01\x00\x00\x00\x00\x00\x00\x2c\x01\x00\x00\x00\x00\x00\x00\x5e\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe9\x00\x1f\x01\x00\x00\x00\x00\x00\x00\x25\x01\x00\x00\x00\x00"#

happyAdjustOffset :: Happy_GHC_Exts.Int# -> Happy_GHC_Exts.Int#
happyAdjustOffset off = off

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xfc\xff\x00\x00\x00\x00\x00\x00\x00\x00\xf5\xff\xf4\xff\xf3\xff\xf2\xff\xf1\xff\x00\x00\x00\x00\xfc\xff\xfd\xff\xb1\xff\xfa\xff\xf8\xff\xf6\xff\x00\x00\xf6\xff\xfc\xff\xfe\xff\x00\x00\x00\x00\xfb\xff\xf9\xff\x00\x00\x00\x00\xb2\xff\xf6\xff\x00\x00\x00\x00\xef\xff\xf0\xff\x00\x00\x00\x00\xb3\xff\xf7\xff\xb3\xff\xb5\xff\x00\x00\x00\x00\xaf\xff\x00\x00\xb4\xff\x00\x00\x00\x00\xc0\xff\xb6\xff\xb7\xff\x00\x00\x00\x00\xc0\xff\xe9\xff\x00\x00\x00\x00\x00\x00\x00\x00\xc0\xff\xe3\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbc\xff\xe2\xff\xe1\xff\x00\x00\xaf\xff\xbd\xff\x00\x00\xc9\xff\xc7\xff\xc6\xff\xc5\xff\xc4\xff\xc3\xff\xc2\xff\x00\x00\x00\x00\x00\x00\xbe\xff\x00\x00\x00\x00\xdb\xff\xdd\xff\x00\x00\xb9\xff\x00\x00\x00\x00\xdc\xff\xda\xff\xb9\xff\xee\xff\xe8\xff\xc1\xff\x00\x00\xb8\xff\x00\x00\xba\xff\x00\x00\xdf\xff\x00\x00\x00\x00\xe7\xff\x00\x00\x00\x00\xbf\xff\x00\x00\x00\x00\xd9\xff\xd8\xff\x00\x00\xb9\xff\x00\x00\xe6\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb0\xff\xcc\xff\xcd\xff\xce\xff\xcf\xff\xd0\xff\xd1\xff\xd2\xff\xd3\xff\xd4\xff\xd5\xff\xd6\xff\xd7\xff\x00\x00\x00\x00\xc8\xff\xbc\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb9\xff\xde\xff\xbb\xff\xe4\xff\x00\x00\xe5\xff\xed\xff\xeb\xff\x00\x00\xcb\xff\xca\xff\xbe\xff\x00\x00\xe0\xff\xec\xff\x00\x00\x00\x00\xea\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x02\x00\x01\x00\x02\x00\x0b\x00\x02\x00\x09\x00\x10\x00\x03\x00\x0c\x00\x11\x00\x02\x00\x0b\x00\x01\x00\x02\x00\x10\x00\x02\x00\x10\x00\x0f\x00\x10\x00\x13\x00\x14\x00\x11\x00\x0b\x00\x0f\x00\x10\x00\x02\x00\x2f\x00\x10\x00\x09\x00\x10\x00\x13\x00\x14\x00\x0d\x00\x21\x00\x09\x00\x23\x00\x24\x00\x25\x00\x0d\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x02\x00\x2d\x00\x2e\x00\x03\x00\x25\x00\x03\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x0a\x00\x2d\x00\x2e\x00\x0e\x00\x0a\x00\x03\x00\x13\x00\x14\x00\x11\x00\x07\x00\x08\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x0a\x00\x17\x00\x18\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x01\x00\x11\x00\x03\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x0a\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x03\x00\x04\x00\x03\x00\x02\x00\x02\x00\x09\x00\x0e\x00\x08\x00\x12\x00\x0d\x00\x0b\x00\x0e\x00\x16\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x0e\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x11\x00\x03\x00\x02\x00\x0d\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x09\x00\x03\x00\x04\x00\x03\x00\x0d\x00\x0d\x00\x0f\x00\x0e\x00\x02\x00\x11\x00\x13\x00\x14\x00\x0e\x00\x0a\x00\x0e\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x15\x00\x16\x00\x17\x00\x18\x00\x11\x00\x03\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x08\x00\x03\x00\x02\x00\x0b\x00\x06\x00\x07\x00\x08\x00\x03\x00\x0a\x00\x0e\x00\x06\x00\x07\x00\x08\x00\x03\x00\x0a\x00\x10\x00\x06\x00\x07\x00\x08\x00\x0d\x00\x0a\x00\x0f\x00\x09\x00\x02\x00\x11\x00\x13\x00\x14\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x00\x00\x01\x00\x0c\x00\x03\x00\x09\x00\x05\x00\x00\x00\x01\x00\x0d\x00\x03\x00\x02\x00\x05\x00\x00\x00\x01\x00\x03\x00\x03\x00\x03\x00\x05\x00\x07\x00\x08\x00\x07\x00\x08\x00\x03\x00\x09\x00\x02\x00\x02\x00\x07\x00\x08\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x09\x00\x09\x00\x09\x00\x09\x00\x0d\x00\x0d\x00\x0d\x00\x09\x00\x15\x00\x16\x00\x17\x00\x18\x00\x09\x00\x09\x00\x0c\x00\x0c\x00\x10\x00\x10\x00\x0a\x00\x0a\x00\x0f\x00\x0a\x00\x10\x00\x10\x00\x03\x00\x0f\x00\x0a\x00\x09\x00\x10\x00\x22\x00\x10\x00\x09\x00\x0f\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\x09\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x0e\x00\x39\x00\x3a\x00\x2b\x00\x0e\x00\x46\x00\x15\x00\x2e\x00\x47\x00\x2c\x00\x0e\x00\x3b\x00\x39\x00\x3a\x00\x1c\x00\x0e\x00\x3c\x00\x0f\x00\x10\x00\x3d\x00\x3e\x00\x2f\x00\x3b\x00\x18\x00\x19\x00\x14\x00\xff\xff\x3c\x00\x1b\x00\x44\x00\x3d\x00\x3e\x00\x18\x00\x3f\x00\x17\x00\x40\x00\x41\x00\x42\x00\x18\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x6f\x00\x43\x00\x44\x00\x1e\x00\x42\x00\x2e\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x94\x00\x43\x00\x44\x00\x30\x00\x27\x00\x33\x00\x3d\x00\x3e\x00\x81\x00\x9e\x00\x36\x00\x76\x00\x77\x00\x78\x00\x79\x00\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\x80\x00\x81\x00\x93\x00\x78\x00\x79\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x02\x00\x1c\x00\x03\x00\x76\x00\x77\x00\x78\x00\x79\x00\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\x80\x00\x81\x00\x91\x00\x76\x00\x77\x00\x78\x00\x79\x00\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\x76\x00\x77\x00\x78\x00\x79\x00\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\x80\x00\x81\x00\x49\x00\x4a\x00\x4b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x1e\x00\x23\x00\x33\x00\x12\x00\x14\x00\x73\x00\x96\x00\x6c\x00\x51\x00\x74\x00\x6d\x00\x20\x00\x52\x00\x76\x00\x77\x00\x78\x00\x79\x00\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\x80\x00\x81\x00\xa2\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x76\x00\x77\x00\x78\x00\x79\x00\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\x80\x00\x81\x00\x98\x00\x23\x00\x1e\x00\x18\x00\x76\x00\x77\x00\x78\x00\x79\x00\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\x80\x00\x81\x00\x76\x00\x77\x00\x78\x00\x79\x00\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\x80\x00\x81\x00\x59\x00\x1e\x00\x1f\x00\x1e\x00\x5a\x00\x29\x00\x5b\x00\x26\x00\x28\x00\x2a\x00\x5c\x00\x5d\x00\x20\x00\x25\x00\x62\x00\x76\x00\x77\x00\x78\x00\x79\x00\x7a\x00\x7b\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\x80\x00\x76\x00\x77\x00\x78\x00\x79\x00\x2c\x00\x33\x00\x7c\x00\x7d\x00\x7e\x00\x7f\x00\x6c\x00\x33\x00\x2e\x00\xa6\x00\x34\x00\x35\x00\x36\x00\x33\x00\x37\x00\x32\x00\x34\x00\x35\x00\x36\x00\x33\x00\x60\x00\x60\x00\x34\x00\x35\x00\x36\x00\x5a\x00\x57\x00\x5b\x00\x17\x00\x1e\x00\x33\x00\x5c\x00\x5d\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x22\x00\x0a\x00\x02\x00\x5f\x00\x0b\x00\x64\x00\x0c\x00\x0d\x00\x02\x00\x68\x00\x0b\x00\x62\x00\x0c\x00\x15\x00\x02\x00\x33\x00\x0b\x00\x33\x00\x0c\x00\x9d\x00\x36\x00\xa5\x00\x36\x00\x33\x00\x5e\x00\x57\x00\x56\x00\xa8\x00\x36\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x64\x00\x64\x00\x64\x00\x55\x00\x65\x00\x8f\x00\x99\x00\x54\x00\x76\x00\x77\x00\x78\x00\x79\x00\x46\x00\x53\x00\x6a\x00\x9f\x00\x46\x00\x75\x00\x97\x00\x95\x00\x64\x00\xa1\x00\x92\x00\x9d\x00\x12\x00\x9c\x00\xa8\x00\x71\x00\x9b\x00\xa4\x00\xa3\x00\x70\x00\x2c\x00\x6f\x00\x6b\x00\x6a\x00\x67\x00\x66\x00\x98\x00\x8e\x00\x8d\x00\x8c\x00\x8b\x00\x8a\x00\x89\x00\x88\x00\x87\x00\x86\x00\x85\x00\x84\x00\x83\x00\x82\x00\xa4\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = Happy_Data_Array.array (1, 80) [
	(1 , happyReduce_1),
	(2 , happyReduce_2),
	(3 , happyReduce_3),
	(4 , happyReduce_4),
	(5 , happyReduce_5),
	(6 , happyReduce_6),
	(7 , happyReduce_7),
	(8 , happyReduce_8),
	(9 , happyReduce_9),
	(10 , happyReduce_10),
	(11 , happyReduce_11),
	(12 , happyReduce_12),
	(13 , happyReduce_13),
	(14 , happyReduce_14),
	(15 , happyReduce_15),
	(16 , happyReduce_16),
	(17 , happyReduce_17),
	(18 , happyReduce_18),
	(19 , happyReduce_19),
	(20 , happyReduce_20),
	(21 , happyReduce_21),
	(22 , happyReduce_22),
	(23 , happyReduce_23),
	(24 , happyReduce_24),
	(25 , happyReduce_25),
	(26 , happyReduce_26),
	(27 , happyReduce_27),
	(28 , happyReduce_28),
	(29 , happyReduce_29),
	(30 , happyReduce_30),
	(31 , happyReduce_31),
	(32 , happyReduce_32),
	(33 , happyReduce_33),
	(34 , happyReduce_34),
	(35 , happyReduce_35),
	(36 , happyReduce_36),
	(37 , happyReduce_37),
	(38 , happyReduce_38),
	(39 , happyReduce_39),
	(40 , happyReduce_40),
	(41 , happyReduce_41),
	(42 , happyReduce_42),
	(43 , happyReduce_43),
	(44 , happyReduce_44),
	(45 , happyReduce_45),
	(46 , happyReduce_46),
	(47 , happyReduce_47),
	(48 , happyReduce_48),
	(49 , happyReduce_49),
	(50 , happyReduce_50),
	(51 , happyReduce_51),
	(52 , happyReduce_52),
	(53 , happyReduce_53),
	(54 , happyReduce_54),
	(55 , happyReduce_55),
	(56 , happyReduce_56),
	(57 , happyReduce_57),
	(58 , happyReduce_58),
	(59 , happyReduce_59),
	(60 , happyReduce_60),
	(61 , happyReduce_61),
	(62 , happyReduce_62),
	(63 , happyReduce_63),
	(64 , happyReduce_64),
	(65 , happyReduce_65),
	(66 , happyReduce_66),
	(67 , happyReduce_67),
	(68 , happyReduce_68),
	(69 , happyReduce_69),
	(70 , happyReduce_70),
	(71 , happyReduce_71),
	(72 , happyReduce_72),
	(73 , happyReduce_73),
	(74 , happyReduce_74),
	(75 , happyReduce_75),
	(76 , happyReduce_76),
	(77 , happyReduce_77),
	(78 , happyReduce_78),
	(79 , happyReduce_79),
	(80 , happyReduce_80)
	]

happy_n_terms = 48 :: Int
happy_n_nonterms = 18 :: Int

happyReduce_1 = happySpecReduce_3  0# happyReduction_1
happyReduction_1 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut4 happy_x_3 of { happy_var_3 -> 
	happyIn4
		 (Decl happy_var_1 happy_var_3
	)}}

happyReduce_2 = happySpecReduce_2  0# happyReduction_2
happyReduction_2 happy_x_2
	happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut4 happy_x_2 of { happy_var_2 -> 
	happyIn4
		 (Func happy_var_1 happy_var_2
	)}}

happyReduce_3 = happySpecReduce_0  0# happyReduction_3
happyReduction_3  =  happyIn4
		 (EOF
	)

happyReduce_4 = happySpecReduce_3  1# happyReduction_4
happyReduction_4 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_2 of { happy_var_2 -> 
	case happyOut19 happy_x_3 of { happy_var_3 -> 
	happyIn5
		 (Dcl Extern happy_var_2 (NonE.fromList happy_var_3)
	)}}

happyReduce_5 = happySpecReduce_2  1# happyReduction_5
happyReduction_5 happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	case happyOut19 happy_x_2 of { happy_var_2 -> 
	happyIn5
		 (Dcl Normal happy_var_1 (NonE.fromList happy_var_2)
	)}}

happyReduce_6 = happySpecReduce_3  1# happyReduction_6
happyReduction_6 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_2 of { happy_var_2 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn5
		 (DclVar Extern happy_var_2 (NonE.fromList happy_var_3)
	)}}

happyReduce_7 = happySpecReduce_2  1# happyReduction_7
happyReduction_7 happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_2 of { happy_var_2 -> 
	happyIn5
		 (DclVar Normal happy_var_1 (NonE.fromList happy_var_2)
	)}}

happyReduce_8 = happyReduce 4# 2# happyReduction_8
happyReduction_8 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { ((TokenId happy_var_1, _)) -> 
	case happyOutTok happy_x_3 of { ((TokenInt happy_var_3, _)) -> 
	happyIn6
		 (Var happy_var_1 (Index (LitInt happy_var_3))
	) `HappyStk` happyRest}}

happyReduce_9 = happySpecReduce_1  2# happyReduction_9
happyReduction_9 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((TokenId happy_var_1, _)) -> 
	happyIn6
		 (Var happy_var_1 NotArray
	)}

happyReduce_10 = happySpecReduce_1  3# happyReduction_10
happyReduction_10 happy_x_1
	 =  happyIn7
		 (TypeChar
	)

happyReduce_11 = happySpecReduce_1  3# happyReduction_11
happyReduction_11 happy_x_1
	 =  happyIn7
		 (TypeInt
	)

happyReduce_12 = happySpecReduce_1  3# happyReduction_12
happyReduction_12 happy_x_1
	 =  happyIn7
		 (TypeFloat
	)

happyReduce_13 = happySpecReduce_1  3# happyReduction_13
happyReduction_13 happy_x_1
	 =  happyIn7
		 (TypeDouble
	)

happyReduce_14 = happySpecReduce_1  3# happyReduction_14
happyReduction_14 happy_x_1
	 =  happyIn7
		 (TypeLong
	)

happyReduce_15 = happySpecReduce_1  4# happyReduction_15
happyReduction_15 happy_x_1
	 =  happyIn8
		 (EmptyParam
	)

happyReduce_16 = happySpecReduce_1  4# happyReduction_16
happyReduction_16 happy_x_1
	 =  case happyOut18 happy_x_1 of { happy_var_1 -> 
	happyIn8
		 (Param (Map.fromList happy_var_1)
	)}

happyReduce_17 = happyReduce 9# 5# happyReduction_17
happyReduction_17 (happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut7 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { ((TokenId happy_var_2, _)) -> 
	case happyOut8 happy_x_4 of { happy_var_4 -> 
	case happyOut21 happy_x_7 of { happy_var_7 -> 
	case happyOut14 happy_x_8 of { happy_var_8 -> 
	happyIn9
		 (Fun happy_var_1 happy_var_2 happy_var_4 (funVarToMany happy_var_7) (listToMany happy_var_8)
	) `HappyStk` happyRest}}}}}

happyReduce_18 = happyReduce 5# 6# happyReduction_18
happyReduction_18 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut13 happy_x_3 of { happy_var_3 -> 
	case happyOut11 happy_x_5 of { happy_var_5 -> 
	happyIn10
		 (If happy_var_3 happy_var_5
	) `HappyStk` happyRest}}

happyReduce_19 = happyReduce 7# 6# happyReduction_19
happyReduction_19 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut13 happy_x_3 of { happy_var_3 -> 
	case happyOut11 happy_x_5 of { happy_var_5 -> 
	case happyOut11 happy_x_7 of { happy_var_7 -> 
	happyIn10
		 (IfElse happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_20 = happyReduce 5# 6# happyReduction_20
happyReduction_20 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut13 happy_x_3 of { happy_var_3 -> 
	case happyOut11 happy_x_5 of { happy_var_5 -> 
	happyIn10
		 (While happy_var_3 happy_var_5
	) `HappyStk` happyRest}}

happyReduce_21 = happyReduce 9# 6# happyReduction_21
happyReduction_21 (happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut15 happy_x_3 of { happy_var_3 -> 
	case happyOut16 happy_x_5 of { happy_var_5 -> 
	case happyOut15 happy_x_7 of { happy_var_7 -> 
	case happyOut11 happy_x_9 of { happy_var_9 -> 
	happyIn10
		 (For happy_var_3 happy_var_5 happy_var_7 happy_var_9
	) `HappyStk` happyRest}}}}

happyReduce_22 = happySpecReduce_1  6# happyReduction_22
happyReduction_22 happy_x_1
	 =  case happyOut11 happy_x_1 of { happy_var_1 -> 
	happyIn10
		 (happy_var_1
	)}

happyReduce_23 = happySpecReduce_2  7# happyReduction_23
happyReduction_23 happy_x_2
	happy_x_1
	 =  case happyOut12 happy_x_1 of { happy_var_1 -> 
	happyIn11
		 (StmtAssgn happy_var_1
	)}

happyReduce_24 = happySpecReduce_3  7# happyReduction_24
happyReduction_24 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut14 happy_x_2 of { happy_var_2 -> 
	happyIn11
		 (StmtBlock (listToMany happy_var_2)
	)}

happyReduce_25 = happySpecReduce_3  7# happyReduction_25
happyReduction_25 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut16 happy_x_2 of { happy_var_2 -> 
	happyIn11
		 (Return happy_var_2
	)}

happyReduce_26 = happyReduce 5# 7# happyReduction_26
happyReduction_26 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { ((TokenId happy_var_1, _)) -> 
	case happyOut17 happy_x_3 of { happy_var_3 -> 
	happyIn11
		 (StmtId happy_var_1 (listToMany happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_27 = happyReduce 5# 7# happyReduction_27
happyReduction_27 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut17 happy_x_3 of { happy_var_3 -> 
	happyIn11
		 (StmtPrintf (listToMany happy_var_3)
	) `HappyStk` happyRest}

happyReduce_28 = happySpecReduce_1  7# happyReduction_28
happyReduction_28 happy_x_1
	 =  happyIn11
		 (EmptyStmt
	)

happyReduce_29 = happySpecReduce_1  7# happyReduction_29
happyReduction_29 happy_x_1
	 =  happyIn11
		 (EmptyStmt
	)

happyReduce_30 = happySpecReduce_1  7# happyReduction_30
happyReduction_30 happy_x_1
	 =  happyIn11
		 (EmptyStmt
	)

happyReduce_31 = happyReduce 6# 8# happyReduction_31
happyReduction_31 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { ((TokenId happy_var_1, _)) -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	case happyOut13 happy_x_6 of { happy_var_6 -> 
	happyIn12
		 (AssignId Nothing happy_var_1 (Index happy_var_3) happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_32 = happySpecReduce_3  8# happyReduction_32
happyReduction_32 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { ((TokenId happy_var_1, _)) -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn12
		 (AssignId Nothing happy_var_1 NotArray happy_var_3
	)}}

happyReduce_33 = happyReduce 4# 8# happyReduction_33
happyReduction_33 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut7 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { ((TokenId happy_var_2, _)) -> 
	case happyOut13 happy_x_4 of { happy_var_4 -> 
	happyIn12
		 (AssignId (Just happy_var_1) happy_var_2 NotArray happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_34 = happySpecReduce_2  8# happyReduction_34
happyReduction_34 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { ((TokenId happy_var_2, _)) -> 
	happyIn12
		 (PrefixInc happy_var_2
	)}

happyReduce_35 = happySpecReduce_2  8# happyReduction_35
happyReduction_35 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { ((TokenId happy_var_1, _)) -> 
	happyIn12
		 (PostfixInc happy_var_1
	)}

happyReduce_36 = happySpecReduce_2  8# happyReduction_36
happyReduction_36 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { ((TokenId happy_var_2, _)) -> 
	happyIn12
		 (PrefixDec happy_var_2
	)}

happyReduce_37 = happySpecReduce_2  8# happyReduction_37
happyReduction_37 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { ((TokenId happy_var_1, _)) -> 
	happyIn12
		 (PostfixDec happy_var_1
	)}

happyReduce_38 = happySpecReduce_2  9# happyReduction_38
happyReduction_38 happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_2 of { happy_var_2 -> 
	happyIn13
		 (Negate happy_var_2
	)}

happyReduce_39 = happySpecReduce_2  9# happyReduction_39
happyReduction_39 happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_2 of { happy_var_2 -> 
	happyIn13
		 (NegateBool happy_var_2
	)}

happyReduce_40 = happySpecReduce_3  9# happyReduction_40
happyReduction_40 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (BinOp Plus happy_var_1 happy_var_3
	)}}

happyReduce_41 = happySpecReduce_3  9# happyReduction_41
happyReduction_41 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (BinOp Minus happy_var_1 happy_var_3
	)}}

happyReduce_42 = happySpecReduce_3  9# happyReduction_42
happyReduction_42 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (BinOp Mul happy_var_1 happy_var_3
	)}}

happyReduce_43 = happySpecReduce_3  9# happyReduction_43
happyReduction_43 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (BinOp Div happy_var_1 happy_var_3
	)}}

happyReduce_44 = happySpecReduce_3  9# happyReduction_44
happyReduction_44 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (RelOp Equal happy_var_1 happy_var_3
	)}}

happyReduce_45 = happySpecReduce_3  9# happyReduction_45
happyReduction_45 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (RelOp NotEqual happy_var_1 happy_var_3
	)}}

happyReduce_46 = happySpecReduce_3  9# happyReduction_46
happyReduction_46 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (RelOp LessThanEqual happy_var_1 happy_var_3
	)}}

happyReduce_47 = happySpecReduce_3  9# happyReduction_47
happyReduction_47 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (RelOp LessThan happy_var_1 happy_var_3
	)}}

happyReduce_48 = happySpecReduce_3  9# happyReduction_48
happyReduction_48 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (RelOp GreaterThanEqual happy_var_1 happy_var_3
	)}}

happyReduce_49 = happySpecReduce_3  9# happyReduction_49
happyReduction_49 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (RelOp GreaterThan happy_var_1 happy_var_3
	)}}

happyReduce_50 = happySpecReduce_3  9# happyReduction_50
happyReduction_50 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (LogOp And happy_var_1 happy_var_3
	)}}

happyReduce_51 = happySpecReduce_3  9# happyReduction_51
happyReduction_51 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (LogOp Or happy_var_1 happy_var_3
	)}}

happyReduce_52 = happyReduce 4# 9# happyReduction_52
happyReduction_52 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { ((TokenId happy_var_1, _)) -> 
	case happyOut17 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (IdFun happy_var_1 (listToMany happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_53 = happyReduce 4# 9# happyReduction_53
happyReduction_53 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { ((TokenId happy_var_1, _)) -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (Id (Index happy_var_3) happy_var_1
	) `HappyStk` happyRest}}

happyReduce_54 = happySpecReduce_1  9# happyReduction_54
happyReduction_54 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((TokenId happy_var_1, _)) -> 
	happyIn13
		 (Id (NotArray) happy_var_1
	)}

happyReduce_55 = happySpecReduce_3  9# happyReduction_55
happyReduction_55 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_2 of { happy_var_2 -> 
	happyIn13
		 (Brack happy_var_2
	)}

happyReduce_56 = happySpecReduce_1  9# happyReduction_56
happyReduction_56 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((TokenInt happy_var_1, _)) -> 
	happyIn13
		 (LitInt happy_var_1
	)}

happyReduce_57 = happySpecReduce_1  9# happyReduction_57
happyReduction_57 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((TokenFloat happy_var_1, _)) -> 
	happyIn13
		 (LitFloat happy_var_1
	)}

happyReduce_58 = happySpecReduce_1  9# happyReduction_58
happyReduction_58 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((TokenDouble happy_var_1, _)) -> 
	happyIn13
		 (LitDouble happy_var_1
	)}

happyReduce_59 = happySpecReduce_1  9# happyReduction_59
happyReduction_59 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((TokenLong happy_var_1, _)) -> 
	happyIn13
		 (LitLong happy_var_1
	)}

happyReduce_60 = happySpecReduce_1  9# happyReduction_60
happyReduction_60 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((TokenChar happy_var_1, _)) -> 
	happyIn13
		 (LitChar happy_var_1
	)}

happyReduce_61 = happySpecReduce_1  9# happyReduction_61
happyReduction_61 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((TokenString happy_var_1, _)) -> 
	happyIn13
		 (LitString happy_var_1
	)}

happyReduce_62 = happySpecReduce_2  10# happyReduction_62
happyReduction_62 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_2 of { happy_var_2 -> 
	happyIn14
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_63 = happySpecReduce_0  10# happyReduction_63
happyReduction_63  =  happyIn14
		 ([]
	)

happyReduce_64 = happySpecReduce_1  11# happyReduction_64
happyReduction_64 happy_x_1
	 =  case happyOut12 happy_x_1 of { happy_var_1 -> 
	happyIn15
		 (Just happy_var_1
	)}

happyReduce_65 = happySpecReduce_0  11# happyReduction_65
happyReduction_65  =  happyIn15
		 (Nothing
	)

happyReduce_66 = happySpecReduce_1  12# happyReduction_66
happyReduction_66 happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (Just happy_var_1
	)}

happyReduce_67 = happySpecReduce_0  12# happyReduction_67
happyReduction_67  =  happyIn16
		 (Nothing
	)

happyReduce_68 = happySpecReduce_3  13# happyReduction_68
happyReduction_68 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut17 happy_x_3 of { happy_var_3 -> 
	happyIn17
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_69 = happySpecReduce_1  13# happyReduction_69
happyReduction_69 happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	happyIn17
		 ([happy_var_1]
	)}

happyReduce_70 = happySpecReduce_0  13# happyReduction_70
happyReduction_70  =  happyIn17
		 ([]
	)

happyReduce_71 = happyReduce 6# 14# happyReduction_71
happyReduction_71 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut7 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { ((TokenId happy_var_2, _)) -> 
	case happyOut18 happy_x_6 of { happy_var_6 -> 
	happyIn18
		 ((happy_var_2, (TypeArray happy_var_1)) : happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_72 = happyReduce 4# 14# happyReduction_72
happyReduction_72 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut7 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { ((TokenId happy_var_2, _)) -> 
	happyIn18
		 ([(happy_var_2, (TypeArray happy_var_1))]
	) `HappyStk` happyRest}}

happyReduce_73 = happyReduce 4# 14# happyReduction_73
happyReduction_73 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut7 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { ((TokenId happy_var_2, _)) -> 
	case happyOut18 happy_x_4 of { happy_var_4 -> 
	happyIn18
		 ((happy_var_2, happy_var_1) : happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_74 = happySpecReduce_2  14# happyReduction_74
happyReduction_74 happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { ((TokenId happy_var_2, _)) -> 
	happyIn18
		 ([(happy_var_2, happy_var_1)]
	)}}

happyReduce_75 = happyReduce 6# 15# happyReduction_75
happyReduction_75 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { ((TokenId happy_var_1, _)) -> 
	case happyOut8 happy_x_3 of { happy_var_3 -> 
	case happyOut19 happy_x_6 of { happy_var_6 -> 
	happyIn19
		 (DclParmDcl happy_var_1 happy_var_3 : happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_76 = happyReduce 4# 15# happyReduction_76
happyReduction_76 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { ((TokenId happy_var_1, _)) -> 
	case happyOut8 happy_x_3 of { happy_var_3 -> 
	happyIn19
		 ([DclParmDcl happy_var_1 happy_var_3]
	) `HappyStk` happyRest}}

happyReduce_77 = happySpecReduce_3  16# happyReduction_77
happyReduction_77 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn20
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_78 = happySpecReduce_1  16# happyReduction_78
happyReduction_78 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn20
		 ([happy_var_1]
	)}

happyReduce_79 = happyReduce 4# 17# happyReduction_79
happyReduction_79 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut7 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_2 of { happy_var_2 -> 
	case happyOut21 happy_x_4 of { happy_var_4 -> 
	happyIn21
		 ((happy_var_1, happy_var_2) : happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_80 = happySpecReduce_0  17# happyReduction_80
happyReduction_80  =  happyIn21
		 ([]
	)

happyNewToken action sts stk [] =
	happyDoAction 47# notHappyAtAll action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	(TokenPrintf, _) -> cont 1#;
	(TokenId happy_dollar_dollar, _) -> cont 2#;
	(TokenInt happy_dollar_dollar, _) -> cont 3#;
	(TokenFloat happy_dollar_dollar, _) -> cont 4#;
	(TokenDouble happy_dollar_dollar, _) -> cont 5#;
	(TokenLong happy_dollar_dollar, _) -> cont 6#;
	(TokenChar happy_dollar_dollar, _) -> cont 7#;
	(TokenString happy_dollar_dollar, _) -> cont 8#;
	(TokenBracket LeftSide Paren, _) -> cont 9#;
	(TokenBracket RightSide Paren, _) -> cont 10#;
	(TokenBracket LeftSide Brace, _) -> cont 11#;
	(TokenBracket RightSide Brace, _) -> cont 12#;
	(TokenBracket LeftSide Bracket, _) -> cont 13#;
	(TokenBracket RightSide Bracket, _) -> cont 14#;
	(TokenAssign, _) -> cont 15#;
	(TokenSemiColon, _) -> cont 16#;
	(TokenComma, _) -> cont 17#;
	(TokenUnaryOp BoolNegation, _) -> cont 18#;
	(TokenUnaryOp Increment, _) -> cont 19#;
	(TokenUnaryOp Decrement, _) -> cont 20#;
	(TokenBinOp Plus, _) -> cont 21#;
	(TokenBinOp Minus, _) -> cont 22#;
	(TokenBinOp Mul, _) -> cont 23#;
	(TokenBinOp Div, _) -> cont 24#;
	(TokenRelOp Equal, _) -> cont 25#;
	(TokenRelOp NotEqual, _) -> cont 26#;
	(TokenRelOp LessThanEqual, _) -> cont 27#;
	(TokenRelOp LessThan, _) -> cont 28#;
	(TokenRelOp GreaterThanEqual, _) -> cont 29#;
	(TokenRelOp GreaterThan, _) -> cont 30#;
	(TokenLogicalOp And, _) -> cont 31#;
	(TokenLogicalOp Or, _) -> cont 32#;
	(TokenReserved TokenIf, _) -> cont 33#;
	(TokenReserved TokenElse, _) -> cont 34#;
	(TokenReserved TokenWhile, _) -> cont 35#;
	(TokenReserved TokenFor, _) -> cont 36#;
	(TokenReserved TokenReturn, _) -> cont 37#;
	(TokenReserved TokenExtern, _) -> cont 38#;
	(TokenType TTypeChar, _) -> cont 39#;
	(TokenType TTypeInt, _) -> cont 40#;
	(TokenType TTypeFloat, _) -> cont 41#;
	(TokenType TTypeDouble, _) -> cont 42#;
	(TokenType TTypeLong, _) -> cont 43#;
	(TokenType TTypeVoid, _) -> cont 44#;
	(TokenComment happy_dollar_dollar, _) -> cont 45#;
	(TokenMultiLineComment happy_dollar_dollar, _) -> cont 46#;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 47# tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Either Lexer.TokenPos a -> (a -> Either Lexer.TokenPos b) -> Either Lexer.TokenPos b
happyThen = (>>=)
happyReturn :: () => a -> Either Lexer.TokenPos a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Either Lexer.TokenPos a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Lexer.TokenPos)], [String]) -> Either Lexer.TokenPos a
happyError' = (\(tokens, _) -> parseError tokens)
parseTokens tks = happySomeParser where
 happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut4 x))

happySeq = happyDontSeq


-- | Convert a list to a `Many`, which is either `Empty` or a `NonEmpty a`.
listToMany :: [a] -> Many a
listToMany [] = Empty
listToMany as = Many (NonE.fromList as)

-- | Construct the `FunctionVarDeclaration`. Note that we rely on
-- `some_var_decl` to never be an empty list!
funVarToMany :: [(Type, [VarDeclaration])] -> FunVarDcl
funVarToMany []      = FunVarDcl Empty
funVarToMany as      = FunVarDcl $ Many $ NonE.fromList $ sndToSome as
  where
    sndToSome :: [(Type, [VarDeclaration])] -> [FunVarTypeDcl]
    sndToSome [] = []
    sndToSome ((t, vs):vds) = FunVarTypeDcl t (NonE.fromList vs) : sndToSome vds

-- | Express that we encountered a parser error.
parseError :: [Lexer.TokenPos] -> Either Lexer.TokenPos a
parseError [] = error "Parser ended in error!"
parseError (t : ts) = Left t
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 19 "<built-in>" #-}
{-# LINE 1 "/Users/tehnix/.stack/programs/x86_64-osx/ghc-8.0.2/lib/ghc-8.0.2/include/ghcversion.h" #-}


















{-# LINE 20 "<built-in>" #-}
{-# LINE 1 "/var/folders/7w/pg1bypcn3c9_lb_4gtp8swhm0000gn/T/ghc13837_0/ghc_2.h" #-}























































































































































{-# LINE 21 "<built-in>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 













-- Do not remove this comment. Required to fix CPP parsing when using GCC and a clang-compiled alex.
#if __GLASGOW_HASKELL__ > 706
#define LT(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.<# m)) :: Bool)
#define GTE(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.>=# m)) :: Bool)
#define EQ(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.==# m)) :: Bool)
#else
#define LT(n,m) (n Happy_GHC_Exts.<# m)
#define GTE(n,m) (n Happy_GHC_Exts.>=# m)
#define EQ(n,m) (n Happy_GHC_Exts.==# m)
#endif

{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Happy_GHC_Exts.Int# Happy_IntList








{-# LINE 65 "templates/GenericTemplate.hs" #-}


{-# LINE 75 "templates/GenericTemplate.hs" #-}










infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is 0#, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept 0# tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
        (happyTcHack j (happyTcHack st)) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action



happyDoAction i tk st
        = {- nothing -}
          

          case action of
                0#           -> {- nothing -}
                                     happyFail (happyExpListPerState ((Happy_GHC_Exts.I# (st)) :: Int)) i tk st
                -1#          -> {- nothing -}
                                     happyAccept i tk st
                n | LT(n,(0# :: Happy_GHC_Exts.Int#)) -> {- nothing -}
                                                   
                                                   (happyReduceArr Happy_Data_Array.! rule) i tk st
                                                   where rule = (Happy_GHC_Exts.I# ((Happy_GHC_Exts.negateInt# ((n Happy_GHC_Exts.+# (1# :: Happy_GHC_Exts.Int#))))))
                n                 -> {- nothing -}
                                     

                                     happyShift new_state i tk st
                                     where new_state = (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#))
   where off    = happyAdjustOffset (indexShortOffAddr happyActOffsets st)
         off_i  = (off Happy_GHC_Exts.+#  i)
         check  = if GTE(off_i,(0# :: Happy_GHC_Exts.Int#))
                  then EQ(indexShortOffAddr happyCheck off_i, i)
                  else False
         action
          | check     = indexShortOffAddr happyTable off_i
          | otherwise = indexShortOffAddr happyDefActions st




indexShortOffAddr (HappyA# arr) off =
        Happy_GHC_Exts.narrow16Int# i
  where
        i = Happy_GHC_Exts.word2Int# (Happy_GHC_Exts.or# (Happy_GHC_Exts.uncheckedShiftL# high 8#) low)
        high = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr (off' Happy_GHC_Exts.+# 1#)))
        low  = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr off'))
        off' = off Happy_GHC_Exts.*# 2#




{-# INLINE happyLt #-}
happyLt x y = LT(x,y)


readArrayBit arr bit =
    Bits.testBit (Happy_GHC_Exts.I# (indexShortOffAddr arr ((unbox_int bit) `Happy_GHC_Exts.iShiftRA#` 4#))) (bit `mod` 16)
  where unbox_int (Happy_GHC_Exts.I# x) = x






data HappyAddr = HappyA# Happy_GHC_Exts.Addr#


-----------------------------------------------------------------------------
-- HappyState data type (not arrays)


{-# LINE 180 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state 0# tk st sts stk@(x `HappyStk` _) =
     let i = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--     trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons (st) (sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons (st) (sts)) ((happyInTok (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_0 nt fn j tk st@((action)) sts stk
     = happyGoto nt j tk st (HappyCons (st) (sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@((HappyCons (st@(action)) (_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_2 nt fn j tk _ (HappyCons (_) (sts@((HappyCons (st@(action)) (_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_3 nt fn j tk _ (HappyCons (_) ((HappyCons (_) (sts@((HappyCons (st@(action)) (_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) sts of
         sts1@((HappyCons (st1@(action)) (_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
         let drop_stk = happyDropStk k stk

             off = happyAdjustOffset (indexShortOffAddr happyGotoOffsets st1)
             off_i = (off Happy_GHC_Exts.+#  nt)
             new_state = indexShortOffAddr happyTable off_i




          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop 0# l = l
happyDrop n (HappyCons (_) (t)) = happyDrop (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) t

happyDropStk 0# l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Happy_GHC_Exts.-# (1#::Happy_GHC_Exts.Int#)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction


happyGoto nt j tk st = 
   {- nothing -}
   happyDoAction j tk new_state
   where off = happyAdjustOffset (indexShortOffAddr happyGotoOffsets st)
         off_i = (off Happy_GHC_Exts.+#  nt)
         new_state = indexShortOffAddr happyTable off_i




-----------------------------------------------------------------------------
-- Error recovery (0# is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist 0# tk old_st _ stk@(x `HappyStk` _) =
     let i = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  0# tk old_st (HappyCons ((action)) (sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        happyDoAction 0# tk action sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (action) sts stk =
--      trace "entering error recovery" $
        happyDoAction 0# tk action sts ( (Happy_GHC_Exts.unsafeCoerce# (Happy_GHC_Exts.I# (i))) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions


happyTcHack :: Happy_GHC_Exts.Int# -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}


-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.


{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.


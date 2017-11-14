{-# OPTIONS_GHC -w #-}
module Parser.Parser (parse) where
import Parser.Syntax
import Parser.Token
import Parser.Literal
import Parser.Common
import qualified Data.List.NonEmpty as NonE
import Data.List.NonEmpty (NonEmpty(..))
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.8

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Prog)
	| HappyAbsSyn5 (Declaration)
	| HappyAbsSyn6 (VarDeclaration)
	| HappyAbsSyn7 (Type)
	| HappyAbsSyn8 (ParmTypes)
	| HappyAbsSyn9 (Function)
	| HappyAbsSyn10 (Stmt)
	| HappyAbsSyn12 (Assignment)
	| HappyAbsSyn13 (Expr)
	| HappyAbsSyn14 ([Stmt])
	| HappyAbsSyn15 (Maybe Assignment)
	| HappyAbsSyn16 (Maybe Expr)
	| HappyAbsSyn17 ([Expr])
	| HappyAbsSyn18 ([ParmType])
	| HappyAbsSyn19 ([(Identifier, ParmTypes)])
	| HappyAbsSyn20 ([VarDeclaration])
	| HappyAbsSyn21 ([(Type, [VarDeclaration])])

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128,
 action_129,
 action_130,
 action_131,
 action_132,
 action_133,
 action_134,
 action_135,
 action_136,
 action_137,
 action_138,
 action_139,
 action_140,
 action_141,
 action_142,
 action_143,
 action_144,
 action_145,
 action_146,
 action_147,
 action_148,
 action_149,
 action_150,
 action_151,
 action_152,
 action_153 :: () => Int -> ({-HappyReduction (HappyIdentity) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (HappyIdentity) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (HappyIdentity) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (HappyIdentity) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66 :: () => ({-HappyReduction (HappyIdentity) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (HappyIdentity) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (HappyIdentity) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (HappyIdentity) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,346) ([0,0,0,240,0,0,57344,1,0,4,0,0,1,0,0,0,0,3584,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,64,0,0,0,0,49152,3,256,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,512,0,0,0,4,0,0,128,0,0,0,1,0,0,0,0,3840,0,0,0,0,0,0,0,0,0,0,0,0,0,57344,0,0,0,448,0,0,32768,3,256,0,0,0,64,0,0,0,0,0,0,0,0,0,0,2,0,0,1024,0,0,0,1024,0,0,8192,8,0,0,4160,0,0,0,34,0,0,2048,0,0,0,0,6144,0,0,0,48,8192,0,0,0,0,0,192,32768,0,0,0,16640,8,116,0,0,0,0,1024,33,464,0,0,0,0,0,256,0,0,0,0,96,16384,528,7424,0,0,0,0,0,128,0,0,8192,0,0,0,8452,53248,1,0,0,0,0,256,0,0,0,2,0,0,1024,0,0,32768,20495,0,0,32768,0,0,0,8192,0,0,0,32,0,0,2048,0,0,8192,0,0,0,0,0,96,16384,0,0,0,0,0,0,0,49152,1023,0,0,16,0,0,1088,0,0,0,0,0,0,0,0,0,0,0,0,0,1984,40,0,32768,20495,0,0,7936,160,0,0,2,0,0,31744,640,0,0,248,5,0,0,8,0,0,992,20,0,0,0,0,0,0,0,0,0,0,0,0,0,65440,7,0,128,0,0,0,0,0,0,512,16380,0,0,63492,127,0,0,0,0,0,1024,0,0,0,5,0,0,0,0,0,0,0,0,0,256,8190,0,61440,2561,0,0,992,20,0,0,0,0,0,3968,80,0,0,40991,0,0,15872,320,0,0,32892,2,0,63488,1280,0,0,496,10,0,57344,5123,0,0,1984,40,0,32768,20495,0,0,7936,160,0,0,16446,1,0,31744,640,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,65504,0,0,49152,255,0,0,1920,0,0,0,15,0,0,7680,0,0,0,60,0,0,30720,30,0,0,15600,0,0,0,0,0,0,0,0,0,0,6,0,0,3072,0,0,4096,8190,0,0,2,0,0,0,0,0,49152,10247,0,0,3968,80,0,0,40991,0,0,33280,16,128,0,8452,0,1,0,64,0,0,496,10,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,4096,0,0,0,65280,15,0,4096,8190,0,0,0,0,0,0,0,0,0,256,0,0,128,0,0,0,2113,16384,0,0,0,0,0,128,0,0,63488,1280,0,0,0,16380,0,8192,264,2048,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","prog","dcl","var_decl","type","parm_types","func","stmt","stmt_block","assg","expr","many_stmt","maybe_assg","maybe_expr","many_expr","some_parm_type","some_id_parm_types","some_var_decl","many_fun_var_decl","id","intcon","charcon","stringcon","'('","')'","'{'","'}'","'['","']'","'='","';'","','","'!'","'+'","'-'","'*'","'/'","'=='","'!='","'<='","'<'","'>='","'>'","'&&'","'||'","'if'","'else'","'while'","'for'","'return'","'extern'","'char'","'int'","'void'","%eof"]
        bit_start = st * 57
        bit_end = (st + 1) * 57
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..56]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (53) = happyShift action_4
action_0 (54) = happyShift action_5
action_0 (55) = happyShift action_6
action_0 (56) = happyShift action_11
action_0 (4) = happyGoto action_8
action_0 (5) = happyGoto action_2
action_0 (7) = happyGoto action_9
action_0 (9) = happyGoto action_10
action_0 _ = happyReduce_3

action_1 (53) = happyShift action_4
action_1 (54) = happyShift action_5
action_1 (55) = happyShift action_6
action_1 (56) = happyShift action_7
action_1 (5) = happyGoto action_2
action_1 (7) = happyGoto action_3
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (33) = happyShift action_20
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (22) = happyShift action_17
action_3 (19) = happyGoto action_15
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (54) = happyShift action_5
action_4 (55) = happyShift action_6
action_4 (56) = happyShift action_19
action_4 (7) = happyGoto action_18
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_10

action_6 _ = happyReduce_11

action_7 (22) = happyShift action_17
action_7 (19) = happyGoto action_12
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (57) = happyAccept
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (22) = happyShift action_16
action_9 (19) = happyGoto action_15
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (53) = happyShift action_4
action_10 (54) = happyShift action_5
action_10 (55) = happyShift action_6
action_10 (56) = happyShift action_11
action_10 (4) = happyGoto action_14
action_10 (5) = happyGoto action_2
action_10 (7) = happyGoto action_9
action_10 (9) = happyGoto action_10
action_10 _ = happyReduce_3

action_11 (22) = happyShift action_13
action_11 (19) = happyGoto action_12
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_7

action_13 (26) = happyShift action_26
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_2

action_15 _ = happyReduce_6

action_16 (26) = happyShift action_25
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (26) = happyShift action_24
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (22) = happyShift action_17
action_18 (19) = happyGoto action_23
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (22) = happyShift action_17
action_19 (19) = happyGoto action_22
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (53) = happyShift action_4
action_20 (54) = happyShift action_5
action_20 (55) = happyShift action_6
action_20 (56) = happyShift action_11
action_20 (4) = happyGoto action_21
action_20 (5) = happyGoto action_2
action_20 (7) = happyGoto action_9
action_20 (9) = happyGoto action_10
action_20 _ = happyReduce_3

action_21 _ = happyReduce_1

action_22 _ = happyReduce_5

action_23 _ = happyReduce_4

action_24 (54) = happyShift action_5
action_24 (55) = happyShift action_6
action_24 (56) = happyShift action_30
action_24 (7) = happyGoto action_27
action_24 (8) = happyGoto action_32
action_24 (18) = happyGoto action_29
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (54) = happyShift action_5
action_25 (55) = happyShift action_6
action_25 (56) = happyShift action_30
action_25 (7) = happyGoto action_27
action_25 (8) = happyGoto action_31
action_25 (18) = happyGoto action_29
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (54) = happyShift action_5
action_26 (55) = happyShift action_6
action_26 (56) = happyShift action_30
action_26 (7) = happyGoto action_27
action_26 (8) = happyGoto action_28
action_26 (18) = happyGoto action_29
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (22) = happyShift action_36
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (27) = happyShift action_35
action_28 _ = happyFail (happyExpListPerState 28)

action_29 _ = happyReduce_13

action_30 _ = happyReduce_12

action_31 (27) = happyShift action_34
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (27) = happyShift action_33
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (34) = happyShift action_40
action_33 _ = happyReduce_62

action_34 (28) = happyShift action_41
action_34 (34) = happyShift action_40
action_34 _ = happyReduce_62

action_35 (28) = happyShift action_39
action_35 (34) = happyShift action_40
action_35 _ = happyReduce_62

action_36 (30) = happyShift action_37
action_36 (34) = happyShift action_38
action_36 _ = happyReduce_60

action_37 (31) = happyShift action_47
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (54) = happyShift action_5
action_38 (55) = happyShift action_6
action_38 (7) = happyGoto action_27
action_38 (18) = happyGoto action_46
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (54) = happyShift action_5
action_39 (55) = happyShift action_6
action_39 (7) = happyGoto action_42
action_39 (21) = happyGoto action_45
action_39 _ = happyReduce_66

action_40 (22) = happyShift action_17
action_40 (19) = happyGoto action_44
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (54) = happyShift action_5
action_41 (55) = happyShift action_6
action_41 (7) = happyGoto action_42
action_41 (21) = happyGoto action_43
action_41 _ = happyReduce_66

action_42 (22) = happyShift action_62
action_42 (6) = happyGoto action_60
action_42 (20) = happyGoto action_61
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (22) = happyShift action_52
action_43 (28) = happyShift action_53
action_43 (33) = happyShift action_54
action_43 (48) = happyShift action_55
action_43 (50) = happyShift action_56
action_43 (51) = happyShift action_57
action_43 (52) = happyShift action_58
action_43 (10) = happyGoto action_49
action_43 (11) = happyGoto action_50
action_43 (14) = happyGoto action_59
action_43 _ = happyReduce_49

action_44 _ = happyReduce_61

action_45 (22) = happyShift action_52
action_45 (28) = happyShift action_53
action_45 (33) = happyShift action_54
action_45 (48) = happyShift action_55
action_45 (50) = happyShift action_56
action_45 (51) = happyShift action_57
action_45 (52) = happyShift action_58
action_45 (10) = happyGoto action_49
action_45 (11) = happyGoto action_50
action_45 (14) = happyGoto action_51
action_45 _ = happyReduce_49

action_46 _ = happyReduce_59

action_47 (34) = happyShift action_48
action_47 _ = happyReduce_58

action_48 (54) = happyShift action_5
action_48 (55) = happyShift action_6
action_48 (7) = happyGoto action_27
action_48 (18) = happyGoto action_83
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (22) = happyShift action_52
action_49 (28) = happyShift action_53
action_49 (33) = happyShift action_54
action_49 (48) = happyShift action_55
action_49 (50) = happyShift action_56
action_49 (51) = happyShift action_57
action_49 (52) = happyShift action_58
action_49 (10) = happyGoto action_49
action_49 (11) = happyGoto action_50
action_49 (14) = happyGoto action_82
action_49 _ = happyReduce_49

action_50 _ = happyReduce_20

action_51 (29) = happyShift action_81
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (26) = happyShift action_80
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (22) = happyShift action_52
action_53 (28) = happyShift action_53
action_53 (33) = happyShift action_54
action_53 (48) = happyShift action_55
action_53 (50) = happyShift action_56
action_53 (51) = happyShift action_57
action_53 (52) = happyShift action_58
action_53 (10) = happyGoto action_49
action_53 (11) = happyGoto action_50
action_53 (14) = happyGoto action_79
action_53 _ = happyReduce_49

action_54 _ = happyReduce_24

action_55 (26) = happyShift action_78
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (26) = happyShift action_77
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (26) = happyShift action_76
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (22) = happyShift action_69
action_58 (23) = happyShift action_70
action_58 (24) = happyShift action_71
action_58 (25) = happyShift action_72
action_58 (26) = happyShift action_73
action_58 (35) = happyShift action_74
action_58 (37) = happyShift action_75
action_58 (13) = happyGoto action_67
action_58 (16) = happyGoto action_68
action_58 _ = happyReduce_53

action_59 (29) = happyShift action_66
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (34) = happyShift action_65
action_60 _ = happyReduce_64

action_61 (33) = happyShift action_64
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (30) = happyShift action_63
action_62 _ = happyReduce_9

action_63 (23) = happyShift action_112
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (54) = happyShift action_5
action_64 (55) = happyShift action_6
action_64 (7) = happyGoto action_42
action_64 (21) = happyGoto action_111
action_64 _ = happyReduce_66

action_65 (22) = happyShift action_62
action_65 (6) = happyGoto action_60
action_65 (20) = happyGoto action_110
action_65 _ = happyFail (happyExpListPerState 65)

action_66 _ = happyReduce_14

action_67 (36) = happyShift action_98
action_67 (37) = happyShift action_99
action_67 (38) = happyShift action_100
action_67 (39) = happyShift action_101
action_67 (40) = happyShift action_102
action_67 (41) = happyShift action_103
action_67 (42) = happyShift action_104
action_67 (43) = happyShift action_105
action_67 (44) = happyShift action_106
action_67 (45) = happyShift action_107
action_67 (46) = happyShift action_108
action_67 (47) = happyShift action_109
action_67 _ = happyReduce_52

action_68 (33) = happyShift action_97
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (26) = happyShift action_95
action_69 (30) = happyShift action_96
action_69 _ = happyReduce_43

action_70 _ = happyReduce_45

action_71 _ = happyReduce_46

action_72 _ = happyReduce_47

action_73 (22) = happyShift action_69
action_73 (23) = happyShift action_70
action_73 (24) = happyShift action_71
action_73 (25) = happyShift action_72
action_73 (26) = happyShift action_73
action_73 (35) = happyShift action_74
action_73 (37) = happyShift action_75
action_73 (13) = happyGoto action_94
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (22) = happyShift action_69
action_74 (23) = happyShift action_70
action_74 (24) = happyShift action_71
action_74 (25) = happyShift action_72
action_74 (26) = happyShift action_73
action_74 (35) = happyShift action_74
action_74 (37) = happyShift action_75
action_74 (13) = happyGoto action_93
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (22) = happyShift action_69
action_75 (23) = happyShift action_70
action_75 (24) = happyShift action_71
action_75 (25) = happyShift action_72
action_75 (26) = happyShift action_73
action_75 (35) = happyShift action_74
action_75 (37) = happyShift action_75
action_75 (13) = happyGoto action_92
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (22) = happyShift action_91
action_76 (12) = happyGoto action_89
action_76 (15) = happyGoto action_90
action_76 _ = happyReduce_51

action_77 (22) = happyShift action_69
action_77 (23) = happyShift action_70
action_77 (24) = happyShift action_71
action_77 (25) = happyShift action_72
action_77 (26) = happyShift action_73
action_77 (35) = happyShift action_74
action_77 (37) = happyShift action_75
action_77 (13) = happyGoto action_88
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (22) = happyShift action_69
action_78 (23) = happyShift action_70
action_78 (24) = happyShift action_71
action_78 (25) = happyShift action_72
action_78 (26) = happyShift action_73
action_78 (35) = happyShift action_74
action_78 (37) = happyShift action_75
action_78 (13) = happyGoto action_87
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (29) = happyShift action_86
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (22) = happyShift action_69
action_80 (23) = happyShift action_70
action_80 (24) = happyShift action_71
action_80 (25) = happyShift action_72
action_80 (26) = happyShift action_73
action_80 (35) = happyShift action_74
action_80 (37) = happyShift action_75
action_80 (13) = happyGoto action_84
action_80 (17) = happyGoto action_85
action_80 _ = happyReduce_56

action_81 _ = happyReduce_15

action_82 _ = happyReduce_48

action_83 _ = happyReduce_57

action_84 (34) = happyShift action_135
action_84 (36) = happyShift action_98
action_84 (37) = happyShift action_99
action_84 (38) = happyShift action_100
action_84 (39) = happyShift action_101
action_84 (40) = happyShift action_102
action_84 (41) = happyShift action_103
action_84 (42) = happyShift action_104
action_84 (43) = happyShift action_105
action_84 (44) = happyShift action_106
action_84 (45) = happyShift action_107
action_84 (46) = happyShift action_108
action_84 (47) = happyShift action_109
action_84 _ = happyReduce_55

action_85 (27) = happyShift action_134
action_85 _ = happyFail (happyExpListPerState 85)

action_86 _ = happyReduce_21

action_87 (27) = happyShift action_133
action_87 (36) = happyShift action_98
action_87 (37) = happyShift action_99
action_87 (38) = happyShift action_100
action_87 (39) = happyShift action_101
action_87 (40) = happyShift action_102
action_87 (41) = happyShift action_103
action_87 (42) = happyShift action_104
action_87 (43) = happyShift action_105
action_87 (44) = happyShift action_106
action_87 (45) = happyShift action_107
action_87 (46) = happyShift action_108
action_87 (47) = happyShift action_109
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (27) = happyShift action_132
action_88 (36) = happyShift action_98
action_88 (37) = happyShift action_99
action_88 (38) = happyShift action_100
action_88 (39) = happyShift action_101
action_88 (40) = happyShift action_102
action_88 (41) = happyShift action_103
action_88 (42) = happyShift action_104
action_88 (43) = happyShift action_105
action_88 (44) = happyShift action_106
action_88 (45) = happyShift action_107
action_88 (46) = happyShift action_108
action_88 (47) = happyShift action_109
action_88 _ = happyFail (happyExpListPerState 88)

action_89 _ = happyReduce_50

action_90 (33) = happyShift action_131
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (30) = happyShift action_129
action_91 (32) = happyShift action_130
action_91 _ = happyFail (happyExpListPerState 91)

action_92 _ = happyReduce_27

action_93 _ = happyReduce_28

action_94 (27) = happyShift action_128
action_94 (36) = happyShift action_98
action_94 (37) = happyShift action_99
action_94 (38) = happyShift action_100
action_94 (39) = happyShift action_101
action_94 (40) = happyShift action_102
action_94 (41) = happyShift action_103
action_94 (42) = happyShift action_104
action_94 (43) = happyShift action_105
action_94 (44) = happyShift action_106
action_94 (45) = happyShift action_107
action_94 (46) = happyShift action_108
action_94 (47) = happyShift action_109
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (22) = happyShift action_69
action_95 (23) = happyShift action_70
action_95 (24) = happyShift action_71
action_95 (25) = happyShift action_72
action_95 (26) = happyShift action_73
action_95 (35) = happyShift action_74
action_95 (37) = happyShift action_75
action_95 (13) = happyGoto action_84
action_95 (17) = happyGoto action_127
action_95 _ = happyReduce_56

action_96 (22) = happyShift action_69
action_96 (23) = happyShift action_70
action_96 (24) = happyShift action_71
action_96 (25) = happyShift action_72
action_96 (26) = happyShift action_73
action_96 (35) = happyShift action_74
action_96 (37) = happyShift action_75
action_96 (13) = happyGoto action_126
action_96 _ = happyFail (happyExpListPerState 96)

action_97 _ = happyReduce_22

action_98 (22) = happyShift action_69
action_98 (23) = happyShift action_70
action_98 (24) = happyShift action_71
action_98 (25) = happyShift action_72
action_98 (26) = happyShift action_73
action_98 (35) = happyShift action_74
action_98 (37) = happyShift action_75
action_98 (13) = happyGoto action_125
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (22) = happyShift action_69
action_99 (23) = happyShift action_70
action_99 (24) = happyShift action_71
action_99 (25) = happyShift action_72
action_99 (26) = happyShift action_73
action_99 (35) = happyShift action_74
action_99 (37) = happyShift action_75
action_99 (13) = happyGoto action_124
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (22) = happyShift action_69
action_100 (23) = happyShift action_70
action_100 (24) = happyShift action_71
action_100 (25) = happyShift action_72
action_100 (26) = happyShift action_73
action_100 (35) = happyShift action_74
action_100 (37) = happyShift action_75
action_100 (13) = happyGoto action_123
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (22) = happyShift action_69
action_101 (23) = happyShift action_70
action_101 (24) = happyShift action_71
action_101 (25) = happyShift action_72
action_101 (26) = happyShift action_73
action_101 (35) = happyShift action_74
action_101 (37) = happyShift action_75
action_101 (13) = happyGoto action_122
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (22) = happyShift action_69
action_102 (23) = happyShift action_70
action_102 (24) = happyShift action_71
action_102 (25) = happyShift action_72
action_102 (26) = happyShift action_73
action_102 (35) = happyShift action_74
action_102 (37) = happyShift action_75
action_102 (13) = happyGoto action_121
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (22) = happyShift action_69
action_103 (23) = happyShift action_70
action_103 (24) = happyShift action_71
action_103 (25) = happyShift action_72
action_103 (26) = happyShift action_73
action_103 (35) = happyShift action_74
action_103 (37) = happyShift action_75
action_103 (13) = happyGoto action_120
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (22) = happyShift action_69
action_104 (23) = happyShift action_70
action_104 (24) = happyShift action_71
action_104 (25) = happyShift action_72
action_104 (26) = happyShift action_73
action_104 (35) = happyShift action_74
action_104 (37) = happyShift action_75
action_104 (13) = happyGoto action_119
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (22) = happyShift action_69
action_105 (23) = happyShift action_70
action_105 (24) = happyShift action_71
action_105 (25) = happyShift action_72
action_105 (26) = happyShift action_73
action_105 (35) = happyShift action_74
action_105 (37) = happyShift action_75
action_105 (13) = happyGoto action_118
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (22) = happyShift action_69
action_106 (23) = happyShift action_70
action_106 (24) = happyShift action_71
action_106 (25) = happyShift action_72
action_106 (26) = happyShift action_73
action_106 (35) = happyShift action_74
action_106 (37) = happyShift action_75
action_106 (13) = happyGoto action_117
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (22) = happyShift action_69
action_107 (23) = happyShift action_70
action_107 (24) = happyShift action_71
action_107 (25) = happyShift action_72
action_107 (26) = happyShift action_73
action_107 (35) = happyShift action_74
action_107 (37) = happyShift action_75
action_107 (13) = happyGoto action_116
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (22) = happyShift action_69
action_108 (23) = happyShift action_70
action_108 (24) = happyShift action_71
action_108 (25) = happyShift action_72
action_108 (26) = happyShift action_73
action_108 (35) = happyShift action_74
action_108 (37) = happyShift action_75
action_108 (13) = happyGoto action_115
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (22) = happyShift action_69
action_109 (23) = happyShift action_70
action_109 (24) = happyShift action_71
action_109 (25) = happyShift action_72
action_109 (26) = happyShift action_73
action_109 (35) = happyShift action_74
action_109 (37) = happyShift action_75
action_109 (13) = happyGoto action_114
action_109 _ = happyFail (happyExpListPerState 109)

action_110 _ = happyReduce_63

action_111 _ = happyReduce_65

action_112 (31) = happyShift action_113
action_112 _ = happyFail (happyExpListPerState 112)

action_113 _ = happyReduce_8

action_114 (36) = happyShift action_98
action_114 (37) = happyShift action_99
action_114 (38) = happyShift action_100
action_114 (39) = happyShift action_101
action_114 (40) = happyShift action_102
action_114 (41) = happyShift action_103
action_114 (42) = happyShift action_104
action_114 (43) = happyShift action_105
action_114 (44) = happyShift action_106
action_114 (45) = happyShift action_107
action_114 (46) = happyShift action_108
action_114 _ = happyReduce_40

action_115 (36) = happyShift action_98
action_115 (37) = happyShift action_99
action_115 (38) = happyShift action_100
action_115 (39) = happyShift action_101
action_115 (40) = happyShift action_102
action_115 (41) = happyShift action_103
action_115 (42) = happyShift action_104
action_115 (43) = happyShift action_105
action_115 (44) = happyShift action_106
action_115 (45) = happyShift action_107
action_115 _ = happyReduce_39

action_116 (36) = happyShift action_98
action_116 (37) = happyShift action_99
action_116 (38) = happyShift action_100
action_116 (39) = happyShift action_101
action_116 _ = happyReduce_38

action_117 (36) = happyShift action_98
action_117 (37) = happyShift action_99
action_117 (38) = happyShift action_100
action_117 (39) = happyShift action_101
action_117 _ = happyReduce_37

action_118 (36) = happyShift action_98
action_118 (37) = happyShift action_99
action_118 (38) = happyShift action_100
action_118 (39) = happyShift action_101
action_118 _ = happyReduce_36

action_119 (36) = happyShift action_98
action_119 (37) = happyShift action_99
action_119 (38) = happyShift action_100
action_119 (39) = happyShift action_101
action_119 _ = happyReduce_35

action_120 (36) = happyShift action_98
action_120 (37) = happyShift action_99
action_120 (38) = happyShift action_100
action_120 (39) = happyShift action_101
action_120 (42) = happyShift action_104
action_120 (43) = happyShift action_105
action_120 (44) = happyShift action_106
action_120 (45) = happyShift action_107
action_120 _ = happyReduce_34

action_121 (36) = happyShift action_98
action_121 (37) = happyShift action_99
action_121 (38) = happyShift action_100
action_121 (39) = happyShift action_101
action_121 (42) = happyShift action_104
action_121 (43) = happyShift action_105
action_121 (44) = happyShift action_106
action_121 (45) = happyShift action_107
action_121 _ = happyReduce_33

action_122 _ = happyReduce_32

action_123 _ = happyReduce_31

action_124 (38) = happyShift action_100
action_124 (39) = happyShift action_101
action_124 _ = happyReduce_30

action_125 (38) = happyShift action_100
action_125 (39) = happyShift action_101
action_125 _ = happyReduce_29

action_126 (31) = happyShift action_144
action_126 (36) = happyShift action_98
action_126 (37) = happyShift action_99
action_126 (38) = happyShift action_100
action_126 (39) = happyShift action_101
action_126 (40) = happyShift action_102
action_126 (41) = happyShift action_103
action_126 (42) = happyShift action_104
action_126 (43) = happyShift action_105
action_126 (44) = happyShift action_106
action_126 (45) = happyShift action_107
action_126 (46) = happyShift action_108
action_126 (47) = happyShift action_109
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (27) = happyShift action_143
action_127 _ = happyFail (happyExpListPerState 127)

action_128 _ = happyReduce_44

action_129 (22) = happyShift action_69
action_129 (23) = happyShift action_70
action_129 (24) = happyShift action_71
action_129 (25) = happyShift action_72
action_129 (26) = happyShift action_73
action_129 (35) = happyShift action_74
action_129 (37) = happyShift action_75
action_129 (13) = happyGoto action_142
action_129 _ = happyFail (happyExpListPerState 129)

action_130 (22) = happyShift action_69
action_130 (23) = happyShift action_70
action_130 (24) = happyShift action_71
action_130 (25) = happyShift action_72
action_130 (26) = happyShift action_73
action_130 (35) = happyShift action_74
action_130 (37) = happyShift action_75
action_130 (13) = happyGoto action_141
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (22) = happyShift action_69
action_131 (23) = happyShift action_70
action_131 (24) = happyShift action_71
action_131 (25) = happyShift action_72
action_131 (26) = happyShift action_73
action_131 (35) = happyShift action_74
action_131 (37) = happyShift action_75
action_131 (13) = happyGoto action_67
action_131 (16) = happyGoto action_140
action_131 _ = happyReduce_53

action_132 (22) = happyShift action_52
action_132 (28) = happyShift action_53
action_132 (33) = happyShift action_54
action_132 (52) = happyShift action_58
action_132 (11) = happyGoto action_139
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (22) = happyShift action_52
action_133 (28) = happyShift action_53
action_133 (33) = happyShift action_54
action_133 (52) = happyShift action_58
action_133 (11) = happyGoto action_138
action_133 _ = happyFail (happyExpListPerState 133)

action_134 (33) = happyShift action_137
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (22) = happyShift action_69
action_135 (23) = happyShift action_70
action_135 (24) = happyShift action_71
action_135 (25) = happyShift action_72
action_135 (26) = happyShift action_73
action_135 (35) = happyShift action_74
action_135 (37) = happyShift action_75
action_135 (13) = happyGoto action_84
action_135 (17) = happyGoto action_136
action_135 _ = happyReduce_56

action_136 _ = happyReduce_54

action_137 _ = happyReduce_23

action_138 (49) = happyShift action_147
action_138 _ = happyReduce_16

action_139 _ = happyReduce_18

action_140 (33) = happyShift action_146
action_140 _ = happyFail (happyExpListPerState 140)

action_141 (36) = happyShift action_98
action_141 (37) = happyShift action_99
action_141 (38) = happyShift action_100
action_141 (39) = happyShift action_101
action_141 (40) = happyShift action_102
action_141 (41) = happyShift action_103
action_141 (42) = happyShift action_104
action_141 (43) = happyShift action_105
action_141 (44) = happyShift action_106
action_141 (45) = happyShift action_107
action_141 (46) = happyShift action_108
action_141 (47) = happyShift action_109
action_141 _ = happyReduce_26

action_142 (31) = happyShift action_145
action_142 (36) = happyShift action_98
action_142 (37) = happyShift action_99
action_142 (38) = happyShift action_100
action_142 (39) = happyShift action_101
action_142 (40) = happyShift action_102
action_142 (41) = happyShift action_103
action_142 (42) = happyShift action_104
action_142 (43) = happyShift action_105
action_142 (44) = happyShift action_106
action_142 (45) = happyShift action_107
action_142 (46) = happyShift action_108
action_142 (47) = happyShift action_109
action_142 _ = happyFail (happyExpListPerState 142)

action_143 _ = happyReduce_41

action_144 _ = happyReduce_42

action_145 (32) = happyShift action_150
action_145 _ = happyFail (happyExpListPerState 145)

action_146 (22) = happyShift action_91
action_146 (12) = happyGoto action_89
action_146 (15) = happyGoto action_149
action_146 _ = happyReduce_51

action_147 (22) = happyShift action_52
action_147 (28) = happyShift action_53
action_147 (33) = happyShift action_54
action_147 (52) = happyShift action_58
action_147 (11) = happyGoto action_148
action_147 _ = happyFail (happyExpListPerState 147)

action_148 _ = happyReduce_17

action_149 (27) = happyShift action_152
action_149 _ = happyFail (happyExpListPerState 149)

action_150 (22) = happyShift action_69
action_150 (23) = happyShift action_70
action_150 (24) = happyShift action_71
action_150 (25) = happyShift action_72
action_150 (26) = happyShift action_73
action_150 (35) = happyShift action_74
action_150 (37) = happyShift action_75
action_150 (13) = happyGoto action_151
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (36) = happyShift action_98
action_151 (37) = happyShift action_99
action_151 (38) = happyShift action_100
action_151 (39) = happyShift action_101
action_151 (40) = happyShift action_102
action_151 (41) = happyShift action_103
action_151 (42) = happyShift action_104
action_151 (43) = happyShift action_105
action_151 (44) = happyShift action_106
action_151 (45) = happyShift action_107
action_151 (46) = happyShift action_108
action_151 (47) = happyShift action_109
action_151 _ = happyReduce_25

action_152 (22) = happyShift action_52
action_152 (28) = happyShift action_53
action_152 (33) = happyShift action_54
action_152 (52) = happyShift action_58
action_152 (11) = happyGoto action_153
action_152 _ = happyFail (happyExpListPerState 152)

action_153 _ = happyReduce_19

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Decl happy_var_1 happy_var_3
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn4
		 (Func happy_var_1 happy_var_2
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_0  4 happyReduction_3
happyReduction_3  =  HappyAbsSyn4
		 (EOF
	)

happyReduce_4 = happySpecReduce_3  5 happyReduction_4
happyReduction_4 (HappyAbsSyn19  happy_var_3)
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (Dcl Extern happy_var_2 (NonE.fromList happy_var_3)
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_3  5 happyReduction_5
happyReduction_5 (HappyAbsSyn19  happy_var_3)
	_
	_
	 =  HappyAbsSyn5
		 (DclVoid Extern (NonE.fromList happy_var_3)
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_2  5 happyReduction_6
happyReduction_6 (HappyAbsSyn19  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (Dcl Normal happy_var_1 (NonE.fromList happy_var_2)
	)
happyReduction_6 _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_2  5 happyReduction_7
happyReduction_7 (HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (DclVoid Normal (NonE.fromList happy_var_2)
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happyReduce 4 6 happyReduction_8
happyReduction_8 (_ `HappyStk`
	(HappyTerminal (TokenInt happy_var_3)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Var happy_var_1 (Index happy_var_3)
	) `HappyStk` happyRest

happyReduce_9 = happySpecReduce_1  6 happyReduction_9
happyReduction_9 (HappyTerminal (TokenId happy_var_1))
	 =  HappyAbsSyn6
		 (Var happy_var_1 NotArray
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  7 happyReduction_10
happyReduction_10 _
	 =  HappyAbsSyn7
		 (TypeChar
	)

happyReduce_11 = happySpecReduce_1  7 happyReduction_11
happyReduction_11 _
	 =  HappyAbsSyn7
		 (TypeInt
	)

happyReduce_12 = happySpecReduce_1  8 happyReduction_12
happyReduction_12 _
	 =  HappyAbsSyn8
		 (ParmTypeVoid
	)

happyReduce_13 = happySpecReduce_1  8 happyReduction_13
happyReduction_13 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn8
		 (ParmTypes (NonE.fromList happy_var_1)
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happyReduce 9 9 happyReduction_14
happyReduction_14 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_8) `HappyStk`
	(HappyAbsSyn21  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Fun happy_var_1 happy_var_2 happy_var_4 (funVarToMany happy_var_7) (listToMany happy_var_8)
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 9 9 happyReduction_15
happyReduction_15 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_8) `HappyStk`
	(HappyAbsSyn21  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (FunVoid happy_var_2 happy_var_4 (funVarToMany happy_var_7) (listToMany happy_var_8)
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 5 10 happyReduction_16
happyReduction_16 ((HappyAbsSyn10  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (If happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_17 = happyReduce 7 10 happyReduction_17
happyReduction_17 ((HappyAbsSyn10  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (IfElse happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 5 10 happyReduction_18
happyReduction_18 ((HappyAbsSyn10  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (While happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 9 10 happyReduction_19
happyReduction_19 ((HappyAbsSyn10  happy_var_9) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (For happy_var_3 happy_var_5 happy_var_7 happy_var_9
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_1  10 happyReduction_20
happyReduction_20 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  11 happyReduction_21
happyReduction_21 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (StmtBlock (listToMany happy_var_2)
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  11 happyReduction_22
happyReduction_22 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Return happy_var_2
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happyReduce 5 11 happyReduction_23
happyReduction_23 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (StmtId happy_var_1 (listToMany happy_var_3)
	) `HappyStk` happyRest

happyReduce_24 = happySpecReduce_1  11 happyReduction_24
happyReduction_24 _
	 =  HappyAbsSyn10
		 (EmptyStmt
	)

happyReduce_25 = happyReduce 6 12 happyReduction_25
happyReduction_25 ((HappyAbsSyn13  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (AssignId happy_var_1 (Index happy_var_3) happy_var_6
	) `HappyStk` happyRest

happyReduce_26 = happySpecReduce_3  12 happyReduction_26
happyReduction_26 (HappyAbsSyn13  happy_var_3)
	_
	(HappyTerminal (TokenId happy_var_1))
	 =  HappyAbsSyn12
		 (AssignId happy_var_1 NotArray happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_2  13 happyReduction_27
happyReduction_27 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (Negate happy_var_2
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_2  13 happyReduction_28
happyReduction_28 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (NegateBool happy_var_2
	)
happyReduction_28 _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  13 happyReduction_29
happyReduction_29 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (BinOp Plus happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  13 happyReduction_30
happyReduction_30 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (BinOp Minus happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  13 happyReduction_31
happyReduction_31 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (BinOp Mul happy_var_1 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  13 happyReduction_32
happyReduction_32 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (BinOp Div happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  13 happyReduction_33
happyReduction_33 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (RelOp Equal happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  13 happyReduction_34
happyReduction_34 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (RelOp NotEqual happy_var_1 happy_var_3
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  13 happyReduction_35
happyReduction_35 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (RelOp LessThanEqual happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  13 happyReduction_36
happyReduction_36 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (RelOp LessThan happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  13 happyReduction_37
happyReduction_37 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (RelOp GreaterThanEqual happy_var_1 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  13 happyReduction_38
happyReduction_38 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (RelOp GreaterThan happy_var_1 happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  13 happyReduction_39
happyReduction_39 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (LogOp And happy_var_1 happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  13 happyReduction_40
happyReduction_40 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (LogOp Or happy_var_1 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happyReduce 4 13 happyReduction_41
happyReduction_41 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (IdFun happy_var_1 (listToMany happy_var_3)
	) `HappyStk` happyRest

happyReduce_42 = happyReduce 4 13 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Id (Index happy_var_3) happy_var_1
	) `HappyStk` happyRest

happyReduce_43 = happySpecReduce_1  13 happyReduction_43
happyReduction_43 (HappyTerminal (TokenId happy_var_1))
	 =  HappyAbsSyn13
		 (Id (NotArray) happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  13 happyReduction_44
happyReduction_44 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (Brack happy_var_2
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  13 happyReduction_45
happyReduction_45 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn13
		 (LitInt happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  13 happyReduction_46
happyReduction_46 (HappyTerminal (TokenChar happy_var_1))
	 =  HappyAbsSyn13
		 (LitChar happy_var_1
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  13 happyReduction_47
happyReduction_47 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn13
		 (LitString happy_var_1
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_2  14 happyReduction_48
happyReduction_48 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1 : happy_var_2
	)
happyReduction_48 _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_0  14 happyReduction_49
happyReduction_49  =  HappyAbsSyn14
		 ([]
	)

happyReduce_50 = happySpecReduce_1  15 happyReduction_50
happyReduction_50 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (Just happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_0  15 happyReduction_51
happyReduction_51  =  HappyAbsSyn15
		 (Nothing
	)

happyReduce_52 = happySpecReduce_1  16 happyReduction_52
happyReduction_52 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn16
		 (Just happy_var_1
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_0  16 happyReduction_53
happyReduction_53  =  HappyAbsSyn16
		 (Nothing
	)

happyReduce_54 = happySpecReduce_3  17 happyReduction_54
happyReduction_54 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 : happy_var_3
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  17 happyReduction_55
happyReduction_55 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn17
		 ([happy_var_1]
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_0  17 happyReduction_56
happyReduction_56  =  HappyAbsSyn17
		 ([]
	)

happyReduce_57 = happyReduce 6 18 happyReduction_57
happyReduction_57 ((HappyAbsSyn18  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (ParmType happy_var_1 happy_var_2 IsArrayParm : happy_var_6
	) `HappyStk` happyRest

happyReduce_58 = happyReduce 4 18 happyReduction_58
happyReduction_58 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 ([ParmType happy_var_1 happy_var_2 IsArrayParm]
	) `HappyStk` happyRest

happyReduce_59 = happyReduce 4 18 happyReduction_59
happyReduction_59 ((HappyAbsSyn18  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (ParmType happy_var_1 happy_var_2 IsNotArrayParm : happy_var_4
	) `HappyStk` happyRest

happyReduce_60 = happySpecReduce_2  18 happyReduction_60
happyReduction_60 (HappyTerminal (TokenId happy_var_2))
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn18
		 ([ParmType happy_var_1 happy_var_2 IsNotArrayParm]
	)
happyReduction_60 _ _  = notHappyAtAll 

happyReduce_61 = happyReduce 6 19 happyReduction_61
happyReduction_61 ((HappyAbsSyn19  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 ((happy_var_1, happy_var_3) : happy_var_6
	) `HappyStk` happyRest

happyReduce_62 = happyReduce 4 19 happyReduction_62
happyReduction_62 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 ([(happy_var_1, happy_var_3)]
	) `HappyStk` happyRest

happyReduce_63 = happySpecReduce_3  20 happyReduction_63
happyReduction_63 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1 : happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_1  20 happyReduction_64
happyReduction_64 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn20
		 ([happy_var_1]
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happyReduce 4 21 happyReduction_65
happyReduction_65 ((HappyAbsSyn21  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 ((happy_var_1, happy_var_2) : happy_var_4
	) `HappyStk` happyRest

happyReduce_66 = happySpecReduce_0  21 happyReduction_66
happyReduction_66  =  HappyAbsSyn21
		 ([]
	)

happyNewToken action sts stk [] =
	action 57 57 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenId happy_dollar_dollar -> cont 22;
	TokenInt happy_dollar_dollar -> cont 23;
	TokenChar happy_dollar_dollar -> cont 24;
	TokenString happy_dollar_dollar -> cont 25;
	TokenBracket LeftSide Paren -> cont 26;
	TokenBracket RightSide Paren -> cont 27;
	TokenBracket LeftSide Brace -> cont 28;
	TokenBracket RightSide Brace -> cont 29;
	TokenBracket LeftSide Bracket -> cont 30;
	TokenBracket RightSide Bracket -> cont 31;
	TokenAssign -> cont 32;
	TokenSemiColon -> cont 33;
	TokenComma -> cont 34;
	TokenUnaryOp BoolNegation -> cont 35;
	TokenBinOp Plus -> cont 36;
	TokenBinOp Minus -> cont 37;
	TokenBinOp Mul -> cont 38;
	TokenBinOp Div -> cont 39;
	TokenRelOp Equal -> cont 40;
	TokenRelOp NotEqual -> cont 41;
	TokenRelOp LessThanEqual -> cont 42;
	TokenRelOp LessThan -> cont 43;
	TokenRelOp GreaterThanEqual -> cont 44;
	TokenRelOp GreaterThan -> cont 45;
	TokenLogicalOp And -> cont 46;
	TokenLogicalOp Or -> cont 47;
	TokenReserved TokenIf -> cont 48;
	TokenReserved TokenElse -> cont 49;
	TokenReserved TokenWhile -> cont 50;
	TokenReserved TokenFor -> cont 51;
	TokenReserved TokenReturn -> cont 52;
	TokenReserved TokenExtern -> cont 53;
	TokenType TTypeChar -> cont 54;
	TokenType TTypeInt -> cont 55;
	TokenType TTypeVoid -> cont 56;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 57 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


-- | Convert a list to a `Many`, which is either `Empty` or a `NonEmpty a`.
listToMany :: [a] -> Many a   
listToMany [] = Empty
listToMany as = Many (NonE.fromList as)

-- | Construct the `FunctionVarDeclaration`. Note that we rely on 
-- `some_var_decl` to never be an empty list!
funVarToMany :: [(Type, [VarDeclaration])] -> FunctionVarDeclaration
funVarToMany []      = Empty
funVarToMany as      = Many $ NonE.fromList $ sndToSome as
  where 
    sndToSome :: [(Type, [VarDeclaration])] -> [(Type, NonEmpty VarDeclaration)]
    sndToSome [] = []
    sndToSome ((t, vs):vds) = (t, (NonE.fromList vs)) : sndToSome vds

-- | Express that we encountered a parser error.
parseError :: [Token] -> a
parseError t = error $ "Parse error on: " ++ show t
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 16 "<built-in>" #-}
{-# LINE 1 "/Users/tehnix/.stack/programs/x86_64-osx/ghc-8.0.2/lib/ghc-8.0.2/include/ghcversion.h" #-}


















{-# LINE 17 "<built-in>" #-}
{-# LINE 1 "/var/folders/7w/pg1bypcn3c9_lb_4gtp8swhm0000gn/T/ghc13822_0/ghc_2.h" #-}























































































































































{-# LINE 18 "<built-in>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 










{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList








{-# LINE 65 "templates/GenericTemplate.hs" #-}


{-# LINE 75 "templates/GenericTemplate.hs" #-}










infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action


{-# LINE 137 "templates/GenericTemplate.hs" #-}


{-# LINE 147 "templates/GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







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


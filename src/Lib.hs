module Lib where

import Parser (parseFile)
import Parser.Syntax

parser :: FilePath -> IO (Either String Prog)
parser = parseFile

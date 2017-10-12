{
module Lexer (
  Token(..),
  scanTokens
) where

import Syntax
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
$eol   = [\n]

$ordinal = first | second | third | fourth | fifth | sixth | seventh | eighth | ninth | tenth | eleventh | twelfth | thirteenth | fourteenth | fifteenth | sixteenth

tokens :-
  'Let the record show'                { \s -> TokenPrint }
  'shall be'                           { \s -> TokenAssignment }
  'and the portion'                    { \s -> TokenAddition }
  'less the portion'                   { \s -> TokenSubtraction }
  'distributed evenly among'           { \s -> TokenDivision }
  'apportioned evenly to each of'      { \s -> TokenMultiplication }
  'The party of the '$ordinal'part'    { \s -> TokenDeclaration }
  'hereafter known as'                 { \s -> TokenAlias }
  with                                 { \s -> TokenConcatenation }
  'in the case of'                     { \s -> TokenIf }
  being                                { \s -> TokenCheckEq }
  surpassing                           { \s -> TokenCheckGt }
  not                                  { \s -> TokenNot }
  'pursuant to'                        { \s -> TokenCall }
  'This section grants the value'      { \s -> TokenReturn }
  'Given that'                         { \s -> TokenTry }
  'Nonwithstanding the afformentioned' { \s -> TokenCatch }
  $digit                               { \s -> TokenLiteralInt }
  $digit+(\.$digit+)?                  { \s -> TokenLiteralFloat }
  [\'][$alpha$white]*[\']              { \s -> TokenLiteralString }
  [\.$eol]                             { \s -> TokenStatementEnd }
  True                                 { \s -> TokenTrue }
  False                                { \s -> TokenFalse }
  $alpha+                              { \s -> TokenVariableName }

data Token
  = TokenPrint
  | TokenAssignment
  | TokenAddition
  | TokenSubtraction
  | TokenDivision
  | TokenMultiplication
  | TokenConcatenation
  | TokenIf
  | TokenCheckEq
  | TokenCheckGt
  | TokenNot
  | TokenCall
  | TokenReturn
  | TokenTry
  | TokenCatch
  | TokenLiteralInt
  | TokenLiteralFloat
  | TokenLiteralString
  | TokenStatementEnd
  | TokenTrue
  | TokenFalse
  | TokenVariableName
  deriving (Eq, Show)

scanTokens :: String -> [Token]

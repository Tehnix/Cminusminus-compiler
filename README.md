# Compiler for the C-- language

## Specification
This specification is taken from the [C-- Language Specification](https://www2.cs.arizona.edu/~debray/Teaching/CSc453/DOCS/cminusminusspec.html), and reiterated here convenience.

The extended BNF notation is used,

- Alternatives are separated by vertical bars: i.e., `a | b` stands for "a or b".
- Square brackets indicate optionality: `'[ a ]'` stands for an optional a, i.e., `a | epsilon` (here, epsilon refers to the empty sequence).
- Curly braces indicate repetition: `'{ a }'` stands for `epsilon | a | aa | aaa | ...`

## Lexical Rules

| Production |  | Rules |
|------------|--|-------|
| _letter_ | :== | `a | b | ... | z | A | B | ... | Z` |
| _digit_ | :== | `0 | 1 | ... | 9` | 
| __id__ | :== | _letter_{ _letter_ \| _digit_ \| _ } |
| __intcon__ | :== | _digit_{ _digit_ }
| __charcon__ | :== | 'ch' \| '\n' \| '\0'<sup>1</sup> |
| __stringcon__ | :== | "ch"<sup>2</sup> |
| _Comments_ |  |Comments are as in C, i.e. a sequence of characters preceded by /* and followed by */, and not containing any occurrence of */. |

<sup>1</sup> where _ch_ denotes any printable ASCII character, as specified by `isprint()`, other than __\\__ (backslash) and __'__ (single quote).

<sup>2</sup> where _ch_ denotes any printable ASCII character (as specified by `isprint())` other than " (double quotes) and the newline 

## Syntax Rules (Grammar Productions)

Nonterminals are shown in italics; terminals are shown in boldface, and sometimes enclosed within quotes for clarity.

| Production |  | Rules |
|------------|--|-------|
| _prog_ | : | { _dcl_ '__;__' \| _func_} |
| _dcl_ | : <br> \| <br> \| | _type var\_decl_ { ',' _var\_decl_ } <br> [ __extern__ ] _type_ __id__ '__(__' _parm\_types_ '__)__' { ',' __id__ '__(__' _parm\_types_ '__)__' } <br> [ __extern__ ] __void__ __id__ '__(__' _parm\_types_ '__)__' { ',' __id__ '__(__' _parm\_types_ '__)__' } |
| _var\_decl_ | : | __id__ [ '__[__' __intcon__ '__]__' ] |
| _type_ | : <br> \| | __char__ <br> __int__ |
| _parm\_types_ | : | __void__ |
| _func_ | : <br> \| | _type_ __id__ '__(__' _parm\_types_ '__)__' '__{__' { _type_ _var\_decl_ { ',' _var\_decl_ } '__;__' } { _stmt_ } '__}__' <br> __void__ __id__ '__(__' _parm\_types_ '__)__' '__{__' { _type_ _var\_decl_ { ',' _var\_decl_ } '__;__' } { _stmt_ } '__}__' |
| _stmt_ | : <br> \| <br> \| <br> \| <br> \| <br> \| <br> \| <br> \| | __if__ '__(__' _expr_ '__)__' _stmt_ [ __else__ _stmt_ ] <br> __while__ '__(__' _expr_ '__)__' _stmt_ <br> __for__ '__(__' [ _assg_ ] '__;__' [ _expr_ ] '__;__' [ _assg_ ] '__)__' _stmt_ <br> __return__ [ _expr_ ] '__;__' <br> _assg_ '__;__' <br> __id__ '__(__' [ _expr_ { '__,__' _expr_ } ] <br> '__{__' { _stmt_ } '__}__' <br> '__;__'|
| _assg_ | : | __id__ [ '__[__' _expr_ '__]__' ] = _expr_ |
| _expr_ | : <br> \| <br> \| <br> \| <br> \| <br> \| <br> \| <br> \| <br> \| <br> \| | '__-__' _expr_ <br> '__!__' _expr_ <br> _expr_ _binop_ _expr_ <br> _expr_ _relop_ _expr_ <br> _expr_ _logical\_op_ _expr_ <br> __id__ [ '__(__' [ _expr_ { ',' _expr_ } ] '__)__' \| '__[__' _expr_ '__]__' ] <br> '__(__' _expr_ '__)__' <br> __intcon__ <br> __charcon__ <br> __stringcon__ |
| _binop_ | : <br> \| <br> \| <br> \| | __+__ <br> __-__ <br> __*__ <br> __/__ |
| _relop_ | : <br> \| <br> \| <br> \| <br> \| <br> \| | __==__ <br> __!=__ <br> __<=__ <br> __<__ <br> __>=__ <br> __>__ |
| _logical\_op_ | : <br> \| | __&&__ <br> __\|\|__ |

#### Operator associativity and Precedences

| Operator | Associativity |
------------|------
| !, - (unary) | right to left |
| *, / | left to right |
| +, - (binary) | left to right |
| <, <=, > >= | left to right |
| ==, != | left to right |
| && | left to right |
| \|\| | left to right |

## Typing Rules (and Internal Datastructure)

For the full information, see the [C-- Language Specification](https://www2.cs.arizona.edu/~debray/Teaching/CSc453/DOCS/cminusminusspec.html) for this part.

We need to keep track of several things as we parse C--.

| Keep track of | Reason | Where to track it |
|---------------|--------|-------------------|
| Scope | a) An identifier can only be _declared_ at most __once__ globally and __once__ locally <br> b) a function may have at most __one__ prototype i.e. defined at most __once__ <br> c) The formal parameters of a function have __scope local__ to that function | Symbol Table |
| Array size | An array __must__ have a non-negative size | AST |
| Prototypes <br> Functions | a) The prototype, if present, must __precede the definition__ of the function <br> b) The __types of the prototype must match the types of its definition__ along with parameters etc <br> c) If a __function takes no parameters__, its __prototype__ must indicate this by using the __keyword void__ in place of the formal parameters <br> d) A function whose prototype is preceded by the __keyword extern__ must __not be defined__ in the program being processed | Symbol Table |
| Identifiers | a) An identifier can occur at most __once__ in the list of formal parameters in a function definition <br> b) If an identifier is declared to have scope local to a function, then all uses of that identifier within that function refer to this local entity; if not, but it's defined globally, then it will refer to the global instance | Together with function definition (Symbol Table) |
| Variables | Variables must be __declared before they are used__ | Symbol Table (with scope)

### Type consistency

We denote compatibility here with 🔛,

1. __int__ 🔛 __int__, __char__ 🔛 __char__
2. __int__ 🔛 __char__, __char__ 🔛 __int__
3. Array of __int__ 🔛 Array of __int__, and same for __char__
4. Everything else is not compatible

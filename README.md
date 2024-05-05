# Programming Language fillang

Group Members: Haydar Köse - 20200808009
Enver Untuç - 20200808047
Emirhan Duman - 20200808021
Samed Nayki - 20200808015

## Syntax
<sign> ::= "+" | "-"

<digit> ::="0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"

<nonzero> ::= "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"

<integer> ::= [ <sign> ] (<digit> | <nonzero>{<digit>}) 

<float> ::= [ <sign> ] <integer> "." { <digit> }

<letter> ::="a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" 
| "l" | "m" | "n" | "o" | "p" | "r" | "s" | "t" | "u" | "v" | "y" | "z" 
| "w" | "x" | | "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" 
| "K" | "L" | "M" | "N" | "O" | "P" | "R" | "S" | "T" | "U" | "V" | "Y" 
| "Z" | "W" | "X"

<word> ::= <letter>{<letter>}

<symbol> ::= "!" | """ | "#" | "$" | "%" | "&" | "'" | "(" | ")" 
| "*" | "+" | | "-" | "." | "/" | ":" | ";" | "<" | "=" | ">" | "?" | "@" 
| "[" | "" | "]" | "^" | "_" | "`" | "{" | "|" | "}" | "~" | 

<char> ::= "'"<any_character>"'"

<string> ::= '"'{<character>}'"'

<boolean> ::= "true" | "false"

<type> ::= "int" | "float" | "bool" | "str" | "char"

<conditionalOprt> ::= "==" | "!=" | "<" | ">" | "<=" | ">="

<multiplicationOprt> ::= "*" | "/"

<arithmaticOprt> ::= "+" | "-"

<operator> ::= "*" | "/" | "+" | "-"

<literal> ::= <integer> | <string> | <float> | <boolean>

<identifier> ::= (<letter>|"") ({<letter>} | {<digit>} | {})

<expression> ::= <literal> {<operator><literal>}

<variable> ::= <type> <identifier>

<parameter> ::= <type> <identifier>

<declaration> ::= <variable> "=" <expression>

<assignment> ::= <identifier> "=" <expression>

<condition> ::= [!] (<literal> | <identifier>) <conditionalOprt> (<literal> | <identifier>) 

<condition-sequance> ::= <condition> {("&&" | "||") <condition>} 

<statement> ::= <declaration> | <assignment> | <if-statement> 
        | <while-statement> | <block> 

<block> ::= <statement>{<statement>}

<if-statement> ::= "if" "(" <condition-sequance> ")" "{" <block "}" 
			{ "elseif" "("<condition-sequance>")" "{" <block "}" }
			["else" "{" <block> "}"]

<while-statement> ::= "while" "(" <condition-sequance> ")" "{" <block> "}"

<comment> ::= "``" {<anycharacter>} | "" {<_anycharacter_>} ""

<functions> ::= "fun" (<type> | "void") <identifier> "("{<parameter>}")" "{" <block> "}"

## Explanations about the language

- Takes a file with extension .fil
- Has if, else if, else, while, integer, float, string, char, function definitions, declaring variables, comparing operators, && and || logic operators, commenting.

- You can run your program by running the makefile and giving it to myscanner as input:

make
./my_scanner exampleprog1.fil
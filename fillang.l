%{
#include "my_scanner.h"
%}


%%
"int"                   { printf("INT_KEYWORD\n"); return INT_KEYWORD; }
"float"                 { printf("FLOAT_KEYWORD\n"); return FLOAT_KEYWORD; }
"bool"                  { printf("BOOL_KEYWORD\n"); return BOOL_KEYWORD; }
"str"                   { printf("STR_KEYWORD\n"); return STR_KEYWORD; }
"char"                  { printf("CHAR_KEYWORD\n"); return CHAR_KEYWORD; }
"if"                    { printf("IF_KEYWORD\n"); return IF_KEYWORD; }
"elseif"                { printf("ELSE_IF_KEYWORD\n"); return ELSE_IF_KEYWORD; }
"else"                  { printf("ELSE_KEYWORD\n"); return ELSE_KEYWORD; }
"while"                 { printf("WHILE_KEYWORD\n"); return WHILE_KEYWORD; }
"fun"                   { printf("FUN_KEYWORD\n"); return FUN_KEYWORD; }
"void"                  { printf("VOID_KEYWORD\n"); return VOID_KEYWORD; }
"return"                { printf("RETURN_KEYWORD\n"); return RETURN_KEYWORD; }
"=="                    { printf("CONDITIONAL_OPRT: ==\n"); return CONDITIONAL_OPRT; }
"!="                    { printf("CONDITIONAL_OPRT: !=\n"); return CONDITIONAL_OPRT; }
"<"                     { printf("CONDITIONAL_OPRT: <\n"); return CONDITIONAL_OPRT; }
">"                     { printf("CONDITIONAL_OPRT: >\n"); return CONDITIONAL_OPRT; }
"<="                    { printf("CONDITIONAL_OPRT: <=\n"); return CONDITIONAL_OPRT; }
">="                    { printf("CONDITIONAL_OPRT: >=\n"); return CONDITIONAL_OPRT; }
"*"                     { printf("MULTIPLICATION_OPRT: *\n"); return MULTIPLICATION_OPRT; }
"/"                     { printf("MULTIPLICATION_OPRT: /\n"); return MULTIPLICATION_OPRT; }
"+"                     { printf("ARITHMETIC_OPRT: +\n"); return ARITHMETIC_OPRT; }
"-"                     { printf("ARITHMETIC_OPRT: -\n"); return ARITHMETIC_OPRT; }
"="                     { printf("ASSIGNMENT_OPRT\n"); return ASSIGNMENT_OPRT; }
"("                     { printf("LEFT_PARENT\n"); return LEFT_PARENT; }
")"                     { printf("RIGHT_PARENT\n"); return RIGHT_PARENT; }
"{"                     { printf("LEFT_BRACE\n"); return LEFT_BRACE; }
"}"                     { printf("RIGHT_BRACE\n"); return RIGHT_BRACE; }
","                     { printf("COMMA\n"); return COMMA; }
";"                     { printf("SEMICOLON\n"); return SEMICOLON; }
true|false              { printf("BOOLEAN_LITERAL: %s\n", yytext); return BOOLEAN_LITERAL; }
"``".*                  { printf("COMMENT\n"); /* Ignore comments */ }
[a-zA-Z_][a-zA-Z0-9_]*  { printf("IDENTIFIER: %s\n", yytext); return IDENTIFIER; }
[0-9]+                  { printf("INTEGER_LITERAL: %s\n", yytext); return INTEGER_LITERAL; }
[0-9]+"."[0-9]+         { printf("FLOATING_LITERAL: %s\n", yytext); return FLOATING_LITERAL; }
\"([^"\\]|\\.)*\"       { printf("STRING_LITERAL: %s\n", yytext); return STRING_LITERAL; }
'.'                     { printf("CHAR_LITERAL: %s\n", yytext); return CHAR_LITERAL; }
[ \t]+                  {;}
.                       { printf("ERROR\n"); return ERROR; } // Catch any other character as an error
"```"([^`]*|[\n]*)"```" { printf("COMMENT_BLOCK\n"); /* Ignore comments */ }
"&&"                       { printf("AND_CONDITION: \n"); return AND_CONDITION; }
"||"                       { printf("OR_CONDITION: \n"); return OR_CONDITION; }
"\n"                    { printf("NEW_LINE: %s\n", yytext); return NEW_LINE; }

%%
int yywrap (void) {return 1;}

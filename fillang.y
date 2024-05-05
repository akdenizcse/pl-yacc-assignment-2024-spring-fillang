%{
#include<stdio.h>     
#include<stdlib.h>
#include<ctype.h>
int yylex();


#define MAX_VARIABLE_NUMBER 100
int total_variables = 0;

struct Symbol {
   char *type;
   char *identifier;   
   int value;
};


struct Symbol* symbols[MAX_VARIABLE_NUMBER]; 

void yyerror(const char* msg);
void add_variable(char *type, char *identifier, int value, struct Symbol *vars);
void update_var(int val, char* identifier,struct Symbol *vars);

%}

%start STATEMENTS

%union {int int; float float; char *str; char char;}
%token SIGN 
%token INT_KEYWORD 
%token FLOAT_KEYWORD 
%token STR_KEYWORD 
%token BOOL_KEYWORD 
%token CHAR_KEYWORD
%token EQUAL
%token NOT_EQUAL
%token LESS_THAN
%token GREATER_THAN
%token LESS_OR_EQUAL
%token GREATER_OR_EQUAL
%token AND_CONDITION
%token OR_CONDITION
%token LEFT_PARENT 
%token RIGHT_PARENT
%token LEFT_BRACE 
%token RIGHT_BRACE
%token IF_KEYWORD 
%token ELSE_IF_KEYWORD
%token ELSE_KEYWORD
%token WHILE_KEYWORD
%token COMMENT
%token COMMENT_BLOCK
%token COMMA
%token SEMICOLON
%token VOID_KEYWORD
%token RETURN_KEYWORD
%token DIVIDE MULTIPLY 
%token PLUS MINUS
%token NEW_LINE
%token<str> IDENTIFIER 

%token<str> TYPE 
%type<integer> EXPRESSION
%type<integer> DECLARATION
%type<integer> LITERAL
%type<integer> LOGICAL_CONDITION

%%
 
 
STATEMENTS: STATEMENT
       |
       | STATEMENTS STATEMENT
       ;
 
STATEMENT: DECLARATION   
         | ASSIGNMENT
         | IF_STATEMENT
         | WHILE_STATEMENT
         | BLOCK
         | COMMENT
         | FUNCTION
         ;
 
DECLARATION: TYPE IDENTIFIER EQUAL EXPRESSION SEMICOLON   {add_variable($1,$2,$4,symbols);}     
           ;
 
ASSIGNMENT: IDENTIFIER EQUAL EXPRESSION SEMICOLON           {
            update_var($3,$1,symbols);
          }
          ;
 
IF_STATEMENT: IF_KEYWORD LEFT_PARENT CONDITION_SEQUENCE RIGHT_PARENT BLOCK
            | IF_STATEMENT ELSE_BLOCK
            | IF_STATEMENT ELSEIF_BLOCKS
            | IF_STATEMENT ELSEIF_BLOCKS ELSE_BLOCK
            ;
 
ELSE_BLOCK: ELSE_KEYWORD LEFT_BRACE STATEMENT_LIST RIGHT_BRACE
 
ELSEIF_BLOCKS: ELSEIF_BLOCK
            | ELSEIF_BLOCKS ELSEIF_BLOCK
            
 
ELSEIF_BLOCK: ELSE_IF_KEYWORD LEFT_PARENT CONDITION_SEQUENCE RIGHT_PARENT BLOCK
           ;
 
WHILE_STATEMENT: WHILE_KEYWORD LEFT_PARENT CONDITION_SEQUENCE RIGHT_PARENT BLOCK
               ;
 
BLOCK: LEFT_BRACE STATEMENT_LIST RIGHT_BRACE
     | LEFT_BRACE STATEMENT_LIST RETURN_KEYWORD RIGHT_BRACE
     ;
 
STATEMENT_LIST: STATEMENT
               | STATEMENT_LIST STATEMENT
               ;

               LOGICAL_CONDITION : EXPRESSION LESS_THAN EXPRESSION {$$ = $1 < $3;}
                 | LITERAL GREATER_THAN EXPRESSION {$$ = $1 > $3;}
                 | LITERAL EQUAL EXPRESSION {$$ = $1 == $3;}
                 | EXPRESSION NOT_EQUAL EXPRESSION {$$ = $1 != $3;}
                 | EXPRESSION LESS_OR_EQUAL EXPRESSION {$$ = $1 <= $3;}
                 | EXPRESSION GREATER_OR_EQUAL EXPRESSION {$$ = $1 >= $3;}
                 ;

CONDITION_SEQUENCE: LOGICAL_CONDITION
                   | CONDITION_SEQUENCE AND LOGICAL_CONDITION
                   | CONDITION_SEQUENCE OR LOGICAL_CONDITION
                   ;

EXPRESSION: LITERAL 
          | EXPRESSION PLUS EXPRESSION {$$ = $<integer>1 + $<integer>3;}
          | EXPRESSION MINUS EXPRESSION {$$ = $1 - $3;}
          | EXPRESSION DIVIDE EXPRESSION {$$ = $1 / $3;}
          | EXPRESSION MULTIPLY EXPRESSION {$$ = $1 * $3;}
          
          ;

LITERAL: INTEGER 
       | FLOAT  
       | STRING 
       | BOOLEAN 
       | CHARACTER
       ;




FUNCTION: RETURN_TYPE IDENTIFIER LEFT_PARENT PARAMETER_LIST RIGHT_PARENT BLOCK
        ;

RETURN_TYPE: TYPE
            | VOID
            ;


RETURN_STATEMENT: RETURN LITERAL SEMICOLON   
                | RETURN SEMICOLON 

PARAMETER_LIST: PARAMETER
              | PARAMETER_LIST COMMA PARAMETER
              ;

PARAMETER: TYPE IDENTIFIER
         ;

%%

void add_variable(char *type, char *identifier, int value, struct Symbol *vars) {
        if(total_variables >= MAX_VARIABLE_NUMBER){
                printf("Exceeded maximum number of variables!");
                return;
        }

        for(int i=0; i < total_variables; i++) { 
           if(symbols[i]->identifier == identifier){
                printf("The identifier is already taken!");
                return;
           }
        }

        struct Symbol new_Variable;
        new_Variable.type = type;
        new_Variable.identifier = identifier;
        new_Variable.value = value;

        vars[total_variables] = new_Variable;
        total_variables++;
}

void update_var(int val, char* identifier,struct Symbol *vars){
        int index = 0;
        for(int i=0; i < total_variables; i++){
           if(vars[i].identifier == identifier){
                index = i;
           }
        }
        vars[index].value = val;

}

int main(void) {
    return yyparse();
}

void yyerror(const char* msg) {
    printf("Syntax Error: %s\n", msg);
}
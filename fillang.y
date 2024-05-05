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
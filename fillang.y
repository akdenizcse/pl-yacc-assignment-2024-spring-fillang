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
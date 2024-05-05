#include <stdio.h>
#include "my_scanner.h"

extern FILE* yyin;
extern int yylex();
extern int yylineno;
extern char* yytext;

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        return 1;
    }

    FILE *input_file = fopen(argv[1], "r");
    if (input_file == NULL) {
        perror("Error opening input file");
        return 1;
    }

    yyin = input_file;

    int ntoken;

    ntoken = yylex();
    while (ntoken) {
        printf("%d\n", ntoken);
        ntoken = yylex();
    }

    fclose(input_file);
    return 0;
}

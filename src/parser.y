%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);
%}

%union {
    char *sval;
    int   ival;
}

%token <sval> ID
%token <ival> INT

%token VAR IF ELSE WHILE
%token EQ NEQ LE GE

%start input

%%
input:
      ID    { printf("Parser: ID = %s\n", $1); free($1); }
    | INT   { printf("Parser: INT = %d\n", $1); }
    | VAR   { printf("Parser: VAR\n"); }
    | IF    { printf("Parser: IF\n"); }
    | ELSE  { printf("Parser: ELSE\n"); }
    | WHILE { printf("Parser: WHILE\n"); }
    | EQ    { printf("Parser: == operator\n"); }
    | NEQ   { printf("Parser: != operator\n"); }
    | LE    { printf("Parser: <= operator\n"); }
    | GE    { printf("Parser: >= operator\n"); }
    | '<'   { printf("Parser: < operator\n"); }
    | '>'   { printf("Parser: > operator\n"); }
    | '='   { printf("Parser: = operator\n"); }
    | '+'   { printf("Parser: + operator\n"); }
    | '-'   { printf("Parser: - operator\n"); }
    | '*'   { printf("Parser: * operator\n"); }
    | '/'   { printf("Parser: / operator\n"); }
    | ';'   { printf("Parser: ;\n"); }
    ;
%%

int yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
    return 0;
}

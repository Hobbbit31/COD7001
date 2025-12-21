%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "parser.tab.h"
%}

%option noyywrap
%option noinput nounput
%option yylineno

%x COMMENT

%%
[ \t]+                  ;
\n                      ;

"//".*                  ;

"/*"                    { BEGIN(COMMENT); }
<COMMENT>"*/"           { BEGIN(INITIAL); }
<COMMENT>\n             ;
<COMMENT>.              ;
<COMMENT><<EOF>>        { fprintf(stderr,"Unterminated comment at line %d\n", yylineno);
                            exit(1);
                        }

"var"                   { return VAR; }
"if"                    { return IF; }
"else"                  { return ELSE; }
"while"                 { return WHILE; }
"=="                    { return EQ; }
"!="                    { return NEQ; }
"<="                    { return LE; }
">="                    { return GE; }
[0-9]+                  { yylval.ival = atoi(yytext); return INT; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.sval = strdup(yytext); return ID; }
"<"                     { return '<'; }
">"                     { return '>'; }
"="                     { return '='; }
"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"("                     { return '('; }
")"                     { return ')'; }
"{"                     { return '{'; }
"}"                     { return '}'; }
";"                     { return ';'; }

.                       {fprintf(stderr, "Lexer error at line %d: %s\n", yylineno, yytext);
                            exit(1);
                        }
%%

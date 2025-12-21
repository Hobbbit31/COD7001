#include <stdio.h>
#include "parser.tab.h"

int yylex(void);
extern int yylineno;
extern YYSTYPE yylval;

const char *token_name(int tok) {
    switch (tok) {
        case ID:    return "ID";
        case INT:   return "INT";
        case VAR:   return "VAR";
        case IF:    return "IF";
        case ELSE:  return "ELSE";
        case WHILE: return "WHILE";
        case EQ:    return "EQ";
        case NEQ:   return "NEQ";
        case LE:    return "LE";
        case GE:    return "GE";
        default:    return "UNKNOWN";
    }
}

int main(void) {
    int tok;
    while ((tok = yylex()) != 0) {

        if (tok < 256) {
            printf("TOKEN '%c' at line %d\n", tok, yylineno);
        } else {
            printf("TOKEN %-6s at line %d", token_name(tok), yylineno);

            if (tok == ID)
                printf("  value=\"%s\"", yylval.sval);
            if (tok == INT)
                printf("  value=%d", yylval.ival);

            printf("\n");
        }
    }
    return 0;
}

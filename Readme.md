🔹 %option yylineno

Flex maintains a global integer:
int yylineno;
Incremented automatically when \n is matched
Starts from 1


“With %option yylineno, comment rules must correctly consume newlines so that line numbers remain accurate for error reporting.”





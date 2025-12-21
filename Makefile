CC = gcc
FLEX = flex
BISON = bison

CFLAGS = -Wall -g -I.

all: main

parser.tab.c parser.tab.h: src/parser.y
	$(BISON) -d src/parser.y

lex.yy.c: src/lexer.l parser.tab.h
	$(FLEX) src/lexer.l

main: src/main.c lex.yy.c parser.tab.c
	$(CC) $(CFLAGS) src/main.c lex.yy.c parser.tab.c -o main

clean:
	rm -f main lex.yy.c parser.tab.c parser.tab.h

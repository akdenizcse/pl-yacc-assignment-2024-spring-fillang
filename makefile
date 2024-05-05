# use simply "make"
# to clean use "make clean"

TARGET = fillang

LEX_FILE = fillang.l
LEX_GEN = lex.yy.c

YACC_FILE = fillang.y
YACC_GEN = y.tab.c

build: $(LEX_FILE) $(YACC_FILE)
	lex $(LEX_FILE)
	yacc $(YACC_FILE)
	gcc $(LEX_GEN) $(YACC_GEN) -o $(TARGET)

clean:
	rm $(TARGET) $(LEX_GEN) $(YACC_GEN)
 

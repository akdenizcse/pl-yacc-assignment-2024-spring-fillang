# use simply "make"
# to clean use "make clean"

TARGET = my_scanner
C_SRC = my_scanner.c

LEX_FILE = fillang.l
LEX_GEN = lex.yy.c

my_scanner: $(LEX_FILE)
	lex $(LEX_FILE)
	gcc $(C_SRC) $(LEX_GEN) -o $(TARGET)

clean:
	rm $(TARGET) $(LEX_GEN)
 

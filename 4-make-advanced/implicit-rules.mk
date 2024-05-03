
$(info Try running make with --debug=i to see implicit debug info)
$(info Also try running with make --no-builtin-rules)
$(info )

### Implicit Rule and Rule Chaining ###
################################################################################

# Default target is steel, but where is the recipe that builds it?
# That recipe is built-in to make; it is implicit.
.PHONY: all
all: steel foundations

# By explicitly stating these file names, they will not be considered
# intermediate files anymore, and will persist if created by a built-in rule
steel: steel.o
steel.o: steel.c

%.c:
	printf "#include <stdio.h>\n\
	int main(void) {\n\
		printf(\"HelloWorld from $@\");\n\
		return 0;\n\
	}\n" > $@

clean:
	rm -f steel foundations *.o *.c

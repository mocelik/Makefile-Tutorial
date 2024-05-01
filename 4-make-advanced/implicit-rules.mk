
$(info Try running make with --debug=i to see implicit debug info)
$(info Also try running with make --no-builtin-rules)

### Implicit Rule and Rule Chaining ###
################################################################################

# Default target is steel, but where is the recipe that builds it?
# That recipe is built-in to make; it is explicit.
steel:

%.c:
	printf "#include <stdio.h>\n\r\
	int main(void) {\n\r\
		printf(\"HelloWorld from $@\");\n\r\
		return 0;\n\r\
	}\n\r" > $@

clean:
	rm -f steel *.c

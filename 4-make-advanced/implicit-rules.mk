
$(info Try running make with --debug=i to see implicit debug info)
$(info Also try running with make --no-builtin-rules)
$(info )

### Implicit Rule and Rule Chaining ###
################################################################################

# Lets set our default rule to build 'africa' and 'asia' - but are they defined
# anywhere?
# Their recipes are built-in to make as part of implicit rules
.PHONY: all
all: africa asia

# This rule allows make to create C source files
%.c:
	printf "#include <stdio.h>\n\
	int main(void) {\n\
		printf(\"HelloWorld from $@\\\\n\");\n\
		return 0;\n\
	}\n" > $@

# Beyond that, there are *implicit rules* on how to compile C source files
# into object files, and on how to link object files into executables.
# Rule-chaining is where Make will recognize that an application named africa
# can be made from an object file africa.o, which can be made from a source
# file named africa.c, which can be made from the above rule.
# So the dependency chain is: [africa <- africa.o <- africa.c]
# africa.o and africa.c are intermediate files, and will be deleted at the end
# since they were never explicitly mentioned (only implicitly determined).

# Explicitly mentioned files will no longer be "intermediate" and will be kept
asia.o: asia.c


clean:
	rm -f africa asia *.o *.c


# More information on implicit rules:
# https://www.gnu.org/software/make/manual/html_node/Catalogue-of-Rules.html

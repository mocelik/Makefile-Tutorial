
$(info Try running make with --debug=i to see implicit debug info)
$(info Also try running with make --no-builtin-rules)
$(info )

# Lets set our default rule to build 'africa' and 'asia', which will be built
# using implicit rules (and rule chaining for asia)
.PHONY: all
all:

### Implicit Rule ###
################################################################################

# List ONLY the prerequisites and not the recipes
all: africa
africa: africa.o
africa.o: africa.c

# Create any C source file that will print HelloWorld from $@
# This rule will be re-used in the rule-chaining section below
%.c:
	@echo "Creating $@"
	@printf "#include <stdio.h>\n\
	int main(void) {\n\
		printf(\"HelloWorld from $@\\\\n\");\n\
		return 0;\n\
	}\n" > $@

# The recipes are built-in to make as part of implicit rules.
# Implicit rules for C programs can be considered to be of the form:
# %.o: %.c ; $(CC) $(CPPFLAGS) $(CFLAGS) -c
# %: %.o ; $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LOADLIBES) $(LDLIBS)


### Rule Chaining ###
################################################################################

# Rules can be "chained"; make knows that 'asia' can be made from 'asia.o',
# which can be made from 'asia.c', which matches the pattern rule %.c above.
# [asia <- asia.o <- asia.c = %.c]
# asia.o and asia.c are intermediate files, and will be deleted at the end since
# they were never explicitly mentioned (only implicitly determined).
all: asia


clean::
	rm -f africa asia *.o *.c

# More information on implicit rules:
# https://www.gnu.org/software/make/manual/html_node/Catalogue-of-Rules.html

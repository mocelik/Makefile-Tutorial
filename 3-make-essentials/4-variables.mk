
SIMPLE_VAR := hello
RECURSIVE_VAR = world
RECURSIVE_VAR ?= steel
HELLO_WORLD := ${SIMPLE_VAR}
HELLO_WORLD += ${RECURSIVE_VAR}
#CMDLINE_VAR should be set when running make - make CMDLINE_VAR=hi
override OVERRIDDEN_VAR := Can't touch this

$(info SIMPLE_VAR     [${SIMPLE_VAR}], \
	flavor: [$(flavor SIMPLE_VAR)], \
	origin: [$(origin SIMPLE_VAR)])

$(info RECURSIVE_VAR  [${RECURSIVE_VAR}], \
	flavor: [$(flavor RECURSIVE_VAR)], \
	origin: [$(origin RECURSIVE_VAR)])

$(info HELLO_WORLD    [${HELLO_WORLD}], \
	flavor: [$(flavor HELLO_WORLD)], \
	origin: [$(origin HELLO_WORLD)])

$(info CMDLINE_VAR    [${CMDLINE_VAR}], \
	flavor: [$(flavor CMDLINE_VAR)], \
	origin: [$(origin CMDLINE_VAR)])

$(info OVERRIDDEN_VAR [${OVERRIDDEN_VAR}], \
	flavor: [$(flavor OVERRIDDEN_VAR)], \
	origin: [$(origin OVERRIDDEN_VAR)])

$(info )


### Recursive variable (and shell) ###
########################################################################

# $(shell <cmd>) invokes <cmd> in the shell and evaluates
# to the output of that command, so the variable below
# gets the current date each time it is used
RECURSIVE_VAR_DATE = $(shell date +%s)
$(info RECURSIVE_VAR_DATE: ${RECURSIVE_VAR_DATE})
$(shell sleep 1) # for demonstration purposes only
$(info RECURSIVE_VAR_DATE: ${RECURSIVE_VAR_DATE})
$(info Value of RECURSIVE_VAR_DATE: $(value RECURSIVE_VAR_DATE))

$(info )

### Canned Recipes (Multi-line variables) ###
########################################################################

# We can also create variables that span multiple lines by defining them
# using keywords define and endef
# Sample use case: Write a part of a recipe shared between rules
define MULTI_LINE_VAR :=
This variable
is defined on
multiple lines!
endef

$(info MULTI_LINE_VAR = ${MULTI_LINE_VAR})

$(info )

### Dynamic Variable Names ###
########################################################################

# You can also dynamically name a variable from another variable
# Example use case: to create multiple variables with files from
# different directories - one variable per directory
ADJECTIVE := COOL
MY_COOL_VAR := cool
MY_NICE_VAR := nice
$(info ${ADJECTIVE} - ${MY_${ADJECTIVE}_VAR})

ADJECTIVE := crazy
MY_${ADJECTIVE}_VAR := ${ADJECTIVE}
$(info ${ADJECTIVE} - ${MY_${ADJECTIVE}_VAR})

$(info )

### Escaping $ through $$ ###
########################################################################

# If you don't want your variable to be expanded immediately, e.g. to
# have the shell evaluate it, you have to escape the $ with another $
LIST = one two three
print-list:
	@for i in $(LIST); do \
		echo $$i; \
	done

# Note: try to avoid shell-specific syntax in general.
# Also: If you ever need a loop in your recipe, please re-evaluate your
# design in case you can solve the problem by creating a main target
# that depends on multiple targets (one for each iteration of the loop)
# e.g.
# print-list: one two three
# one two three: ; echo $@

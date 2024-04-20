
### Variable Basics ###
################################################################################
A:=a
B := b
C := c # uh-oh! The space at the end is included
$(info $A)
$(info $B)
$(info [$C]) # Let's put brackets to see what happened

DE := de
FG := f g
$(info $DE) # What happened here?
$(info ${DE} or $(DE))
$(info $(FG))

$(info )

### Variable Types and Flavors ###
################################################################################

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
################################################################################

# $(shell <cmd>) invokes <cmd> in the shell and evaluates
# to the output of that command, so the variable below
# gets the current date each time it is used
RECURSIVE_VAR_DATE = $(shell date +%s)
$(info RECURSIVE_VAR_DATE: ${RECURSIVE_VAR_DATE})
$(shell sleep 1) # for demonstration purposes only
$(info RECURSIVE_VAR_DATE: ${RECURSIVE_VAR_DATE})
$(info Value of RECURSIVE_VAR_DATE: $(value RECURSIVE_VAR_DATE))

$(info )

### Canned Sequences (Multi-line variables) ###
################################################################################

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
################################################################################

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
################################################################################

# If you don't want your variable to be expanded immediately, e.g. to
# have the shell evaluate it, you have to escape the $ with another $
LIST = one two three
print-list:
	@for i in $(LIST); do \
		echo $$i; \
	done

# Note: Avoid shell-specific syntax for portability. Especially avoid loops.
# Replace loops with a target for each loop iteration for better performance.

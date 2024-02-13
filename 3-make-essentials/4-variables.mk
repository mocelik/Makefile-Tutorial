
SIMPLE_VAR := hello
RECURSIVE_VAR = world
RECURSIVE_VAR ?= steel
HELLO_WORLD := $(SIMPLE_VAR)
HELLO_WORLD += $(RECURSIVE_VAR)

$(info SIMPLE_VAR    [$(SIMPLE_VAR)], \
	flavor: [$(flavor SIMPLE_VAR)], \
	origin: [$(origin SIMPLE_VAR)])

$(info RECURSIVE_VAR [$(RECURSIVE_VAR)], \
	flavor: [$(flavor RECURSIVE_VAR)], \
	origin: [$(origin RECURSIVE_VAR)])

$(info HELLO_WORLD   [$(HELLO_WORLD)], \
	flavor: [$(flavor HELLO_WORLD)], \
	origin: [$(origin HELLO_WORLD)])

$(info CMDLINE_VAR   [$(CMDLINE_VAR)], \
	flavor: [$(flavor CMDLINE_VAR)], \
	origin: [$(origin CMDLINE_VAR)])

$(info )


RECURSIVE_VAR_DATE = $(shell date +%s)
$(info RECURSIVE_VAR_DATE: $(RECURSIVE_VAR_DATE))
$(shell sleep 1)
$(info RECURSIVE_VAR_DATE: $(RECURSIVE_VAR_DATE))
$(info Value of RECURSIVE_VAR_DATE: $(value RECURSIVE_VAR_DATE))


# Using shell-variables in recipe with double $
LIST = one two three
print-list:
	@for i in $(LIST); do \
		echo $$i; \
	done

# Note: if you ever need a loop in your recipe, please re-evaluate your 
# design in case you can solve the problem by creating a main target 
# that depends on one target for each iteration of your loop, such that
# each iteration-target will have the recipe for its own execution.
# Also, try to avoid shell-specific syntax in general.

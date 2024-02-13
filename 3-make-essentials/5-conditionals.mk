
CONFIG:=debug

# The following "if" statements exist:
# ifeq (a,b), ifneq (a,b)  --   check if a == b
# ifdef (x), ifndef (x)    --   check if x variable is defined

ifndef CONFIG
$(error CONFIG is not defined!)
endif

ifeq ($(CONFIG), debug)
$(info CONFIG is debug)
else ifeq ($(CONFIG), release)
$(info CONFIG is release)
else
$(warning CONFIG is neither debug nor release, it is $(CONFIG))
endif

all: conditional-statements conditional-functions

# We can also use conditional statements inside of a rule:
conditional-statements:
	echo ""
ifeq ($(CONFIG), debug)
	echo "ifeq statement - debug"
else ifeq ($(CONFIG), release)
	echo "else ifeq statement - release"
else
	echo "else statement - $(CONFIG)"
endif
	echo "This echo is still part of the recipe"


# Now lets look at Conditional Functions
# Notice that we can use variables before they've been defined and set,
# even if its flavour is simple (non-recursive).
# Also note that we can use the info function instead of echo.
# Since the info (and warning and error) functions evaluate to an empty
# string, the recipe of this rule is a bunch of empty strings.
conditional-functions:
	$(info if functions: )
	$(info EXAMPLE_1 is: $(EXAMPLE_1))
	$(info EXAMPLE_2 is: $(EXAMPLE_2))	
	$(info EXAMPLE_3 is: $(EXAMPLE_3))

EXAMPLE_1 := $(if anything,true_result,[false_result])
EXAMPLE_2 := $(if ,true_result,false_result)
EXAMPLE_3 := $(if ,true_result)
# There also exists $(and ), $(or ), and $(intcmp ) functions.

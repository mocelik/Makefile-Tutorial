do_nothing_target:;@:

### Refresher on the $(foreach ...) function ###
################################################################################

# $(foreach ...) below is a function with 3 parameters passed to it.
# Most functions evaluate ("return") a string, such as $(foreach ...) below.
# Some functions, like $(shell ...) or $(info ...), have side-effects

REGIONS := africa asia europe
HELLO_REGIONS:=$(foreach REGION,${REGIONS}, hello-${REGION})
# HELLO_REGIONS:=hello-africa hello-asia hello-europe


### Variables using $1, $2 ... and the $(call ...) function ###
################################################################################

# We can create our own "functions" by using variables that refer to $1, $2 etc
# and we can call them using the built-in $(call ...) function
# Note that MY_OWN_FUNCTION has to be recursively-defined to be used this way
MY_OWN_FUNCTION = $1 is better than $2.
RESULT := $(call MY_OWN_FUNCTION,Dark mode,light mode)
$(info RESULT: [${RESULT}])

# We can use multi-line variables to create more complex functions
# We'll be able to use this to create new rules in the next step
define MY_DYNAMIC_RULE
$1: $2
	$3
endef

MY_RULE_STRING := $(call MY_DYNAMIC_RULE,hello,,echo hello from the other side)
$(info MY_RULE_STRING: [${MY_RULE_STRING}])

$(info )

### Evaluating strings as Makefile syntax ###
################################################################################

# Lets create the hello-${REGION} rule from earlier using $(eval ...)
$(foreach REGION,${REGIONS}, $(eval hello-${REGION}: ; echo $$@))

MY_EVAL_RULE_STRING := $(call MY_DYNAMIC_RULE,eval-rule,,echo $$@)
$(eval ${MY_EVAL_RULE_STRING})

# Or in one line:
# $(eval $(call MY_DYNAMIC_RULE,eval-rule,,echo eval tutorial))

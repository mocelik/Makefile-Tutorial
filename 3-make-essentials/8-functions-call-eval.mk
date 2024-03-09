
# $(foreach ...) below is a function with 3 parameters passed to it.
# Most functions evaluate ("return") a string, such as $(foreach ...) below.
# Some functions, like $(shell ...) or $(info ...) have side-effects.
PLANETS := mercury venus earth mars jupiter saturn uranus neptune pluto
HELLO-PLANETS := $(foreach planet,$(PLANETS),hello-$(planet))
$(info HELLO-PLANETS is: [$(HELLO-PLANETS)])
$(info )

# We can create our own "functions" by using variables that refer to $1, $2 etc
# and we can call them using the built-in $(call ...) function
# Note that MY_OWN_FUNCTION has to be recursively-defined to be used this way
MY_OWN_FUNCTION = $1 says hi to $2.
RESULT := $(call MY_OWN_FUNCTION,The sun,the moon)
$(info RESULT: [$(RESULT)])
$(info )

# We can use multi-line variables to create more complex functions, and then
# evaluate it as makefile syntax using the $(eval ...) function
define MY_DYNAMIC_RULE=
$(info Creating new rule - [$1], [$2], [$3])
$1: $2
	$3
endef

MY_RULE_STRING := $(call MY_DYNAMIC_RULE,hello-world,,echo hello from the other side)
$(info MY_RULE_STRING: [$(MY_RULE_STRING)])

$(eval $(MY_RULE_STRING))

# You can omit the intermediate variable by combining eval and call:
# $(eval $(call MY_DYNAMIC_RULE,hello-world,,echo hello))

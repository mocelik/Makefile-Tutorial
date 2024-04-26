do_nothing_target:;@:

### Wildcard ###
################################################################################
WILDCARD_MK := $(wildcard *.mk)
$(info WILDCARD_MK is [${WILDCARD_MK}])

WILDCARD_C := $(wildcard *.c)
$(info WILDCARD_C is [${WILDCARD_C}])


### Shell ###
################################################################################

SHELL_MK := $(shell find . -type f -name "*.mk")
$(info SHELL_MK is [${SHELL_MK}])

SHELL_C := $(shell find . -type f -name "*.c")
$(info SHELL_C is [${SHELL_C}])


### Our own recursive wildcard function ***
################################################################################

# Usage:
# $(call rwildcard-dir,<directory>,<extension>)
# $(call rwildcard,<extension>)
define rwildcard-dir
$(wildcard $1/*$2)$(foreach d,$(wildcard $1/*),$(call rwildcard-dir,$d,$2))
endef
rwildcard = $(strip $(call rwildcard-dir,.,$1))

RWILDCARD_MK := $(call rwildcard,.mk)
$(info RWILDCARD_MK is [${RWILDCARD_MK}])

RWILDCARD_C  := $(call rwildcard,.c)
$(info RWILDCARD_C is [${RWILDCARD_C}])


# Note that there are other (probably better) implementations of a recursive
# wildcard online.
# e.g. search-down: https://github.com/markpiffer/gmtt/blob/master/gmtt.mk#L1515
# or wildcard-rec:  https://github.com/markpiffer/gmtt/blob/master/gmtt.mk#L1579
# or https://stackoverflow.com/questions/2483182/recursive-wildcards-in-gnu-make

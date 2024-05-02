do_nothing_target:;@:

### Last-Resort Default Rule ###
################################################################################

# % matches anything (and everything) that doesn't already have a rule
%::
	@echo $@ has prerequisites [$^]


### Shell ###
################################################################################

shell: shell-mk-function shell-c-function
	@:

shell-mk-function: $(shell find . -type f -name "*.mk")
shell-c-function: $(shell find . -type f -name "*.c")


### Wildcard ###
################################################################################

wildcard: $(addprefix wildcard-,mk-glob mk-function c-glob c-function)
	@:

wildcard-mk-glob: *.mk
wildcard-mk-function: $(wildcard *.mk)

wildcard-c-glob: *.c
wildcard-c-function: $(wildcard *.c)


### Our own recursive wildcard function ***
################################################################################

# Usage:
# $(call rwildcard-dir,<directory>,<extension>)
# $(call rwildcard,<extension>)
define rwildcard-dir
$(wildcard $1/*$2)$(foreach d,$(wildcard $1/*),$(call rwildcard-dir,$d,$2))
endef
rwildcard = $(strip $(call rwildcard-dir,.,$1))


rwildcard: rwildcard-mk rwildcard-c
	@:

rwildcard-mk: $(call rwildcard,.mk)
rwildcard-c: $(call rwildcard,.c)

# Note that there are better implementations of a recursive wildcard online.
# e.g. search-down: https://github.com/markpiffer/gmtt/blob/master/gmtt.mk#L1515
# or wildcard-rec:  https://github.com/markpiffer/gmtt/blob/master/gmtt.mk#L1579
# or https://stackoverflow.com/questions/2483182/recursive-wildcards-in-gnu-make

do_nothing_target:;@:

### Setup another Makefile with an 'all' target ###
################################################################################

EXTERNAL_MAKEFILE := 10-other-makefile.mk
EXTERNAL_TARGET := all
${EXTERNAL_MAKEFILE}:
	@printf "${EXTERNAL_TARGET}:\n\
	\t@echo 'Hello!'" > $@

### Recursive Make (not recommended) ###
################################################################################

recursive: ${EXTERNAL_MAKEFILE}
	${MAKE} -f $< ${EXTERNAL_TARGET}

### Non-Recursive Make via include (recommended) ###
################################################################################

# We copy the contents of the other makefile into this one
include ${EXTERNAL_MAKEFILE}
nonrecursive: ${EXTERNAL_TARGET}


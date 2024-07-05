do_nothing_target:;@:

### Setup another Makefile with a 'hello' target ###
################################################################################

# Normally you would write the other Makefile by hand, but for this tutorial
# lets generate the other Makefile automatically to illustrate more concepts.
EXTERNAL_MAKEFILE := other-make-module.mk
EXTERNAL_TARGET := hello
clean:
	@rm -f ${EXTERNAL_MAKEFILE}

# Here's the rule to create another Makefile with the ${EXTERNAL_TARGET} rule:
# Note that this rule may run in the background if you use tab autocomplete.
${EXTERNAL_MAKEFILE}:
	@echo "Creating other Makefile [$@] with rule [${EXTERNAL_TARGET}]"
	@echo "${EXTERNAL_TARGET}: ; @echo Hello from ${EXTERNAL_MAKEFILE}" > $@


### Recursive Make (not recommended) ###
################################################################################

# Call the other makefile directly. Note that we use the MAKE variable, which
# expands to whichever `make` application was used to invoke this makefile
recursive: ${EXTERNAL_MAKEFILE}
	${MAKE} -f ${EXTERNAL_MAKEFILE} ${EXTERNAL_TARGET}


# Recursive Make is not recommended because each "Makefile" knows a different
# part of the dependency graph, whereas Make works best when it knows the entire
# dependency graph. It's also not recommended because it is more prone to bugs.
#
# Refer to "Recursive Make Considered Harmful" by Peter Miller:
# https://aegis.sourceforge.net/auug97.pdf


### Non-Recursive Make via include (recommended) ###
################################################################################

# We "include" the contents of the other makefile in this one.
# Note that this implicitly makes ${EXTERNAL_MAKEFILE} a dependency and a part
# of this Makefile. Since Make always tries to rebuild itself, it will also try
# to rebuild ${EXTERNAL_MAKEFILE} using the rule above before including it.
# A - prefix may be added to 'include' to ignore errors if the Makefile does not
# exist; however, it will still be created/updated if Make knows how to do so.
include ${EXTERNAL_MAKEFILE}

# Now ${EXTERNAL_TARGET} can be used directly from this Makefile
nonrecursive: ${EXTERNAL_TARGET}

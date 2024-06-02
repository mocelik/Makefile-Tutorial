
ifeq (,$(findstring grouped-target,${.FEATURES}))
$(error "grouped-target not supported in this version of make. \
	You need version 4.3 or greater. Your version is ${MAKE_VERSION}, \
	which supports features: ${.FEATURES}" )
endif

$(info Use grouped targets if you have a recipe that builds multiple targets.)
$(info Try passing -j (if not already) to make to see the advantages of \
	grouped vs normal targets.)
$(info )

# For demonstration purposes, call all targets and delete the resulting files
# to allow the user to try running it again
all: a b c   d e f
	rm $^

# Grouped target
a b c &:
	touch a b c

# Non-grouped target
d e f:
	touch d e f

# Grouped-target will run once and create all 3 targets at the same time
# Make will automatically recognize that all grouped targets are updated even
# if just one of them triggers the grouped rule
#
# Compare how many times non-grouped target has to run (when -j is passed to
# Make) vs the grouped-target above. If Make is run single-threaded, then they
# may show similar behaviour, but the grouped-target avoids having to check the
# last-modified-time of the other updated-targets


# More information on grouped targets:
# https://www.gnu.org/software/make/manual/html_node/Multiple-Targets.html

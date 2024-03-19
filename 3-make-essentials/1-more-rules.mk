
### Warm-up with more rule syntax ###
########################################################################

single_line_target: ; echo "You can put the recipe after a semicolon"
blank_recipe: ;

# Double-colon rules
multi-recipe-rule ::
	echo "Hello..."
multi-recipe-rule ::
	echo "...world"

# order-only prerequisite (try touching order-only-dep after ordered_rule)
# The target will not be rebuilt if the order-only-dep is newer.
ordered_rule: | order-only-dep
	touch ordered_rule
order-only-dep:
	touch order-only-dep


### Prefixes ###
########################################################################

# @ does not print the recipe before it executes
hide_recipe:
	@echo "Can you see the command that prints this?"

# - mark recipe as successful even if command fails
ignore_errors:
	-false

# + overrides "--dry-run" mode and always runs
run_during_dryrun:
	+echo "This command runs even if you rerun make with --dry-run"


### Pattern Rules (Wildcard Targets) ###
########################################################################

# hello-asia
hello-%:
	@echo "Matched hello-% wildcard rule. You added [$*]"

# hello~world, hello-my-favorite-world
hello%world:
	@echo "matched hello%world wildcard rule. You added [$*]"

# hi-world
%-world:
	@echo "matched %-world wildcard rule. You added [$*]"

hello-world:
	@echo "Direct-match rules always take precedence over wildcards"


### Prerequisite Handling ###
########################################################################

multiple-prereqs: dep1
	@echo "Building multiple-prereqs"

# prerequisites on other target lines are appended to
# the original rule (above)
multiple-prereqs: dep2

dep%:
	@echo "Recipe for Dependency $*"


### Static Pattern Rules ###
########################################################################

# Useful when you want to automatically generate prerequisites based
# on the names of targets
# General Syntax:
# target-pattern-1 target-pattern-2 ... : target-pattern-% : prereq-patterns-with-%

hello-asia hello-europe: hello-%: static-dependency-%

static-dependency-asia:
	@echo Static Dependency for asia

static-dependency-europe:
	@echo Static Dependency for europe


### PHONY Targets ###
########################################################################
.PHONY: not-a-file
not-a-file:
	echo "This recipe does not create a file and it doesn't need to."

# Common PHONY targets
.PHONY: all clean test

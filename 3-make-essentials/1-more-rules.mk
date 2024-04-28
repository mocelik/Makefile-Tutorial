
### Warm-up with more rule syntax ###
################################################################################

# Standard rule syntax:
# target1 target2: prereq1 prereq2
#	recipe1
#	recipe2

# Add a semicolon to put the recipe on the same line
single_line_target: ; echo "I am the recipe"
blank_recipe: ;

# Double-colon rules
double-colon-rule::
	echo "Hello..."
double-colon-rule::
	echo "...world"

# order-only prerequisite
# ordered_rule will not be considered out of date if order-only-prereq
# is newer. It only expects order-only-prereq to exist.
# Perhaps a better name would be "co-existing prerequisite"
ordered_rule: | order-only-prereq
	touch ordered_rule
order-only-prereq:
	touch order-only-prereq


### Prefixes ###
################################################################################

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
################################################################################

# hello-asia
hello-%:
	@echo "Matched hello-% pattern rule. You added [$*]"

# hello~world
hello%world:
	@echo "Matched hello%world pattern rule. You added [$*]"

# hi-world
%-world:
	@echo "Matched %-world pattern rule. You added [$*]"

# Use an explicit target to overwrite a specific pattern rule
hello-world:
	@echo "Explicit target rules always take precedence over wildcards"

# Pattern rules can have prerequisites based on the same pattern
pattern-% : prerequisite-%
	@echo "Matched pattern-% pattern rule. You added [$*]"

prerequisite-%:
	@echo "Matched prerequisite-% pattern rule. You added [$*]"

### Static Pattern Rules ###
################################################################################

# Useful when you want to automatically generate prerequisites based on the
# names of targets that are already known (not a pattern rule)
# General Syntax:
# target-pattern-1 target-pattern-2 : target-pattern-% : prereq-patterns-with-%

asia-trip europe-trip: %-trip: static-dependency-%
	@echo Trip to $*

static-dependency-asia:
	@echo Packing bags for asia

static-dependency-europe:
	@echo Excited to visit europe


### Prerequisite Handling ###
################################################################################

# prerequisites on other target lines are appended to
# the original rule
multiple-prereqs: dep2

multiple-prereqs: dep1
	@echo "Building multiple-prereqs"

dep%:
	@echo "Recipe for Dependency $*"


### PHONY Targets ###
################################################################################
.PHONY: not-a-file
not-a-file:
	echo "This recipe does not create a file and it doesn't need to."

# Common PHONY targets
.PHONY: all
.PHONY: clean
.PHONY: test

# You can also add them all in one go:
.PHONY: all clean test

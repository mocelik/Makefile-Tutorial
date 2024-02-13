
### Warm-up... ###

single_line_target: ; echo "You can put the recipe after a semicolon"
blank_recipe: ; @:

################
### PREFIXES ###
################

# @ does not print the recipe before it executes
hide_recipe:
	@echo "Can you see the command that prints this?"

# - mark recipe as successful even if command fails
ignore_errors:
	-false

# + overrides "--dry-run" mode and always runs
run_during_dryrun:
	+echo "This command runs even if you rerun make with --dry-run"


########################
### WILDCARD TARGETS ###
########################

# hello-mars
hello-%:
	@echo "Matched hello-% wildcard rule. You added [$*]"

# hello+world
hello%world:
	@echo "matched hello%world wildcard rule. You added [$*]"

# hi-world
%-world:
	@echo "matched %-world wildcard rule. You added [$*]"

hello-world:
	@echo "Direct-match rules always take precedence over wildcards"


#############################
### PREREQUISITE HANDLING ###
#############################

multiple-prereqs: dep1
	@echo "Building multiple-prereqs"

# prerequisites on other target lines are appended to
# the original rule (above)
multiple-prereqs: dep2

dep%:
	@echo "Recipe for Dependency $*"

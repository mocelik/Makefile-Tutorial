
# $@, $< and $^ are by far the most commonly used automatic variables
target: prereq1 prereq2
	@echo Target Name:  $@
	@echo First prereq: $<
	@echo All prereqs:  $^

target: prereq3

# Create empty recipes for prereq*
prereq%: ;


# wild-bear, wild-beast will both match this rule
# stem will be bear and beast respectively.
wild-%:
	@echo Target Name:   $@
	@echo Wildcard stem: $*


# You can specify multiple targets per rule with a common recipe.
# The $@ in the recipe matches which target triggered the rule
# The rule will run once per every target requested
lion tiger:
	@echo Hello $@

# Refer to the following page for more on automatic variables
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html


# $@, $< and $^ are by far the most commonly used automatic variables
target: prereq1 prereq2
	@echo Target Name:  $@
	@echo First prereq: $<
	@echo All prereqs:  $^

target: prereq3

prereq%:
	@: # empty recipe


# wild-bear, wild-beast will both match this rule
# stem will be bear and beast respectively.
wild-%:
	@echo Target Name:   $@
	@echo Wildcard stem: $*


# You can specify multiple targets per rule with a common recipe.
# The $@ in the recipe matches which target triggered the rule
lion tiger:
	@echo Hello $@

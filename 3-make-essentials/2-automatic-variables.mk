
# $@, $< and $^ are by far the most commonly used automatic variables
target: prereq3
target: prereq1 prereq2
	@echo "Target Name:            $@"
	@echo "First prereq:           $<"
	@echo "All unique prereqs:     $^"
	@echo "All duplicated prereqs: $+"

target: prereq4
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

# Add D to get the directory of an automatic variable
# Add F to get the filename of an automatic variable
# Note that these variables need parentheses or braces
dir1/dir2/file1.txt: dir1/dir2/prereq1 dir1/dir2/prereq2 dir1/dir2/dir3
	@echo "Directory: ${@D}"
	@echo "Filename:  ${@F}"
	@echo "Directory: ${^D}"
	@echo "Filename:  ${^F}"

dir1/dir2/%: ;

# Refer to the following page for more on automatic variables
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html

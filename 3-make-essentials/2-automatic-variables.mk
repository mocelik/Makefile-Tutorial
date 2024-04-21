
# Automatic variables are variables set automatically in the recipe of a rule.
# They are not valid in the prerequisite list.

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


# hello-asia, hello-africa will both match this rule
# stem will be asia and africa respectively.
hello-%:
	@echo Target Name:   $@
	@echo Wildcard stem: $*


# You can specify multiple targets per rule with a common recipe.
# The $@ in the recipe matches which target triggered the rule
# The rule will run once per every target requested
africa asia:
	@echo Hello $@


# Add D to get the directory of an automatic variable
# Add F to get the filename of an automatic variable
# Note that these variables need parentheses or braces
dir1/dir2/file1.txt: dir1/dir2/file2.txt dir1/dir2/file3.txt dir1/dir2/dir3
	@echo "Directory: ${@D}"
	@echo "Filename:  ${@F}"
	@echo "Directory: ${^D}"
	@echo "Filename:  ${^F}"

dir1/dir2/%: ;

# Refer to the following page for more on automatic variables
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html

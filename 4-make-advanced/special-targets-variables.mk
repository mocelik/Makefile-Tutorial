
# This file lists some useful special targets and variables. It is not 
# exhaustive; this is a small subset of Make's special targets and variables.

### Special Targets: .PHONY and .SILENT ###
################################################################################

# The targets that .PHONY depends on are called PHONY targets.
# They are targets that do not correspond to files, so Make will not
# check to see if that file exists, and it will always execute that
# target when it is called.
# Example usages: all, clean, test
.PHONY: all phony_target
phony_target:
	echo "phony_target recipe does not build a file named phony_target"

# If this is specified without any prerequisites, then all targets will
# be SILENT - their recipes will not be printed before they are executed.
# It is the same as adding the @ prefix to the recipe.
# If it is specified with prerequisite, those prerequisites will be silent.
# You can also get SILENT behaviour by calling make with the -s flag.
.SILENT: silent_target
silent_target:
	echo "Do you see my recipe?"



### Special Variables: .DEFAULT_GOAL and .RECIPEPREFIX ###
################################################################################

# By default, if no targets are provided, Make will choose the first target
# that appears in the makefile as its default goal. Typically, this is 'all'.
# You can override the default target using the .DEFAULT_GOAL variable.
.DEFAULT_GOAL := default_target
default_target:
	echo "Hello! This is the default target of this Makefile."

# If you have a special hatred for tabs and would like to confuse others or
# flaunt your knowledge of Make, you can change the default recipe prefix.
.RECIPEPREFIX := >
weird_recipe:
>echo "This looks weird."


# More special targets and variables here:
# https://www.gnu.org/software/make/manual/html_node/Special-Targets.html
# https://www.gnu.org/software/make/manual/html_node/Special-Variables.html

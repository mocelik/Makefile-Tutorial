
# This file lists some useful special targets and variables. It is not 
# exhaustive; this is a small subset of Make's special targets and variables.

### .PHONY ###
# The targets that .PHONY depends on are called PHONY targets.
# They are targets that do not correspond to files, so Make will not check to
# see if that file exists, and will always rebuild that target if specified.
# Example usages: all, clean, test
.PHONY: phony_target
phony_target:
	echo "phony_target recipe does not build a file named phony_target."
	echo "It runs even if such a file exists."


### .SILENT ###
# If the .SILENT target is specified without any prerequisites, then all targets
# will be SILENT - their recipes will not be printed before they are executed.
# It is the same as adding the @ prefix to the recipe.
# If .SILENT is specified with prerequisite, those prerequisites will be silent.
# You can also get SILENT behaviour by calling make with the -s flag.
.SILENT: silent_target
silent_target:
	echo "Do you see my recipe?"


### .DEFAULT_GOAL ###
# The .DEFAULT_GOAL variable can be used to override the default target that
# will be run if make is invoked without any arguments. Normally, it is the
# first target that does not begin with a dot (.)
.DEFAULT_GOAL := default_target
default_target:
	echo "Hello! This is the default target of this Makefile."


### .RECIPEPREFIX ###
# If you have a special hatred for tabs and would like to confuse others or
# flaunt your knowledge of Make, you can change the default recipe prefix.
# You may want to export this variable to have consistent makefiles...
# or don't use it at all.
.RECIPEPREFIX := >
weird_recipe:
>echo "This looks weird."


# More information on special targets and variables:
# https://www.gnu.org/software/make/manual/html_node/Special-Targets.html
# https://www.gnu.org/software/make/manual/html_node/Special-Variables.html

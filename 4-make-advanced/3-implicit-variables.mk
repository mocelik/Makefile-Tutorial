do_nothing_target:;@:

### Variables Used by Implicit Rules (and by Convention) ###
################################################################################

# The following variables are used in implicit rules, so they already have
# default values set (but can be overwritten).
# It is the convention to use these in explicit rules as well.
$(info CC: ${CC}) 	# The C Compiler
$(info CXX: ${CXX})	# The C++ Compiler
$(info RM: ${RM}) 	# The 'rm' command

# The following are variables used in implicit rules' recipes.
# You can modify an implicit rule's behaviour by modifying these.
# They are empty by default, but are the convention for storing flags.
$(info CFLAGS: ${CFLAGS}) 		# Flags for the C Compiler
$(info CPPFLAGS: ${CPPFLAGS})	# Flags for the C Pre-Processor
$(info CXXFLAGS: ${CXXFLAGS})	# Flags for the C++ Compiler
$(info LDFLAGS: ${LDFLAGS})		# Flags for the C/C++ Linker
$(info LDLIBS: ${LDLIBS})		# Libraries used by 'ld'


### Make-Related Variables ###
################################################################################

# The current working directory of the make process
$(info CURDIR: ${CURDIR})

# The Make program used (make vs /usr/bin/make)
$(info MAKE: ${MAKE})

# List of included/ran Makefiles
$(info MAKEFILE_LIST: ${MAKEFILE_LIST})

# Some (not all) flags passed in from CLI
$(info MAKEFLAGS: ${MAKEFLAGS})

# Targets ("goals") passed in from CLI
$(info MAKECMDGOALS: ${MAKECMDGOALS})


# More information on implicit, special and make-specific variables:
# https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html
# https://www.gnu.org/software/make/manual/html_node/Special-Variables.html
# https://www.gnu.org/software/make/manual/html_node/Recursion.html

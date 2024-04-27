
# CONFIG is a typical use-case for target specific variables
# where it is usually set to debug or release.
CONFIG := debug
POSSIBLE_CONFIGS := debug release coverage

### Target-Specific Variables ###
################################################################################

all-specific: target-1 target-2 target-3
	@:

target-%:
	$(info Target-Specific Variable for [$@] has config ${CONFIG})

target-2: CONFIG := release

target-3: CONFIG := coverage

# What will CONFIG be for target-4?
target-2 target-3: target-4

# Target-specific variables can be marked export, unexport, override, or private
# private will prevent it from affecting the variable in dependencies
# But we can do better than that.


### Alternative (Safer) Approach ###
################################################################################

# Create granular targets for each possible "config"
all-granular: target-1-debug target-2-release target-3-coverage
	@:

# Create targets for each possible configuration:
target-%-debug:
	$(info Granular Target for [$@] has config debug)
target-%-release:
	$(info Granular Target for [$@] has config release)
target-%-coverage:
	$(info Granular Target for [$@] has config coverage)

# Then explicitly mark the config-specific dependencies
target-2-debug target-2-release target-2-coverage : target-2-% : target-4-%
target-3-debug target-3-release target-3-coverage : target-3-% : target-4-%


### Improved Alternative Approach ###
################################################################################

all-improved: itarget-1-debug itarget-2-release itarget-3-coverage
	@:

# Create the targets for each possible configuration:
define CREATE_CONFIG_TARGETS
$1-$2:
	@echo Improved Target for [$$@] has config $2
endef

# Create pattern rules for each config in the form of itarget-%-${config}
$(foreach config,${POSSIBLE_CONFIGS},\
	$(eval $(call CREATE_CONFIG_TARGETS,itarget-%,${config})))

# Create dependencies of itarget-2 and itarget-3 on itarget-4 for each config
$(foreach num,2 3,\
	$(foreach config,${POSSIBLE_CONFIGS},\
		$(eval itarget-${num}-${config}: itarget-4-${config})))


# More information on target-specific variables here:
# https://www.gnu.org/software/make/manual/html_node/Target_002dspecific.html

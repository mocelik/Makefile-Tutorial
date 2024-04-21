do_nothing_target:;@:

### Prefixes and Suffixes ###
################################################################################

REGIONS := africa asia europe
$(info  REGIONS =                   [${REGIONS}])
$(info $$(addsuffix .c,[list]):     [$(addsuffix .c, ${REGIONS})])
$(info $$(addprefix hello/,[list]): [$(addprefix hello/,${REGIONS})])
# addsuffix .c:     africa.c asia.c europe.c
# addprefix hello/: hello/africa hello/asia hello/europe

$(info )

### Pattern Substitutions ###
################################################################################

# These all replace the .c with .o in REGIONS_C
REGIONS_C := $(addsuffix .c, ${REGIONS})
$(info  REGIONS_C =                 [${REGIONS_C}])
$(info $$(patsubst %.c,%.o,[list]): [$(patsubst %.c,%.o,${REGIONS_C})])
$(info $${[list]:%.c=%.o}:          [${REGIONS_C:%.c=%.o}])
$(info $${[list]:.c=.o}:            [${REGIONS_C:.c=.o}])
# africa.o asia.o europe.o

$(info )

### Filtering/Matching Patterns ###
################################################################################

SRC_FILES := dir1/hello.c dir1/world.c dir2/steel.c dir2/foundations.c
$(info  SRC_FILES:                 [${SRC_FILES}])
$(info $$(filter dir1,[list]):     [$(filter     dir1/%,${SRC_FILES})])
$(info $$(filter-out dir1,[list]): [$(filter-out dir1/%,${SRC_FILES})])
# filter dir1: dir1/hello.c dir1/world.c
# filter-out dir1: dir2/steel.c dir2/foundations.c

# Recommend to take a look at more functions and examples here:
# https://www.gnu.org/software/make/manual/html_node/Text-Functions.html

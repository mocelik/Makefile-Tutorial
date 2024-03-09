
PLANETS := mercury venus earth mars jupiter saturn uranus neptune pluto
$(info PLANETS = [$(PLANETS)])

PLANETS_C := $(addsuffix .c, $(PLANETS))
$(info $$(addsuffix .c,[list]): [$(PLANETS_C)])
$(info $$(addprefix hello/,[list]): [$(addprefix hello/,$(PLANETS))])
# addsuffix .c: mercury.c venus.c earth.c mars.c ...
# addprefix hello/: hello/mercury hello/venus hello/earth hello/mars ...

$(info )

# These all replace the .c with .o in PLANETS_C
$(info $$(patsubst %.c,%.o,[list]): [$(patsubst %.c,%.o,$(PLANETS_C))])
$(info $$([list]:%.c=%.o): [$(PLANETS_C:%.c=%.o)])
$(info $$([list]:.c=.o): [$(PLANETS_C:.c=.o)])
# mercury.o venus.o earth.o mars.o ...

$(info )

SRC_FILES := dir1/hello.c dir1/world.c dir2/steel.c dir2/foundations.c
DIR1_SRC_FILES := $(filter dir1/%,$(SRC_FILES))
DIR2_SRC_FILES := $(filter-out dir1/%,$(SRC_FILES))
$(info SRC_FILES: [$(SRC_FILES)])
$(info filter dir1: [$(filter dir1/%,$(SRC_FILES))])
$(info filter-out dir1: [$(filter-out dir1/%,$(SRC_FILES))])
# filter dir1: dir1/hello.c dir1/world.c
# filter-out dir1: dir2/steel.c dir2/foundations.c

# Recommend to take a look at more functions and examples here:
# https://www.gnu.org/software/make/manual/html_node/Text-Functions.html

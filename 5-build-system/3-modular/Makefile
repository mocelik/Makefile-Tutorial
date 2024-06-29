### Config ###
################################################################################

BUILD_DIR := build
BIN_DIR := ${BUILD_DIR}/bin


### General Targets ###
################################################################################

.PHONY: all clean
all:
clean:
	${RM} -r ${BUILD_DIR}

### Main Logic ###
################################################################################

include executable.mk

APPNAME := steel
CFLAGS_${APPNAME} := -Wall
CSRCS_${APPNAME}  := src/main.c src/dir1/hello.c src/dir2/world.c\
	src/dir2/extra.c src/dir1/com/common.c
$(eval $(call add_c_executable_target,${APPNAME}))

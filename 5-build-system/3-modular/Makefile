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

APPNAME := app1
CFLAGS_${APPNAME} := -Wall
CSRCS_${APPNAME}  := app1/main.c app1/dir1/hello.c app1/dir2/world.c\
	app1/dir2/extra.c app1/dir1/com/common.c
$(eval $(call add_c_executable_target,${APPNAME}))

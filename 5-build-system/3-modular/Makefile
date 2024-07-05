### Config ###
################################################################################

BUILD_DIR := build
BIN_DIR := ${BUILD_DIR}/bin
LIB_DIR := ${BUILD_DIR}/lib
INC_DIR := ${BUILD_DIR}/include


### General Targets ###
################################################################################

.PHONY: all clean
all:
clean:
	${RM} -rf ${BUILD_DIR}

### Main Logic ###
################################################################################

include executable.mk
include library.mk

APPNAME := helloworld
CFLAGS_${APPNAME} := -Wall
CSRCS_${APPNAME}  := app1/main.c app1/dir1/hello.c app1/dir2/world.c\
	app1/dir2/extra.c app1/dir1/com/common.c
$(eval $(call add_c_executable_target,${APPNAME}))

APPNAME := mylib
CSRCS_${APPNAME}  := mylib/mylib_source.c
CFLAGS_${APPNAME} := -Imylib/include
HEADER_DIR_${APPNAME} := mylib/include
$(eval $(call add_c_library_target,${APPNAME}))

APPNAME := uselib
DEPS_${APPNAME} := ${LIB_DIR}/libmylib.so
CFLAGS_${APPNAME} := -I${INC_DIR} -Wall -Wpedantic -Werror
CSRCS_${APPNAME}  := app2/main.c
LDFLAGS_${APPNAME} := -L${LIB_DIR} -Wl,-rpath=${LIB_DIR}
LDLIBS_${APPNAME} := -lmylib
$(eval $(call add_c_executable_target,${APPNAME}))

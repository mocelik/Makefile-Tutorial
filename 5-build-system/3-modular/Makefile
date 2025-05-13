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

HELLO_APP := helloworld
CSRCS_${HELLO_APP}  := app1/main.c app1/dir1/hello.c app1/dir2/world.c\
	app1/dir2/extra.c app1/dir1/com/common.c
$(eval $(call add_c_executable_target,${HELLO_APP}))

MYLIB := mylib
CSRCS_${MYLIB}  := mylib/mylib_source.c
CFLAGS_${MYLIB} := -Imylib/include
HEADER_DIR_${MYLIB} := mylib/include
$(eval $(call add_c_library_target,${MYLIB}))

APP_USING_LIB := uselib
#DEPS_${APP_USING_LIB} := ${LIBNAME_${MYLIB}}
uselib: mylib
CFLAGS_${APP_USING_LIB} := -I${INC_DIR} -Wall -Wpedantic -Werror
CSRCS_${APP_USING_LIB}  := app2/main.c
LDFLAGS_${APP_USING_LIB} := -L${LIB_DIR} -Wl,-rpath=${LIB_DIR}
LDLIBS_${APP_USING_LIB} := -lmylib
$(eval $(call add_c_executable_target,${APP_USING_LIB}))

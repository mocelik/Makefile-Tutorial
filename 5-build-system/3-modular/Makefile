### Config ###
################################################################################

BUILD_DIR := build
BIN_DIR := ${BUILD_DIR}/bin
LIB_DIR := ${BUILD_DIR}/lib


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

APPNAME := app2
${APPNAME} : ${LIB_DIR}/libmylib.so
CSRCS_${APPNAME}  := app2/app2.c
LDLIBS_${APPNAME} := -lmylib
LDFLAGS_${APPNAME} := -L${LIB_DIR}
$(eval $(call add_c_executable_target,${APPNAME}))


APPNAME := libmylib.so

${BUILD_DIR}/${CSRCS_${APPNAME}:.c=.o}: ${BUILD_DIR}/%.o : %.c
	mkdir -p ${@D}
	${CC} -c $< -o $@

${LIB_DIR}/${APPNAME}: ${BUILD_DIR}/${CSRCS_${APPNAME}:.c=.o}
	mkdir -p ${@D}
	${CC} -shared $^ -o $@
	sudo ldconfig ${CURDIR}/${LIB_DIR}

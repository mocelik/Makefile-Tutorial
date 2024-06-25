
BUILD_DIR := build
BIN_DIR := ${BUILD_DIR}/bin

SRC_FILES := src/main.c src/dir1/hello.c src/dir2/world.c src/dir2/extra.c\
	src/dir1/com/common.c
APP_NAME := steel

.PHONY: all clean purge
all:

include executable.mk

CFLAGS_${APP_NAME} := -Wall
$(eval $(call add_executable_target,${APP_NAME},${SRC_FILES}))


purge:
	$(if $(filter-out .,${BUILD_DIR}),${RM} -r ${BUILD_DIR},\
		@echo "Cannot purge ${BUILD_DIR}")

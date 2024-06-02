
CONFIG := debug

EXECUTABLE_NAME := hw
SOURCE_FILES := src/main.cpp \
src/dir2/world.cpp \
src/dir2/world.h \
src/dir1/hello.cpp \
src/dir1/hello.h \
src/dir1/com/common.h \
src/dir1/com/common.cpp

SOURCE_FILES := $(filter-out %.h, ${SOURCE_FILES})

BUILD_DIR := out

CFLAGS := -g

${BUILD_DIR}/${EXECUTABLE_NAME}:

include executable.mk

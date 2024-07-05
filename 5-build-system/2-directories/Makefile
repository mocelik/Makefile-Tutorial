
BUILD_DIR := build
SRC_FILES := src/main.c src/dir1/hello.c src/dir2/world.c src/dir1/com/common.c
OBJ_FILES := $(addprefix ${BUILD_DIR}/,$(patsubst %.c,%.o,${SRC_FILES}))
APP_NAME := ${BUILD_DIR}/steel

all: ${APP_NAME}

${APP_NAME}: ${OBJ_FILES}
	gcc $^ -o $@

${OBJ_FILES}: ${BUILD_DIR}/%.o : %.c
	gcc ${CDEPS_FLAGS} -c $< -o $@

$(foreach OBJ_FILE,${OBJ_FILES},\
	$(eval ${OBJ_FILE}: | $(dir ${OBJ_FILE})))

$(dir ${OBJ_FILES}):
	mkdir -p $@

CDEPS_FLAGS := -MMD -MP
DEPENDS := $(patsubst %.o,%.d,${OBJ_FILES})
-include ${DEPENDS}

clean:
	rm -f ${OBJ_FILES} ${DEPENDS} steel

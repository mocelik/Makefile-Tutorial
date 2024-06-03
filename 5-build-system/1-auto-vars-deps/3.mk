
SRC_FILES := main.c hello.c world.c common.c
OBJ_FILES := $(patsubst %.c,%.o,${SRC_FILES})
APP_NAME := steel

all: ${APP_NAME}

${APP_NAME}: ${OBJ_FILES}
	gcc $^ -o $@

${OBJ_FILES}: %.o : %.c
	gcc ${CDEPS_FLAGS} -c $< -o $@

CDEPS_FLAGS := -MMD -MP
DEPENDS := $(patsubst %.c,%.d,${SRC_FILES})
-include ${DEPENDS}

clean:
	rm -f ${OBJ_FILES} ${DEPENDS} steel

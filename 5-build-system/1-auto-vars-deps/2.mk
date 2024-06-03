
SRC_FILES := main.c hello.c world.c common.c
OBJ_FILES := $(patsubst %.c,%.o,${SRC_FILES})
APP_NAME := steel

all: ${APP_NAME}

${APP_NAME}: ${OBJ_FILES}
	gcc $^ -o $@

${OBJ_FILES}: %.o : %.c
	gcc -c $< -o $@

main.o: hello.h world.h
hello.o: hello.h common.h
world.o: world.h common.h
common.o: common.h

clean:
	rm -f ${OBJ_FILES} steel

all: steel

steel: main.o hello.o world.o common.o
	gcc -o steel main.o hello.o world.o common.o

main.o: main.c hello.h world.h
	gcc -c main.c

hello.o: hello.c hello.h common.h
	gcc -c hello.c

world.o: world.c world.h common.h
	gcc -c world.c

common.o: common.c common.h
	gcc -c common.c

clean:
	rm -f *.o steel

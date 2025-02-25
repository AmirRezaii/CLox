##
# clox
#
# @file
# @version 0.1

ARGS = -Wall -Wextra -pedantic -ggdb
DEPS = chunk.o value.o memory.o debug.o vm.o scanner.o compiler.o

output: main.o $(DEPS)
	gcc $(ARGS) -o output main.o $(DEPS)

reset:
	gcc $(ARGS) main.c chunk.c value.c memory.c debug.c vm.c scanner.c compiler.c

main.o: main.c
	gcc -c main.c

chunk.o: chunk.c chunk.h
	gcc -c chunk.c

value.o: value.c value.h
	gcc -c value.c

memory.o: memory.c memory.h
	gcc -c memory.c

debug.o: debug.c debug.h
	gcc -c debug.c

vm.o: vm.c vm.h
	gcc -c vm.c

scanner.o: scanner.c scanner.h
	gcc -c scanner.c

compiler.o: compiler.c compiler.h
	gcc -c compiler.c

# end

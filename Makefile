all:
	nasm -felf64 test.asm && ld test.o

run:
	./a.out

clean:
	rm a.out test.o
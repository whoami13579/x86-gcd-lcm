AS = nasm
LD = ld
ASFLAGS = -f elf -g
LDFLAGS = -m elf_i386
SRCS = main.asm
OBJS = $(SRCS:.asm=.o)
BIN = a.out

.PHONY: depend clean

all: $(BIN)

$(BIN): $(OBJS)
	$(LD) $(LDFLAGS) -o $(BIN) $(OBJS)

# .asm.o:
# 	$(AS) $(ASFLAGS) $< -o $@

%.o : %.asm
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -f *.o $(BIN)
run:
	./$(BIN)
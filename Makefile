TARGET = kernel.elf

GCC_CROSS_PATH = ${HOME}/opt/cross/
CC = $(GCC_CROSS_PATH)/bin/i686-elf-gcc

INCLUDE_DIR = include
WARNINGS = -Wall -Wextra -Wpedantic -Werror
CFLAGS = $(WARNINGS) -I$(INCLUDE_DIR) -std=gnu11 -ffreestanding -g -c

LIBS = -lgcc
LDFLAGS = -ffreestanding -nostdlib -g

# linker file
LINKER_SCRP_PATH = "arch/i386"
LINKER_SCRP_NAME = linker.ld

# boot.s file
BOOTS_PATH = "arch/i386"
BOOTS_FILE = $(BOOTS_PATH)/boot.s
BOOTS_OBJ = $(BOOTS_FILE:.s=.o)

.PHONY: all clean build_boot build_tty build_kernel link docs

all: build_boot build_tty build_kernel link

build_boot:
	@$(CC) $(CFLAGS) arch/i386/boot.s -o arch/i386/boot.o

build_tty:
	@$(CC) $(CFLAGS) arch/i386/tty.c -o arch/i386/tty.o

build_kernel:
	@$(CC) $(CFLAGS) kernel/kernel_main.c -o kernel/kernel_main.o

link:
	@$(CC) $(LDFLAGS) -T $(LINKER_SCRP_PATH)/$(LINKER_SCRP_NAME) arch/i386/boot.o arch/i386/tty.o kernel/kernel_main.o -o $(TARGET) $(LIBS)

run-qemu:
	@qemu-system-i386 -kernel $(TARGET)

docs:
	doxygen Doxyfile

%.o: %.s
	@echo "  AS    $@"
	@$(CC) $(CFLAGS) $< -o $@

%.o: %.c
	@echo "  CC    $@"
	@$(CC) $(CFLAGS) $< -o $@

clean:
	@rm -f arch/i386/boot.o
	@rm -f arch/i386/tty.o
	@rm -f kernel/kernel_main.o
	@rm -f $(TARGET)
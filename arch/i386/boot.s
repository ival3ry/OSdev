# Constants for the multiboot header.
.set MB_MAGIC, 0x1BADB002
.set MB_ALIGN, 1 << 0
.set MB_MEMINFO, 1 << 1
.set MB_FLAGS, MB_ALIGN | MB_MEMINFO
.set MB_CHECKSUM, (0 - (MB_MAGIC + MB_FLAGS))

 # Multiboot Header according to Multiboot Standart.
.section .multiboot
.align 4
.long MB_MAGIC
.long MB_FLAGS
.long MB_CHECKSUM

# The Stack reserving for initial thread.
.section .bss
.align 16
stack_bottom:
.skip 4096
stack_top:

# The Kernel Entry Point
.section .text
.global start
.extern kernel_main 		# kernel_main defined in the kernel_main.c
start:
	mov $stack_top, %esp
	call kernel_main		# transfer the control to the kernel_main function
hang:
	cli
	hlt
	jmp hang

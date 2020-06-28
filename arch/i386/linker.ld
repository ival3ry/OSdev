/* Entry point; defined in boot.s */
ENTRY(start)
 
/* Sections mapping in the final kernel executable */
SECTIONS
{
	. = 1M;

	/* Since Multiboot Header is RO-data, so putting it in a '.rodata' section */
	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.multiboot)
	}
 
	/* Executable code */
	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.text)
	}
 
	/* Read-only data. */
	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.rodata)
	}
 
	/* Read-write data (initialized) */
	.data BLOCK(4K) : ALIGN(4K)
	{
		*(.data)
	}
 
	/* Read-write data (uninitialized) and stack */
	.bss BLOCK(4K) : ALIGN(4K)
	{
		*(COMMON)
		*(.bss)
	}
} 

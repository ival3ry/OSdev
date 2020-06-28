/**
 * @file tty.c
 * @author Valery Ivanov
 * @date 4 Jul 2020
 */
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include <kernel/tty.h>

#define VIDEO_MEM_ADDR 0xB8000

/* x86's VGA text-mode buffer */
static uint16_t* const vga_buffer = (uint16_t*)VIDEO_MEM_ADDR;

/* Default VGA text-mode buffer size */
static const size_t VGA_COLS = 80;
static const size_t VGA_ROWS = 25;

static size_t term_col = 0;
static size_t term_row = 0;
static uint8_t term_color = 0x0F; /* Black background, White foreground */

void terminal_initialize(void) {
  for (size_t col = 0; col < VGA_COLS; col++) {
    for (size_t row = 0; row < VGA_ROWS; row++) {
      /* Since the text-mode buffer has a size (VGA_COLS * VGA_ROWS), so the
       * index: */
      const size_t index = (VGA_COLS * row) + col;

      /*
       * VGA buffer's entries have binary form: BBBBFFFFCCCCCCCC, where:
       * 	B - background color
       * 	F - foreground color
       * 	C - ASCII character
       */
      vga_buffer[index] =
          ((uint16_t)term_color << 8) |
          ' '; /* Set the character to blank (a space character) */
    }
  }
}

/**
 * @brief Function places a single character onto the screen
 * 
 * @param c The character to put onto the screen
 */
static void _terminal_putchar(const char c) {
  switch (c) {
    case '\n': {
      term_col = 0;
      term_row++;
      break;
    }

    default: {
      const size_t index = (VGA_COLS * term_row) + term_col;
      vga_buffer[index] = ((uint16_t)term_color << 8) | c;

      term_col++;
      break;
    }
  }

  /* case: the character is in the last column */
  if (term_col >= VGA_COLS) {
    term_col = 0;
    term_row++;
  }

  /* case: the character is in the last row */
  if (term_row >= VGA_ROWS) {
    term_col = 0;
    term_row = 0;
  }
}

void terminal_print(const char* str) {
  for (size_t i = 0; str[i] != '\0'; i++) _terminal_putchar(str[i]);
}
/**
 * @file kernel_main.c
 * @author Valery Ivanov <ivalery111[@]gmail.com>
 * @date 4 Jul 2020
 * @brief The Kernel's entry point.
 */

#include "../include/kernel/tty.h"

/**
 * @brief The Kernel's main function.
 */
void kernel_main(void) {
  terminal_initialize();

  terminal_print("Hello, Friend!\n");
}
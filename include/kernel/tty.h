/**
 * @file tty.h
 * @author Valery Ivanov
 * @date 4 Jul 2020
 * @brief Functions for interaction with terminal.
 */

#ifndef KERNEL_TTY_H
#define KERNEL_TTY_H

#include <stddef.h>

/**
 * @brief Intialize the terminal by clearing it.
 */
void terminal_initialize(void);

/**
 * @brief Function prints the entire string onto the screen.
 *
 * @param[in] str The string to print onto the screen
 */
void terminal_print(const char *str);

#endif
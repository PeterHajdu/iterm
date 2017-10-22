#include <termios.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void set_raw_terminal(void) {
  struct termios terminal_settings;
  tcgetattr(STDIN_FILENO, &terminal_settings);
  cfmakeraw(&terminal_settings);
  tcsetattr(STDIN_FILENO, TCSANOW, &terminal_settings);
}

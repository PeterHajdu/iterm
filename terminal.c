#include <termios.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ioctl.h>

void set_raw_terminal(void) {
  struct termios terminal_settings;
  tcgetattr(STDIN_FILENO, &terminal_settings);
  cfmakeraw(&terminal_settings);
  tcsetattr(STDIN_FILENO, TCSANOW, &terminal_settings);
}

short get_rows(void) {
  struct winsize w;
  ioctl(0, TIOCGWINSZ, &w);
  return(w.ws_row);
}

short get_columns(void) {
  struct winsize w;
  ioctl(0, TIOCGWINSZ, &w);
  return(w.ws_col);
}

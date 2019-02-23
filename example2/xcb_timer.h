#ifndef XCB_TIMER_H
#define XCB_TIMER_H

#include <xcb/xcb.h>
#include <signal.h>

void handler(int sig, siginfo_t *si, void *uc);

#endif //XCB_TIMER_H


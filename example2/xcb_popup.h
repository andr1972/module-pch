#ifndef XCB_POPUP_H
#define XCB_POPUP_H

#include <xcb/xcb.h>
#include <xcb/xproto.h>

void drawText(xcb_connection_t* connection,
              xcb_screen_t* screen,
              xcb_window_t window,
              int16_t x1,
              int16_t y1,
              const char* label);

#endif //XCB_POPUP_H


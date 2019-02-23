#ifndef XCB_FONT_H
#define XCB_FONT_H

#include <xcb/xcb.h>
xcb_gcontext_t getFontGC(xcb_connection_t *c,
                                 xcb_screen_t     *screen,
                                 xcb_window_t      window,
                                 const char       *font_name );

#endif //XCB_FONT_H

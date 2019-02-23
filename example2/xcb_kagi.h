#ifndef XCB_KAGI_H
#define XCB_KAGI_H

#include <xcb/xcb.h>
#include <xcb/xproto.h>

void testCookie (xcb_void_cookie_t cookie,
                 xcb_connection_t *connection,
                 char *errMessage );

#endif //XCB_KAGI_H

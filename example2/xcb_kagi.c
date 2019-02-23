#include "xcb_kagi.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

#include <inttypes.h>

void testCookie (xcb_void_cookie_t cookie,
                        xcb_connection_t *connection,
                        char *errMessage )
{
    xcb_generic_error_t *error = xcb_request_check (connection, cookie);
    if (error) {
        xcb_disconnect (connection);
        exit (-1);
    }
}

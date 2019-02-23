#include "xcb_font.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <inttypes.h>

#include <signal.h>
#include <time.h>

xcb_gcontext_t
getFontGC (xcb_connection_t  *connection,
           xcb_screen_t      *screen,
           xcb_window_t       window,
           const char        *font_name )
{
    /* get font */
    xcb_font_t font = xcb_generate_id (connection);
    xcb_void_cookie_t fontCookie = xcb_open_font_checked (connection,
                                                          font,
                                                          strlen (font_name),
                                                          font_name );
    /* create graphics context */
    xcb_gcontext_t  gc            = xcb_generate_id (connection);
    //bla bla
    return gc;
}

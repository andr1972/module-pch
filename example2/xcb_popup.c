#include "xcb_popup.h"
#include "xcb_font.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

void drawText(xcb_connection_t* connection,
                     xcb_screen_t* screen,
                     xcb_window_t window,
                     int16_t x1,
                     int16_t y1,
                     const char* label)
{
    /* get graphics context */
    xcb_gcontext_t gc = getFontGC(connection, screen, window, "fixed");
}

#include "xcb_test.h"
#include <xcb/xcb.h>
#include <stdio.h>
#include <stdlib.h>

int xcb_test(void)
{
    xcb_connection_t    *c;
    c = xcb_connect(NULL,NULL);
    if (xcb_connection_has_error(c)) {
        printf("Cannot open display\n");
        exit(1);
    }
    return 0;
}

cmake_minimum_required(VERSION 3.0)
project(example2)

set(VERBOSE "")
#uncomment it for list of included headers
#set(VERBOSE "-H")

add_library(myxcb
        xcb_font.c xcb_font.h
        xcb_kagi.c xcb_kagi.h
        xcb_popup.c xcb_popup.h
        xcb_test.c xcb_test.h
        xcb_timer.c xcb_timer.h)

add_library(structures
        List.cpp List.h
        Map.cpp Map.h
        )

add_executable(example2 main.cpp Log.cpp Log.h List.h Map.h xcb_test.h)
target_link_libraries(myxcb xcb)
target_link_libraries(example2 structures myxcb)

target_compile_options(myxcb PRIVATE ${VERBOSE} -O3)
target_compile_options(structures PRIVATE ${VERBOSE})
target_compile_options(example2 PRIVATE ${VERBOSE} -g)


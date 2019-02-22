cmake_minimum_required(VERSION 3.0)
include(../CMake/pch-support.cmake)

project(example)

set(VERBOSE "")
#uncomment it for list of included headers
#set(VERBOSE "-H")


add_executable(example main.cpp example.cpp log.h example.h)
target_compile_options(example PRIVATE ${VERBOSE} -g)

add_library(log log.cpp log.h)
target_compile_options(log PRIVATE ${VERBOSE} -O3)
target_link_libraries(example log)

add_precompiled_header(example pch.cpp "-g")
add_precompiled_header(log pch.cpp "-O3")

#dodac lepsze przyklady z netu

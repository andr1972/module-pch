# Function for setting up precompiled headers. Usage:
#
#   add_library/executable(target fileA.cpp fileA.h fileB.cpp fileB.h)
#
#   add_precompiled_header(target pch.cpp/pch.h compiler_flags)
#
# License:
#
# Copyright (C) 2019 Andrzej Borucki <borucki_andrzej@wp.pl>
# see file LICENSE

macro(combine_arguments _variable)
  set(_result "")
  foreach(_element ${${_variable}})
    set(_result "${_result} \"${_element}\"")
  endforeach()
  string(STRIP "${_result}" _result)
  set(${_variable} "${_result}")
endmacro()

function(add_precompiled_header _target rel_file compiler_flags)
  get_filename_component(rel_file_dir ${rel_file} DIRECTORY)
  if (NOT ${rel_file_dir} STREQUAL "" AND NOT ${rel_file_dir} STREQUAL "/")
       set(rel_file_dir "${rel_file_dir}/")
  endif()

  get_filename_component(filename_we ${rel_file} NAME_WE)
  set(rel_header "${rel_file_dir}${filename_we}.h")

  if(CMAKE_COMPILER_IS_GNUCXX)
    get_filename_component(filename ${rel_file} NAME)
    set(full_src_header "${CMAKE_CURRENT_SOURCE_DIR}/${rel_header}")
    set(_pch_binary_dir "${CMAKE_CURRENT_BINARY_DIR}/${_target}_pch")
    set(full_bin_header "${_pch_binary_dir}/${rel_header}")
    set(_outdir "${CMAKE_CURRENT_BINARY_DIR}/${_target}_pch/${filename_we}.h.gch")
    file(MAKE_DIRECTORY "${_outdir}")
    set(precompiled_cxx "${_outdir}/.c++")
    set(precompiled_c "${_outdir}/.c")

    add_custom_command(
      OUTPUT "${full_bin_header}"
      COMMAND "${CMAKE_COMMAND}" -E copy "${full_src_header}" "${full_bin_header}"
      DEPENDS "${full_src_header}"
      COMMENT "Updating ${filename}")
    if(filename MATCHES \\.\(cc|cxx|cpp\)$)
          add_custom_command(
            OUTPUT "${precompiled_cxx}"
            COMMAND "${CMAKE_CXX_COMPILER}" ${compiler_flags} -x c++-header -o "${precompiled_cxx}" "${full_bin_header}"
            DEPENDS "${full_bin_header}"
            COMMENT "Precompiling ${filename} for ${_target} (C++)")
    elseif(filename MATCHES \\.\(c\)$)
          add_custom_command(
            OUTPUT "${precompiled_c}"
            COMMAND "${CMAKE_C_COMPILER}" ${compiler_flags} -x c-header -o "${precompiled_c}" "${full_bin_header}"
            DEPENDS "${full_bin_header}"
            COMMENT "Precompiling ${filename} for ${_target} (C)")
    else()
         message (FATAL_ERROR "${name} is not c++ or c file")
    endif()
    get_property(_sources TARGET ${_target} PROPERTY SOURCES)
    foreach(_source ${_sources})
      set(_pch_compile_flags "")

      if(_source MATCHES \\.\(cc|cxx|cpp|c\)$)
        list(APPEND _pch_compile_flags -Winvalid-pch)
        list(APPEND _pch_compile_flags -include "${full_bin_header}")
        list(APPEND _pch_compile_flags ${compiler_flags})
        get_source_file_property(_object_depends "${_source}" OBJECT_DEPENDS)
        if(NOT _object_depends)
          set(_object_depends)
        endif()
        list(APPEND _object_depends "${full_bin_header}")
        if(_source MATCHES \\.\(cc|cxx|cpp\)$)
          list(APPEND _object_depends "${precompiled_cxx}")
        else()
          list(APPEND _object_depends "${precompiled_c}")
        endif()

        combine_arguments(_pch_compile_flags)
        set_source_files_properties(${_source} PROPERTIES
          COMPILE_FLAGS "${_pch_compile_flags}"
          OBJECT_DEPENDS "${_object_depends}")
      endif()
    endforeach()
  else()
      message (FATAL_ERROR "Must be GNUCXX compiler")
  endif(CMAKE_COMPILER_IS_GNUCXX)
endfunction()


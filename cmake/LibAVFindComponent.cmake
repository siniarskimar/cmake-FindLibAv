cmake_minimum_required(VERSION 3.1)

macro(av_find_component lib_name target)
	set(_hints "")
	list(APPEND _hints "${${_av_target}_PATH}" "$ENV{${_av_target}_PATH}")
	
	# pkg-config won't work with MSVC enviroment
	# so exclude it.
	if(NOT MSVC)
		find_package(PkgConfig QUIET)
		if(PKG_CONFIG_FOUND)
			pkg_check_modules(PKG_${target} ${lib_name} QUIET)
			if(PKG_${target}_FOUND)
				list(APPEND _lib_hints "${PKG_${target}_LIBRARY_DIRS}" )
				list(APPEND _inc_hints "${PKG_${target}_INCLUDE_DIRS}" )
			endif()
		endif()
	endif()
	
	if(WIN32)
		# Add C:/Program Files/ and C:/Program Files(x86)/ to the list of hints
		list(APPEND _hints "$ENV{ProgramFiles}" "$ENV{ProgramFiles\(x86\)}")
	endif()
	
	find_path(${target}_INCLUDE_DIR
		NAMES
			"${lib_name}/${lib_name}.h"
			"lib${lib_name}/${lib_name}.h"
		PATH_SUFFIXES
			"include"
			"${lib_name}"
		HINTS
			${_inc_hints}
			${_hints}
		DOC "${target} include dir"
	)
	
	find_library(${target}_LIBRARY
		NAMES
			"${lib_name}"
			"lib${lib_name}"
		PATH_SUFFIXES
			"lib"
			"${lib_name}"
		HINTS
			${_lib_hints}
			${_hints}
		DOC "${target} library"
	)
	
endmacro(av_find_component)
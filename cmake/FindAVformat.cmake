# FindAVformat.cmake
# Tries to find avformat library
#
# Variable names are:
# * AVformat_LIBRARY
# * AVformat_FOUND
# * AVformat_INCLUDE_DIR
#
# Also defines INTERFACE IMPORTED target:
# * AVformat::AVformat
cmake_minimum_required(VERSION 3.1)
include(FindPackageHandleStandardArgs)

set(_target "AVformat")
set(_interface "${_target}::${_target}")

include("${CMAKE_CURRENT_LIST_DIR}/LibAVFindComponent.cmake")

av_find_component("avformat" ${_target})

find_package_handle_standard_args(${_target}
	DEFAULT_MSG
	${_target}_LIBRARY
	${_target}_INCLUDE_DIR
)

if(${${_target}_FOUND} AND NOT TARGET ${_interface})
	add_library(${_interface} INTERFACE IMPORTED)
	set_target_properties(${_interface} PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${${_target}_INCLUDE_DIR}"
		INTERFACE_LINK_LIBRARIES "${${_target}_LIBRARY}"
	)
endif()
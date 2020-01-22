cmake_minimum_required(VERSION 3.1)

find_package(AVcodec REQUIRED)
find_package(AVformat REQUIRED)
find_package(AVutil REQUIRED)
find_package(AVdevice REQUIRED)

add_executable(linkTesting
	"test.c"
)

target_link_libraries(linkTesting
	PRIVATE
	AVcodec::AVcodec
	AVformat::AVformat
	AVutil::AVutil
	AVdevice::AVdevice
)
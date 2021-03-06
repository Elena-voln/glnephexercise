cmake_minimum_required(VERSION 2.8.7)
project(libglnsvpos)

# Setup flags for Code Coverage build mode
set(CMAKE_CXX_FLAGS_COVERAGE "${CMAKE_CXX_FLAGS_DEBUG} --coverage" CACHE STRING
    "Flags used by the C++ compiler for building with code coverage."
    FORCE )
set(CMAKE_C_FLAGS_COVERAGE "${CMAKE_C_FLAGS_DEBUG} --coverage" CACHE STRING
    "Flags used by the C compiler for building with code coverage."
    FORCE )
SET(CMAKE_EXE_LINKER_FLAGS_COVERAGE
    "${CMAKE_EXE_LINKER_FLAGS_DEBUG} --coverage" CACHE STRING
    "Flags used for linking binaries with code coverage."
    FORCE )
set(CMAKE_SHARED_LINKER_FLAGS_COVERAGE
    "${CMAKE_SHARED_LINKER_FLAGS_DEBUG} --coverage" CACHE STRING
    "Flags used by the shared libraries linker during builds with code coverage."
    FORCE )
mark_as_advanced(
    CMAKE_CXX_FLAGS_COVERAGE
    CMAKE_C_FLAGS_COVERAGE
    CMAKE_EXE_LINKER_FLAGS_COVERAGE
    CMAKE_SHARED_LINKER_FLAGS_COVERAGE )
# Update the documentation string of CMAKE_BUILD_TYPE for GUIs
set(CMAKE_BUILD_TYPE "${CMAKE_BUILD_TYPE}" CACHE STRING
  "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel Coverage."
   FORCE )

# Set project version using Git tag and hash.
execute_process(
  COMMAND git describe --dirty --tags --always
  WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
  RESULT_VARIABLE GIT_VERSION_FOUND
  ERROR_QUIET
  OUTPUT_VARIABLE GIT_VERSION
  OUTPUT_STRIP_TRAILING_WHITESPACE
)
if (GIT_VERSION_FOUND)
  set(VERSION "unknown")
else (GIT_VERSION_FOUND)
  set(VERSION ${GIT_VERSION})
endif (GIT_VERSION_FOUND)

# Set project version explicitly for release tarballs.
#set(VERSION foo)

message(STATUS "libglnsvpos version: ${VERSION}")

cmake_minimum_required(VERSION 2.8)
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# Some compiler options used globally
#set(CMAKE_CXX_FLAGS "-Wall -Wextra -Werror -fPIC ${CMAKE_CXX_FLAGS}")
#set(CMAKE_CXX_FLAGS "-Wall -Wextra -fpermissive -fPIC ${CMAKE_CXX_FLAGS}")
# Own CXX FLAGS for the library
set(CMAKE_CXX_FLAGS "-Wall -Wextra -fpermissive -fPIC")


add_subdirectory(src)
add_subdirectory(test)

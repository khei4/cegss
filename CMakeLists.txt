cmake_minimum_required(VERSION 3.13.4)
project(cegss)

set(CMAKE_CXX_FLAGS "-Wall -march=native -fPIC ${CMAKE_CXX_FLAGS}")
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_COLOR_DIAGNOSTICS ON)

# include llvm
find_package(LLVM 17 REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")

include(AddLLVM)
include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# include Alive2
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
find_package(Alive2 REQUIRED)
message(STATUS "link ${ALIVE_LIBS} ${Z3_LIBRARIES} ${LLVM_LIBS} curl")

include_directories(${ALIVE2_SOURCE_DIR})

# include Z3
find_package(Z3 4.8.5 REQUIRED)

if(NOT Z3_FOUND)
    message(FATAL_ERROR "could not find Z3.")
endif()

if(NOT LLVM_ENABLE_RTTI)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")
endif()

if(NOT EXISTS "${LIBOAI_SOURCE_DIR}/liboai/include/liboai.h")
    message(FATAL_ERROR "liboai.h doesn't exist.")
endif()

include_directories("${LIBOAI_SOURCE_DIR}/liboai/include")

if(NOT EXISTS "${LIBOAI_SOURCE_DIR}/liboai/build/liboai.a")
    message(FATAL_ERROR "liboai.a doesn't exist.")
endif()

link_directories("${LIBOAI_SOURCE_DIR}/liboai/build")

get_property(link_dirs DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY LINK_DIRECTORIES)

foreach(dir IN LISTS link_dirs)
    message("Link Directory: ${dir}")
endforeach()

message(STATUS "link ${ALIVE_LIBS} ${Z3_LIBRARIES} ${LLVM_LIBS} oai curl")

# add_executable(identity main.cpp)
add_library(cegss SHARED main.cpp)

llvm_map_components_to_libnames(LLVM_LIBS
    analysis core irreader passes scalaropts support transformutils targetparser)
target_link_libraries(cegss ${ALIVE_LIBS} ${Z3_LIBRARIES} ${LLVM_LIBS} oai curl)

cmake_minimum_required(VERSION 3.13.4)
project(cegss)

set(CMAKE_CXX_FLAGS "-Wall -march=native -fPIC ${CMAKE_CXX_FLAGS}")
set(CMAKE_CXX_STANDARD 20)

# 1.1 Check the "include" directory
set(LLVM_INCLUDE_DIR "${LLVM_BUILD_DIR}/include/llvm")

if(NOT EXISTS "${LLVM_INCLUDE_DIR}")
    message(FATAL_ERROR
        " LLVM_BUILD_DIR (${LLVM_INCLUDE_DIR}) is invalid.")
endif()

# 1.2 Check that the LLVMConfig.cmake file exists
# Ubuntu + Darwin
if(NOT EXISTS "${LLVM_BUILD_DIR}/lib/cmake/llvm/LLVMConfig.cmake")
    message(FATAL_ERROR
        "LLVM installation directory, (${LLVM_BUILD_DIR}), is invalid. Couldn't
    find LLVMConfig.cmake.")
endif()

message(STATUS "Successfully found llvm cmake")

# include llvm
find_package(LLVM 16 REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")

include(AddLLVM)
include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# include Alive2
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
find_package(Alive2)
include_directories(${ALIVE2_SOURCE_DIR})

# include Z3
find_package(Z3 4.8.5 REQUIRED)

# include liboai
# list(APPEND CMAKE_MODULE_PATH "${LIBOAI_SOURCE_DIR}/liboai")
# find_package(oai REQUIRED)
if(NOT EXISTS "${LIBOAI_SOURCE_DIR}/liboai/include/liboai.h")
    message(FATAL_ERROR "liboai.h doesn't exist.")
endif()

include_directories("${LIBOAI_SOURCE_DIR}/liboai/include")

if(NOT EXISTS "${LIBOAI_SOURCE_DIR}/liboai/build/liboai.a")
    message(FATAL_ERROR "liboai.ar doesn't exist.")
endif()

link_directories("${LIBOAI_SOURCE_DIR}/liboai/build")

include_directories(include)

add_library(cegss SHARED main.cpp)

if(NOT LLVM_ENABLE_RTTI)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")
endif()

# add_executable(tmp main.cpp)
message(STATUS "link ${ALIVE_LIBS} ${Z3_LIBRARIES} ${LLVM_LIBS} oai curl")

# TODO: refine libs
llvm_map_components_to_libnames(LLVM_LIBS
    analysis core irreader passes scalaropts support transformutils targetparser)
target_link_libraries(cegss ${ALIVE_LIBS} ${Z3_LIBRARIES} ${LLVM_LIBS} oai curl)

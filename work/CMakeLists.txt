cmake_minimum_required(VERSION 3.14.0)

set(ProjName basic_test)

# GoogleTest requires at least C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(gtest_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/googletest-release-1.10.0/googletest)
set(CMAKE_TEST_BINARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/test)
set(CMAKE_BINARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/app)

################################
# Coverage
################################
include(cmake/clang_tools.cmake)

################################
# GTest
################################
# For Windows: Prevent overriding the parent project's compiler/linker settings
if (WIN32)
	set(optionThreadLib)
else()
# For Linux: Compile with pthread for GTest
	set(optionThreadLib pthread)
endif()

ADD_SUBDIRECTORY (googletest-release-1.10.0)
enable_testing()

################################
# Unit Tests
################################
# source files
set(test_source
 ${CMAKE_CURRENT_SOURCE_DIR}/tmp.cpp
 ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
)
# Add test cpp file
add_executable( runUnitTests "" )

# include files
set(__inc
${gtest_SOURCE_DIR}/include 
${gtest_SOURCE_DIR}
${CMAKE_CURRENT_SOURCE_DIR}
)

# unit test source files
set(__utsrc
${CMAKE_CURRENT_SOURCE_DIR}/tmp.cpp
${CMAKE_CURRENT_SOURCE_DIR}/unit_test_main.cpp
)

# source files
set(__src
${CMAKE_CURRENT_SOURCE_DIR}/tmp.cpp
${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
${CMAKE_CURRENT_SOURCE_DIR}/tmp.h
)

# Link test executable against gtest & gtest_main
target_link_libraries(runUnitTests gtest gtest_main ${optionThreadLib})
target_sources(runUnitTests PRIVATE ${__utsrc})
target_include_directories(runUnitTests PUBLIC ${__inc})
add_test( runUnitTests runUnitTests )

set_target_properties( runUnitTests
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_TEST_BINARY_DIR}/bin"
)

################################
# TMP Executable
################################
add_executable(${ProjName} "" )
target_sources(${ProjName} PRIVATE ${__src})
target_include_directories(${ProjName} PUBLIC ${__inc})

set_target_properties(${ProjName} 
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

cmake_minimum_required(VERSION VERSION 3.10 FATAL_ERROR)

# add custom modules path.
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/modules/ ${CMAKE_MODULE_PATH})

# The root project doesn't take any languages until after options have been processed.
project(helloActions LANGUAGES NONE)


# Define global options with defualt values.

# Enable compilation of code - to enable lint-only builds.
option(USE_CXX "Enable the use of a CXX compiler" ON)

# Enable building the subproject 
option(BUILD_HELLO_EXECUTABLE "Enable building the HelloExecutable subproject" ON)

# Enable Test builds
option(BUILD_TESTS "Enable building tests" OFF)

# Enable docs builds
option(BUILD_DOCS "Enable building documentation" ON)

# Enable linting via cpplint
option(USE_CPPLINT "Enable the use of cpplint for linting" OFF)

# Enable linting via clang-tidy
option(USE_CLANG_TIDY "Enable the use of clang-tidy for lintint" OFF)

# Enable formatting via clang-format
# option(USE_CLANG_FORMAT "Enable the use of clang-format for autoformatting?" OFF)

# Optionally use gtest_discover for google test-ctest integration
option(USE_GTEST_DISCOVER "Enable ctest googletest integration" OFF)

# Check which languages are avaialble, and enable them if so?
include(CheckLanguage)

# @todo - only do this some of the time? / process args propper.y
if(USE_CXX)
    enable_language(CXX)
endif()


# Process options, starting with finding things required before add_subdirectory
# If CPPLint is enabled, find it and create the custom target.
if(USE_CPPLINT)
    find_package(Cpplint REQUIRED)
    # include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/Cpplint.cmake)
    # # Register the all_cpplint target
    # Cpplint_register_global_target()
endif()

# If Clangtidy is enabled, find it and create the custom target.
if(USE_CLANG_TIDY)
    find_package(ClangTidy REQUIRED)
    # include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/ClangTidy.cmake)
    # ClangTidy_register_global_target()
endif()

# If ClangFormat is enabled, find it and create the custom target.
# if(USE_CLANG_FORMAT)
#     find_package(ClangFormat REQUIRED)
#     add_custom_target(all_clang_format)
#     set_target_properties(all_clang_format PROPERTIES EXCLUDE_FROM_ALL TRUE)
# endif()

# Add the library 
add_subdirectory(src)

# Add the executble subproject if required
if(BUILD_HELLO_EXECUTABLE)
    add_subdirectory(helloExecutable)
endif()

# Build the docs if required
if(BUILD_DOCS)
    # Find doxygen
    find_package(Doxygen REQUIRED OPTIONAL_COMPONENTS mscgen dia dot)
    # Find sphinx
    find_package(Sphinx REQUIRED)

    include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/doxygen.cmake)
    add_subdirectory(docs)
endif()


# If tests were requested, enable ctest and add the tests project?
if(BUILD_TESTS)
    # enable_testing() - This is only enabled if a test is to be added later.
    # If gtest discover is on, make sure it's available?
    if(USE_GTEST_DISCOVER)

    endif()

    add_subdirectory(tests)
endif()
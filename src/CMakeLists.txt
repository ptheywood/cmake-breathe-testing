# Project initially doesn't use a language, it is enabled later.
project(hello LANGUAGES NONE)


# Set variables with directory paths in.
set(INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../include")
set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}")

# Define source files early, so they can be used for linting without compilation.
set(SRC_INCLUDE
    ${INCLUDE_DIR}/hello/Hello.hpp
)

set(SRC
    ${SRC_DIR}/hello/Hello.cpp
)

set(ALL_SRC
    ${SRC_INCLUDE}
    ${SRC}
)

# If cpplint is enabled and found, 
if(USE_CPPLINT)
    # Include common/Cpplint.cmake for utility functions
    include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Cpplint.cmake)
    # Register this target and it's source files for cpplint, excluding certain files.
    Cpplint_register(
        TARGET
            ${PROJECT_NAME}
        FILES
            ${ALL_SRC}
        EXCLUDE_REGEX
            ".*/externals/.*;"
        # TRIGGER_ON_ALL
    )
endif()


# If using the languages required by this executable, enable and build - supports non-building executables.
if(USE_CXX)
    # Enable lanauges which are required if needed (i.e. not lint only)
    enable_language(CXX)

    # Include a file with all the common actions.
    include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/common.cmake)


    # Create the target library.
    add_library(${PROJECT_NAME} STATIC ${ALL_SRC})

    # Add the include directories to the library
    target_include_directories(${PROJECT_NAME} PUBLIC ${INCLUDE_DIR})

    # Make it fpic
    set_property(TARGET ${PROJECT_NAME} PROPERTY POSITION_INDEPENDENT_CODE ON)



    # Use clang tidy if possible. Requires compilers.
    if(USE_CLANG_TIDY)
        include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/ClangTidy.cmake)
        ClangTidy_register(
            TARGET
                ${PROJECT_NAME}
            SRC_FILES
                ${SRC}
            EXCLUDE_REGEX
                ".*/externals/.*;"
        )
    endif()

endif()


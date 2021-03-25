project(helloExecutable LANGUAGES NONE)

# Find the root of the repository.
set(REPO_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/..")

# Set variables with directory paths in.
set(INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")
set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")

# Define source files early, so they can be used for linting without compilation.
set(SRC_INCLUDE
)

set(SRC
    ${SRC_DIR}/main.cpp
)

set(ALL_SRC
    ${SRC_INCLUDE}
    ${SRC}
)

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
    )
endif()


if(USE_CXX)
    # Enable lanauges which are required if needed (i.e. not lint only)
    enable_language(CXX)

    # Include a file with all the common actions.
    include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/common.cmake)

    # If the library is not a target, it needs to be added.
    if (NOT TARGET hello)
        add_subdirectory("${REPO_ROOT}/src" "${PROJECT_ROOT}/hello")
    endif()

    # Create the executable
    add_executable(${PROJECT_NAME} ${ALL_SRC})

    # Add the include directories to the library
    # target_include_directories(${PROJECT_NAME} PUBLIC ${INCLUDE_DIR})

    # Link against the library.
    target_link_libraries(${PROJECT_NAME} hello)


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
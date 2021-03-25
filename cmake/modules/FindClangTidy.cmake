#[=======================================================================[.rst:
FindClangTidy
-----------

Finds clang-tidy - a clang-based C++ “linter” tool.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following targets, if found:
``ClangTidy::clang-tidy``
  The clang-tidy tool

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``ClangTidy_FOUND``
  True if the system has clang-tidy installed 
``ClangTidy_VERSION``
  The version of clang-tidy which was found
``ClangTidy_EXECUTABLE``
  The fully qualified path to the clang-tidy executbale which was found


Cache Variables
^^^^^^^^^^^^^^^

The following cache variable smay also be set:

#]=======================================================================]


# Search for the clang-tidy executable
find_program(
    ClangTidy_EXECUTABLE
    NAMES clang-tidy
    # PATHS
    DOC "clang-tidy - a clang-based C++ “linter” tool"
)
mark_as_advanced(ClangTidy_EXECUTABLE)


# If we found the executable, find more info
if(ClangTidy_EXECUTABLE)
    # Extract the version number from clang-tidy --version
    execute_process(
        COMMAND "${ClangTidy_EXECUTABLE}" --version
        OUTPUT_VARIABLE ClangTidy_VERSION_STDOUT
        RESULT_VARIABLE ClangTidy_version_result
    )
    if(ClangTidy_version_result)
        # If non-zero return code, otput a warning
        message(WARNING "Unable to determine clang-tidy version: ${ClangTidy_version_result}")
    else()
        # Extract the version string from the version stdout via regex + substr
        string(
            REGEX MATCH 
            "([0-9]+\.[0-9]+\.[0-9]+)"
            ClangTidy_VERSION
            "${ClangTidy_VERSION_STDOUT}"
        )
    endif()

    # Create an imported target
    if(NOT TARGET ClangTidy::clang-tidy)
        add_executable(ClangTidy::clang-tidy IMPORTED GLOBAL)
        set_target_properties(ClangTidy::clang-tidy PROPERTIES
            IMPORTED_LOCATION "${ClangTidy_EXECUTABLE}"
        )
    endif()
endif()

# Register the package.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    ClangTidy
    REQUIRED_VARS 
        ClangTidy_EXECUTABLE
    VERSION_VAR 
        ClangTidy_VERSION
)
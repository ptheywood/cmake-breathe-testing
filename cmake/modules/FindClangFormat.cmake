#[=======================================================================[.rst:
FindClangFormat
-----------

Finds clang-format - a clang-based C++ “linter” tool.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following targets, if found:
``ClangFormat::clang-format``
  The clang-format tool

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``ClangFormat_FOUND``
  True if the system has clang-format installed 
``ClangFormat_VERSION``
  The version of clang-format which was found
``ClangFormat_EXECUTABLE``
  The fully qualified path to the clang-format executbale which was found


Cache Variables
^^^^^^^^^^^^^^^

The following cache variable smay also be set:

#]=======================================================================]


# Search for the clang-format executable
find_program(
    ClangFormat_EXECUTABLE
    NAMES clang-format
    # PATHS
    DOC "clang-format - a clang-based C++ “linter” tool"
)
mark_as_advanced(ClangFormat_EXECUTABLE)


# If we found the executable, find more info
if(ClangFormat_EXECUTABLE)
    # Extract the version number from clang-format --version
    execute_process(
        COMMAND "${ClangFormat_EXECUTABLE}" --version
        OUTPUT_VARIABLE ClangFormat_VERSION_STDOUT
        RESULT_VARIABLE ClangFormat_version_result
    )
    if(ClangFormat_version_result)
        # If non-zero return code, otput a warning
        message(WARNING "Unable to determine clang-format version: ${ClangFormat_version_result}")
    else()
        # Extract the version string from the version stdout via regex + substr
        string(
            REGEX MATCH 
            "([0-9]+\.[0-9]+\.[0-9]+)"
            ClangFormat_VERSION
            "${ClangFormat_VERSION_STDOUT}"
        )
    endif()

    # Create an imported target
    if(NOT TARGET ClangFormat::clang-format)
        add_executable(ClangFormat::clang-format IMPORTED GLOBAL)
        set_target_properties(ClangFormat::clang-format PROPERTIES
            IMPORTED_LOCATION "${ClangFormat_EXECUTABLE}"
        )
    endif()
endif()

# Register the package.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    ClangFormat
    REQUIRED_VARS 
        ClangFormat_EXECUTABLE
    VERSION_VAR 
        ClangFormat_VERSION
)
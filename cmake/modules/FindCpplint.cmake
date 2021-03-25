#[=======================================================================[.rst:
FindCpplint
-----------

Finds the cpplint static code checker for c++ (https://github.com/cpplint/cpplint).

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following targets, if found:
``Cpplint::cpplint``
  The cpplint tool

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``Cpplint_FOUND``
  True if the system has cpplint installed 
``Cpplint_VERSION``
  The version of cpplint which was found
``Cpplint_EXECUTABLE``
  The fully qualified path to the cpplint executbale which was found


Cache Variables
^^^^^^^^^^^^^^^

The following cache variable smay also be set:

#]=======================================================================]


# Search for the cpplint executable
find_program(
    Cpplint_EXECUTABLE
    NAMES cpplint
    # PATHS
    DOC "cpplint static code checker for c++ (https://github.com/cpplint/cpplint)"
)
mark_as_advanced(Cpplint_EXECUTABLE)


# If we found the executable, find more info
if(Cpplint_EXECUTABLE)
    # Extract the version number from cpplint --version
    execute_process(
        COMMAND "${Cpplint_EXECUTABLE}" --version
        OUTPUT_VARIABLE Cpplint_VERSION_STDOUT
        RESULT_VARIABLE Cpplint_version_result
    )
    if(Cpplint_version_result)
        # If non-zero return code, otput a warning
        message(WARNING "Unable to determine cpplint version: ${Cpplint_version_result}")
    else()
        if(Cpplint_VERSION_STDOUT MATCHES "cpplint ([0-9]+\.[0-9]+\.[0-9]+)")
            set(Cpplint_VERSION "${CMAKE_MATCH_1}")
        else()
            set(Cpplint_VERSION "unknown")
        endif()
    endif()

    # Create an imported target
    if(NOT TARGET Cpplint::cpplint)
        add_executable(Cpplint::cpplint IMPORTED GLOBAL)
        set_target_properties(Cpplint::cpplint PROPERTIES
            IMPORTED_LOCATION "${Cpplint_EXECUTABLE}"
        )
    endif()
endif()

# Register the package.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    Cpplint
    REQUIRED_VARS 
        Cpplint_EXECUTABLE
    VERSION_VAR 
        Cpplint_VERSION
)

mark_as_advanced(Cpplint_EXECUTABLE Cpplint_VERSION Cpplint_FOUND)


# unset(Cpplint_version_result)
#[=======================================================================[.rst:
FindSphinx
-----------

Finds the sphinx static code checker for c++ (https://github.com/sphinx/sphinx).

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following targets, if found:
``sphinx::sphinx``
  The sphinx tool

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``sphinx_FOUND``
  True if the system has sphinx installed 
``sphinx_VERSION``
  The version of sphinx which was found
``sphinx_EXECUTABLE``
  The fully qualified path to the sphinx executbale which was found


Cache Variables
^^^^^^^^^^^^^^^

The following cache variable smay also be set:

#]=======================================================================]

# Search for the sphinx executable
find_program(
    Sphinx_EXECUTABLE
    NAMES sphinx-build
    DOC "sphinx-build documentation generator")
mark_as_advanced(Sphinx_EXECUTABLE)

# If we found the executable, find more info
if(Sphinx_EXECUTABLE)
    # Extract the version number from cpplint --version
    execute_process(
        COMMAND "${Sphinx_EXECUTABLE}" --version
        OUTPUT_VARIABLE Sphinx_VERSION_STDOUT
        RESULT_VARIABLE Sphinx_version_result
    )
    if(Sphinx_version_result)
        # If non-zero return code, otput a warning
        message(WARNING "Unable to determine sphinx version: ${Sphinx_version_result}")
    else()
        # Extract the version string from the version stdout via regex + substr
        if(Sphinx_VERSION_STDOUT MATCHES "sphinx-build ([0-9]+\.[0-9]+\.[0-9]+)")
            set(Sphinx_VERSION "${CMAKE_MATCH_1}")
        else()
            set(Sphinx_VERSION "unknown")
        endif()
    endif()

    # Create an imported target
    if(NOT TARGET Sphinx::sphinx)
        add_executable(Sphinx::sphinx IMPORTED GLOBAL)
        set_target_properties(Sphinx::sphinx PROPERTIES
            IMPORTED_LOCATION "${Sphinx_EXECUTABLE}"
        )
    endif()
endif()

# Register the package.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    Sphinx
    REQUIRED_VARS 
        Sphinx_EXECUTABLE
    VERSION_VAR 
        Sphinx_VERSION
)

mark_as_advanced(Sphinx_EXECUTABLE Sphinx_VERSION Sphinx_FOUND)


# unset(Sphinx_version_result)
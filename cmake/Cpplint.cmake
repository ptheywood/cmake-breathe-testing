#[=======================================================================[.rst:
Cpplint.cmake
-------------

Provides macros/functions to enable the use of cpplint.

#]=======================================================================]

# Variables
set(ALL_CPPLINT_TARGET "all_cpplint")

# Set cpplint output format, to be os specific.
set(Cpplint_OUTPUT_FORMAT "emacs")
if(CMAKE_GENERATOR MATCHES "Visual Studio")
    set(Cpplint_OUTPUT_FORMAT "vs7")
endif()

include (CMakeParseArguments)

# Function to register the all_cppling target 
# @todo document.
function(Cpplint_register_global_target)
    # Define function otions
    set(options TRIGGER_ON_ALL)
    set(oneValueArgs)
    set(multiValueArgs)
    # Parse arguments
    cmake_parse_arguments(Cpplint_register_global_target "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    # If the all_cpplint target exists, add to it.
    # @todo - better handling of ALL?
    if(NOT TARGET ${ALL_CPPLINT_TARGET})
        add_custom_target(${ALL_CPPLINT_TARGET} ALL)
        if(NOT Cpplint_register_global_target_TRIGGER_ON_ALL)
            set_target_properties(${ALL_CPPLINT_TARGET} PROPERTIES EXCLUDE_FROM_ALL TRUE)
        endif()
    endif()
endfunction()

# Function to register a target and source files for cpplinting.
# @todo document
function(Cpplint_register)
    # Define function otions
    set(options TRIGGER_ON_ALL)
    set(oneValueArgs TARGET)
    set(multiValueArgs FILES EXCLUDE_REGEX)
    # Parse arguments
    cmake_parse_arguments(Cpplint_register "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    # Exclude files from the list based on EXCLUDE_REGEX
    if(Cpplint_register_EXCLUDE_REGEX)
        foreach(exclude_regex IN LISTS Cpplint_register_EXCLUDE_REGEX)
            list(FILTER Cpplint_register_FILES EXCLUDE REGEX ${exclude_regex})
        endforeach()
    endif()

    # Set the name of the new target
    set(NEW_CPPLINT_TARGET "cpplint_${Cpplint_register_TARGET}")

    if(NOT TARGET ${NEW_CPPLINT_TARGET})
        # Add a custom target which executes cpplint using the appropriate format
        add_custom_target(
            "${NEW_CPPLINT_TARGET}"
            ALL
            COMMAND ${Cpplint_EXECUTABLE} "--output" "${Cpplint_OUTPUT_FORMAT}"
            ${Cpplint_register_FILES}
        )

        # Don't trigger it on make all, unless requested
        if(NOT Cpplint_register_TRIGGER_ON_ALL)
            set_target_properties("${NEW_CPPLINT_TARGET}" PROPERTIES EXCLUDE_FROM_ALL TRUE)
        endif()

        # If the all_cpplint target exists, add to it.
        if(NOT TARGET ${ALL_CPPLINT_TARGET})
            Cpplint_register_global_target()
        endif()
        add_dependencies(${ALL_CPPLINT_TARGET} ${NEW_CPPLINT_TARGET})
    endif()

endfunction()

# Keep the cache clean?
# @todo
# Make sure that requirements have been found.
find_package(Doxygen REQUIRED OPTIONAL_COMPONENTS mscgen dia dot)
find_package(Sphinx REQUIRED)



# Rather than 
function(create_doxygen_target NAME REPOSITORY_ROOT DOXY_OUT_DIR HTML_PATH XML_PATH INPUT_FILES)
    # Modern method which generates unique doxyfile
    # These args taken from readme.md at time of commit
    set(DOXYGEN_OUTPUT_DIRECTORY "${DOXY_OUT_DIR}")
    set(DOXYGEN_PROJECT_NAME "HelloActions")
    set(DOXYGEN_PROJECT_NUMBER "")
    set(DOXYGEN_PROJECT_BRIEF "Testing documentation generation using doxygen, breathe, sphinx ")
    set(DOXYGEN_GENERATE_LATEX        NO)
    set(DOXYGEN_EXTRACT_ALL           YES)
    set(DOXYGEN_CLASS_DIAGRAMS        YES)
    set(DOXYGEN_HIDE_UNDOC_RELATIONS  NO)
    set(DOXYGEN_CLASS_GRAPH           YES)
    set(DOXYGEN_COLLABORATION_GRAPH   YES)
    set(DOXYGEN_UML_LOOK              YES)
    set(DOXYGEN_UML_LIMIT_NUM_FIELDS  50)
    set(DOXYGEN_TEMPLATE_RELATIONS    YES)
    set(DOXYGEN_DOT_GRAPH_MAX_NODES   100)
    set(DOXYGEN_MAX_DOT_GRAPH_DEPTH   0)
    set(DOXYGEN_DOT_TRANSPARENT       NO)
    set(DOXYGEN_CALL_GRAPH            YES)
    set(DOXYGEN_CALLER_GRAPH          YES)
    set(DOXYGEN_GENERATE_TREEVIEW     YES)
    set(DOXYGEN_DOT_IMAGE_FORMAT      png) # can be  svg, but the add --> DOXYGEN_INTERACTIVE_SVG      = YES
    set(DOXYGEN_EXTRACT_PRIVATE       YES)
    set(DOXYGEN_EXTRACT_STATIC        YES)
    set(DOXYGEN_EXTRACT_LOCAL_METHODS NO)
    set(DOXYGEN_FILE_PATTERNS         
        "*.h" 
        "*.cuh" 
        "*.c" 
        "*.cpp" 
        "*.cu" 
        "*.cuhpp" 
        "*.md" 
        "*.hh" 
        "*.hxx" 
        "*.hpp" 
        "*.h++" 
        "*.cc" 
        "*.cxx" 
        "*.c++")
    set(DOXYGEN_EXTENSION_MAPPING
        "cu=C++" 
        "cuh=C++" 
        "cuhpp=C++")
    # These are required for expanding FGPUException definition macros to be documented
    set(DOXYGEN_ENABLE_PREPROCESSING  YES)
    set(DOXYGEN_MACRO_EXPANSION       YES)
    set(DOXYGEN_EXPAND_ONLY_PREDEF    YES)
    set(DOXYGEN_PREDEFINED            "")
    set(DOXY_INPUT_FILES              ${INPUT_FILES})
    # Create doxygen target            
    if("${XML_PATH}" STREQUAL "")
        set(DOXYGEN_GENERATE_HTML     YES)
        set(DOXYGEN_GENERATE_XML      NO)
        set(DOXYGEN_HTML_OUTPUT       "${HTML_PATH}")
        doxygen_add_docs("${NAME}" "${DOXY_INPUT_FILES}")
        set_target_properties("${NAME}" PROPERTIES EXCLUDE_FROM_ALL TRUE)
        if(COMMAND CMAKE_SET_TARGET_FOLDER)
            # Put within FLAMEGPU filter
            # CMAKE_SET_TARGET_FOLDER("${NAME}" "FLAMEGPU")
        endif()
    else()
        set(DOXYGEN_GENERATE_HTML     NO)
        set(DOXYGEN_GENERATE_XML      YES)
        set(DOXYGEN_XML_OUTPUT        "${XML_PATH}")
        doxygen_add_docs("${NAME}_xml" "${DOXY_INPUT_FILES}")
        set_target_properties("${NAME}_xml" PROPERTIES EXCLUDE_FROM_ALL TRUE)
        if(COMMAND CMAKE_SET_TARGET_FOLDER)
            # Put within FLAMEGPU filter
            # CMAKE_SET_TARGET_FOLDER("${NAME}_xml" "FLAMEGPU")
        endif()

        # Make the output directory which doxygen will not do.
        file(MAKE_DIRECTORY ${DOXYGEN_OUTPUT_DIR}) 

    endif()
endfunction()

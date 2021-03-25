get_filename_component(REPOSITORY_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../ REALPATH)
include(${REPOSITORY_ROOT}/cmake/doxygen.cmake)

create_doxygen_target("${REPOSITORY_ROOT}" "${CMAKE_CURRENT_BINARY_DIR}" "")

get_filename_component(REPOSITORY_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../ REALPATH)
include(${REPOSITORY_ROOT}/cmake/doxygen.cmake)

# See https://github.com/TartanLlama/cpp-documentation-example/blob/master/docs/CMakeLists.txt for some inspiration.

create_doxygen_target(
    "doxygen_public"
    "${REPOSITORY_ROOT}" 
    "${CMAKE_CURRENT_BINARY_DIR}"
    "${CMAKE_CURRENT_BINARY_DIR}/doxygen_publie_html/" 
    ""
    "${REPOSITORY_ROOT}/include;${REPOSITORY_ROOT}/src;${REPOSITORY_ROOT}/README.md;${REPOSITORY_ROOT}/docs/"
)

create_doxygen_target(
    "doxygen_private"
    "${REPOSITORY_ROOT}" 
    "${CMAKE_CURRENT_BINARY_DIR}"
    "${CMAKE_CURRENT_BINARY_DIR}/doxygen_private_html/" 
    ""
    "${REPOSITORY_ROOT}/src;"
)

create_doxygen_target(
    "doxygen_helloExecutable"
    "${REPOSITORY_ROOT}" 
    "${CMAKE_CURRENT_BINARY_DIR}"
    "${CMAKE_CURRENT_BINARY_DIR}/doxygen_helloExecutable_html/" 
    ""
    "${REPOSITORY_ROOT}/helloExecutable/;"
)

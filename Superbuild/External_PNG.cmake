IF(PNG_DIR)
  # PNG has been built already
  FIND_PACKAGE(PNG REQUIRED)
  
  MESSAGE(STATUS "Using libpng available at: ${PNG_DIR}")
  
  SET(RobartsVTK_PNG_DIR ${PNG_DIR})
ELSE()
  # libpng has not been built yet, so download and build it as an external project

  SET(libpng_GIT_REPOSITORY "github.com/glennrp/libpng.git")
  SET(libpng_GIT_TAG "v1.6.22rc03")

  MESSAGE(STATUS "Downloading and building libpng from: ${GIT_PROTOCOL}://${libpng_GIT_REPOSITORY}")

  SET (RobartsVTK_PNG_SRC_DIR "${ep_dependency_DIR}/libpng")
  SET (RobartsVTK_PNG_DIR "${ep_dependency_DIR}/libpng-bin" CACHE INTERNAL "Path to store libpng binaries")
  ExternalProject_Add( libpng
    PREFIX "${ep_dependency_DIR}/libpng-prefix"
    SOURCE_DIR "${RobartsVTK_PNG_SRC_DIR}"
    BINARY_DIR "${RobartsVTK_PNG_DIR}"
    #--Download step--------------
    GIT_REPOSITORY ${GIT_PROTOCOL}://${libpng_GIT_REPOSITORY}
    GIT_TAG ${libpng_GIT_TAG}
    #--Configure step-------------
    CMAKE_ARGS 
        ${ep_common_args}
        -DCMAKE_INSTALL_PREFIX:PATH=${RobartsVTK_PNG_DIR}/install
        -DCMAKE_RUNTIME_OUTPUT_DIRECTORY:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
        -DCMAKE_LIBRARY_OUTPUT_DIRECTORY:PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
        -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:PATH=${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}
        -DZLIB_ROOT:PATH=${ZLIB_ROOT}
    DEPENDS ${libpng_DEPENDENCIES}
    )

ENDIF()
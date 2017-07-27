IF(ITK_DIR)
  # ITK has been built already
  FIND_PACKAGE(ITK REQUIRED NO_MODULE PATHS ${ITK_DIR} NO_DEFAULT_PATH)
  
  # TODO : Check that the ITK provided is configured in such a way that is acceptable to use

  MESSAGE(STATUS "Using ITK available at: ${ITK_DIR}")
  
  SET(RobartsVTK_ITK_DIR ${ITK_DIR})
ELSE()
  # ITK has not been built yet, so download and build it as an external project
  SET (ITKv4_REPOSITORY ${GIT_PROTOCOL}://itk.org/ITK.git)
  SET (ITKv4_GIT_TAG v4.10.0)
  
  MESSAGE(STATUS "Downloading and building ITK ${ITKv4_GIT_TAG} from: ${GIT_PROTOCOL}://itk.org/ITK.git")

  SET (RobartsVTK_ITK_SRC_DIR "${ep_dependency_DIR}/itk")
  SET (RobartsVTK_ITK_DIR "${ep_dependency_DIR}/itk-bin" CACHE INTERNAL "Path to store itk binaries")
  ExternalProject_Add( itk
    PREFIX "${ep_dependency_DIR}/itk-prefix"
    SOURCE_DIR "${RobartsVTK_ITK_SRC_DIR}"
    BINARY_DIR "${RobartsVTK_ITK_DIR}"
    #--Download step--------------
    GIT_REPOSITORY "${ITKv4_REPOSITORY}"
    GIT_TAG "${ITKv4_GIT_TAG}"
    #--Configure step-------------
    CMAKE_ARGS 
      ${ep_common_args}
      -DCMAKE_RUNTIME_OUTPUT_DIRECTORY:PATH=${CMAKE_BINARY_DIR}/bin
      -DCMAKE_LIBRARY_OUTPUT_DIRECTORY:PATH=${CMAKE_BINARY_DIR}/bin
      -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:PATH=${CMAKE_BINARY_DIR}/lib
      -DBUILD_SHARED_LIBS:BOOL=ON
      -DBUILD_TESTING:BOOL=OFF
      -DBUILD_EXAMPLES:BOOL=OFF
      -DKWSYS_USE_MD5:BOOL=ON
      -DITK_USE_REVIEW:BOOL=ON
      -DCMAKE_CXX_FLAGS:STRING=${ep_common_cxx_flags}
      -DCMAKE_C_FLAGS:STRING=${ep_common_c_flags}
      -DITK_WRAP_PYTHON:BOOL=OFF
      -DITK_LEGACY_REMOVE:BOOL=ON
      -DITK_LEGACY_SILENT:BOOL=ON
      -DKWSYS_USE_MD5:BOOL=ON
    #--Build step-----------------
    #--Install step-----------------
    INSTALL_COMMAND ""
    DEPENDS ${ITK_DEPENDENCIES}
    )

ENDIF()
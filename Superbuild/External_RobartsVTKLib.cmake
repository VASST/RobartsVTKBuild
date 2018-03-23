#-----------------------------------------------------------------------------
# RobartsVTKLib

SET(RobartsVTK_SRC_DIR "${CMAKE_BINARY_DIR}/RVTKLib")
SET(RobartsVTK_BIN_DIR "${CMAKE_BINARY_DIR}/RVTKLib-bin" CACHE INTERNAL "Path to store RobartsVTK binaries")
ExternalProject_Add( RobartsVTKLib
  PREFIX "${CMAKE_BINARY_DIR}/RVTKLib-prefix"
  SOURCE_DIR "${RobartsVTK_SRC_DIR}"
  BINARY_DIR "${RobartsVTK_BIN_DIR}"
  #--Download step--------------
  GIT_REPOSITORY https://github.com/VASST/RobartsVTK.git
  GIT_TAG master
  #--Configure step-------------
  CMAKE_ARGS
    -DRobartsVTK_USE_QT:BOOL=${RobartsVTK_USE_QT}
    -DRobartsVTK_USE_ITK:BOOL=${RobartsVTK_USE_ITK}
    -DRobartsVTK_USE_PLUS:BOOL=${RobartsVTK_USE_PLUS}
    -DRobartsVTK_USE_REGISTRATION:BOOL=${RobartsVTK_USE_REGISTRATION}
    -DRobartsVTK_USE_COMMON:BOOL=${RobartsVTK_USE_COMMON}
    -DRobartsVTK_USE_CUDA:BOOL=${RobartsVTK_USE_CUDA}
    -DRobartsVTK_USE_CUDA_VISUALIZATION:BOOL=${RobartsVTK_USE_CUDA_VISUALIZATION}
    -DRobartsVTK_USE_VISUALIZATION:BOOL=${RobartsVTK_USE_VISUALIZATION}
    -DRobartsVTK_USE_OpenCL:BOOL=${RobartsVTK_USE_OpenCL}
    -DRobartsVTK_USE_CL_VOLUMERECONSTRUCTION:BOOL=${RobartsVTK_USE_CL_VOLUMERECONSTRUCTION}
    -DRobartsVTK_USE_CUDA_ANALYTICS:BOOL=${RobartsVTK_USE_CUDA_ANALYTICS}
    -DRobartsVTK_BUILD_APPS:BOOL=${RobartsVTK_BUILD_APPS}
    -DRobartsVTK_Data_DIR:PATH=${RobartsVTK_Data_DIR}
    -DCMAKE_RUNTIME_OUTPUT_DIRECTORY:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    -DCMAKE_LIBRARY_OUTPUT_DIRECTORY:PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
    -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:PATH=${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DBUILD_TESTING:BOOL=${BUILD_TESTING}
    -DBUILD_DOCUMENTATION:BOOL=${BUILD_DOCUMENTATION}
    -DCMAKE_CXX_FLAGS:STRING=${ep_common_cxx_flags}
    -DCMAKE_C_FLAGS:STRING=${ep_common_c_flags}
    ${RobartsVTKLib_PROJECT_ARGS}
    ${OpenCV_Dependency_Arg}
  #--Build step-----------------
  #--Install step-----------------
  INSTALL_COMMAND "" # Do not install
  DEPENDS ${RobartsVTKLib_DEPENDENCIES}
  )
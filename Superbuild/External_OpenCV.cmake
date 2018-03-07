IF(OpenCV_DIR)
  FIND_PACKAGE(OpenCV 3.2.0 REQUIRED NO_MODULE PATHS ${OpenCV_DIR})

  MESSAGE(STATUS "Using OpenCV available at: ${OpenCV_DIR}")

  SET(RobartsVTK_OpenCV_DIR ${OpenCV_DIR} CACHE Internal "Path to OpenCV contents.")
ELSE()
  MESSAGE(STATUS "Downloading and building OpenCV from: https://github.com/opencv/opencv.git")

  SET(EXTRA_OPENCV_ARGS)
  FIND_PACKAGE(CUDA QUIET)

  IF(NOT CUDA_FOUND)
    LIST(APPEND EXTRA_OPENCV_ARGS -DWITH_CUDA:BOOL=OFF)
  ELSE()
    LIST(APPEND EXTRA_OPENCV_ARGS
      -DWITH_CUDA:BOOL=ON
      -DCUDA_GENERATION:STRING=${CUDA_GENERATION}
      -DBUILD_opencv_cudalegacy:BOOL=OFF
      -DCUDA_TOOLKIT_ROOT_DIR:PATH=${CUDA_TOOLKIT_ROOT_DIR})
  ENDIF()

  FIND_PACKAGE(Qt5 COMPONENTS Widgets Gui Core Concurrent OpenGL Test)

  IF( Qt5_FOUND )
    LIST(APPEND EXTRA_OPENCV_ARGS -DWITH_QT:BOOL=ON
      -DQt5_DIR:PATH=${Qt5_DIR}
      -DQt5Widgets_DIR:PATH=${Qt5Widgets_DIR}
      -DQt5Gui_DIR:PATH=${Qt5Gui_DIR}
      -DQt5Core_DIR:PATH=${Qt5Core_DIR}
      -DQt5Concurrent_DIR:PATH=${Qt5Concurrent_DIR}
      -DQt5OpenGL_DIR:PATH=${Qt5OpenGL_DIR}
      -DQt5Test_DIR:PATH=${Qt5Test_DIR})
  ENDIF()

  LIST(APPEND EXTRA_OPENCV_ARGS -DBUILD_opencv_python2:BOOL=OFF)

  IF( ${CMAKE_GENERATOR} MATCHES "Visual Studio 11" )
    SET(ep_common_cxx_flags "${ep_common_cxx_flags} /D_VARIADIC_MAX=10")
  ENDIF()

  SET (RobartsVTK_OpenCV_SRC_DIR ${ep_dependency_DIR}/OpenCV CACHE INTERNAL "Path to store OpenCV source.")
  SET (RobartsVTK_OpenCV_DIR ${ep_dependency_DIR}/OpenCV-bin CACHE INTERNAL "Path to store OpenCV contents.")
  ExternalProject_Add(OpenCV
    PREFIX "${ep_dependency_DIR}/OpenCV-prefix"
    SOURCE_DIR "${RobartsVTK_OpenCV_SRC_DIR}"
    BINARY_DIR "${RobartsVTK_OpenCV_DIR}"
    #--Download step--------------
    GIT_REPOSITORY https://github.com/opencv/opencv.git
    GIT_TAG 8edc2e5aaffa8c349ff9184ae77b3cccdea7cf6e
    #--Configure step-------------
    CMAKE_ARGS
      ${ep_common_args}
      -DCMAKE_C_FLAGS=${ep_common_c_flags}
      -DCMAKE_CXX_FLAGS=${ep_common_cxx_flags}
      -DBUILD_SHARED_LIBS:BOOL=ON
      -DBUILD_TESTS:BOOL=OFF
      -DBUILD_PERF_TESTS:BOOL=OFF
      -DEXECUTABLE_OUTPUT_PATH:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
      -DCMAKE_RUNTIME_OUTPUT_DIRECTORY:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
      -DCMAKE_LIBRARY_OUTPUT_DIRECTORY:PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
      -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:PATH=${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}
      -DBUILD_DOCS:BOOL=OFF
      -DVTK_DIR:PATH=${RobartsVTK_VTK_DIR}
      -DWITH_OPENGL:BOOL=ON
      -DWITH_VFW:BOOL=OFF
      -DWITH_MSMF:BOOL=ON
      ${QT_ARG}
      ${EXTRA_OPENCV_ARGS}
    #--Install step-----------------
    INSTALL_COMMAND "" # Do not install
    DEPENDS vtk
    )
ENDIF()

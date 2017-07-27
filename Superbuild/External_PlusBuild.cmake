IF(PlusLib_DIR OR PlusApp_DIR)
  FIND_PACKAGE(PlusLib REQUIRED NO_MODULE PATHS ${PlusLib_DIR} PATH_SUFFIX src)
  FIND_PACKAGE(PlusApp REQUIRED NO_MODULE PATHS ${PlusApp_DIR})

  MESSAGE(STATUS "Using PlusLib available at: ${PlusLib_DIR}")
  MESSAGE(STATUS "Using PlusApp available at: ${PlusApp_DIR}")
  
  SET(RobartsVTK_PlusLib_BIN_DIR ${PlusLib_DIR})
  SET(RobartsVTK_PlusApp_BIN_DIR ${PlusApp_DIR})
ELSE()
  MESSAGE(STATUS "Downloading and building Plus from: https://subversion.assembla.com/svn/plus/trunk/PlusBuild")

  SET(Plus_Additional_Args)
  IF(RobartsVTK_BUILD_APPS)
    LIST(APPEND Plus_Additional_Args -DPLUSBUILD_BUILD_PLUSLIB_WIDGETS:BOOL=ON)
  ENDIF()

  SET (PLUS_SRC_DIR ${ep_dependency_DIR}/Plus CACHE INTERNAL "Path to store PlusBuild contents.")
  SET (PLUS_BIN_DIR ${ep_dependency_DIR}/Plus-bin CACHE INTERNAL "Path to store PlusBuild contents.")
  ExternalProject_Add(Plus
    PREFIX "${ep_dependency_DIR}/Plus-prefix"
    SOURCE_DIR "${PLUS_SRC_DIR}"
    BINARY_DIR "${PLUS_BIN_DIR}"
    #--Download step--------------
    GIT_REPOSITORY https://github.com/PlusToolkit/PlusBuild.git
    GIT_TAG "master"
    #--Configure step-------------
    CMAKE_ARGS 
      ${ep_common_args}
      -DVTK_DIR:PATH=${RobartsVTK_VTK_DIR}
      -DITK_DIR:PATH=${RobartsVTK_ITK_DIR}
      ${OpenCV_Dependency_Arg}
      -DBUILD_TESTING:BOOL=OFF
      -DPLUSBUILD_DOWNLOAD_PlusDATA:BOOL=OFF 
      -DBUILD_SHARED_LIBS:BOOL=ON
      -DPLUSBUILD_BUILD_PLUSAPP:BOOL=OFF
      -DQt5_DIR:PATH=${Qt5_DIR}
      -DCMAKE_CXX_FLAGS:STRING=${ep_common_cxx_flags}
      -DCMAKE_C_FLAGS:STRING=${ep_common_c_flags}    
      -DPLUSBUILD_USE_OpenIGTLink:BOOL=ON
      -DCMAKE_RUNTIME_OUTPUT_DIRECTORY:PATH=${CMAKE_BINARY_DIR}/bin
      -DCMAKE_LIBRARY_OUTPUT_DIRECTORY:PATH=${CMAKE_BINARY_DIR}/bin
      -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:PATH=${CMAKE_BINARY_DIR}/lib
      -DPLUS_USE_tesseract:BOOL=${PLUS_USE_tesseract}
      -DPLUS_USE_ULTRASONIX_VIDEO:BOOL=${PLUS_USE_ULTRASONIX_VIDEO}
      -DPLUS_USE_BKPROFOCUS_VIDEO:BOOL=${PLUS_USE_BKPROFOCUS_VIDEO}
      -DPLUS_USE_ICCAPTURING_VIDEO:BOOL=${PLUS_USE_ICCAPTURING_VIDEO}
      -DPLUS_USE_VFW_VIDEO:BOOL=${PLUS_USE_VFW_VIDEO}
      -DPLUS_USE_MMF_VIDEO:BOOL=${PLUS_USE_MMF_VIDEO}
      -DPLUS_USE_EPIPHAN:BOOL=${PLUS_USE_EPIPHAN}
      -DPLUS_USE_CAPISTRANO_VIDEO:BOOL=${PLUS_USE_CAPISTRANO_VIDEO}
      -DPLUS_USE_INTERSON_VIDEO:BOOL=${PLUS_USE_INTERSON_VIDEO}
      -DPLUS_USE_INTERSONSDKCXX_VIDEO:BOOL=${PLUS_USE_INTERSONSDKCXX_VIDEO}
      -DPLUS_USE_TELEMED_VIDEO:BOOL=${PLUS_USE_TELEMED_VIDEO}
      -DPLUS_USE_THORLABS_VIDEO:BOOL=${PLUS_USE_THORLABS_VIDEO}
      -DPLUS_USE_OPTITRACK:BOOL=${PLUS_USE_OPTITRACK}
      -DPLUS_USE_OPTIMET_CONOPROBE:BOOL=${PLUS_USE_OPTIMET_CONOPROBE}
      -DPLUS_USE_NDI:BOOL=${PLUS_USE_NDI}
      -DPLUS_USE_NDI_CERTUS:BOOL=${PLUS_USE_NDI_CERTUS}
      -DPLUS_USE_RTSP_VIDEO:BOOL=${PLUS_USE_RTSP_VIDEO}
      -DPLUS_USE_MICRONTRACKER:BOOL=${PLUS_USE_MICRONTRACKER}
      -DPLUS_USE_INTELREALSENSE:BOOL=${PLUS_USE_INTELREALSENSE}
      -DPLUS_USE_BRACHY_TRACKER:BOOL=${PLUS_USE_BRACHY_TRACKER}
      -DPLUS_USE_USDIGITALENCODERS_TRACKER:BOOL=${PLUS_USE_USDIGITALENCODERS_TRACKER}
      -DPLUS_USE_Ascension3DG:BOOL=${PLUS_USE_Ascension3DG}
      -DPLUS_USE_Ascension3DGm:BOOL=${PLUS_USE_Ascension3DGm}
      -DPLUS_USE_PHIDGET_SPATIAL_TRACKER:BOOL=${PLUS_USE_PHIDGET_SPATIAL_TRACKER}
      -DPLUS_USE_3dConnexion_TRACKER:BOOL=${PLUS_USE_3dConnexion_TRACKER}
      -DPLUS_USE_STEALTHLINK:BOOL=${PLUS_USE_STEALTHLINK}
      -DPLUS_USE_IntuitiveDaVinci:BOOL=${PLUS_USE_IntuitiveDaVinci}
      -DPLUS_USE_OvrvisionPro:BOOL=${PLUS_USE_OvrvisionPro}
      -DPLUS_USE_PHILIPS_3D_ULTRASOUND:BOOL=${PLUS_USE_PHILIPS_3D_ULTRASOUND}
      -DPLUS_USE_NVIDIA_DVP:BOOL=${PLUS_USE_NVIDIA_DVP}
      -DBUILD_DOCUMENTATION:BOOL=OFF
    #--Install step-----------------
    INSTALL_COMMAND "" # Do not install
    DEPENDS ${Plus_DEPENDENCIES}
    )
    
  SET(RobartsVTK_PlusLib_BIN_DIR ${PLUS_BIN_DIR}/PlusLib-bin)
  SET(RobartsVTK_PlusApp_BIN_DIR ${PLUS_BIN_DIR}/PlusApp-bin)
ENDIF()
IF(PlusLib_DIR)
  FIND_PACKAGE(PlusLib REQUIRED NO_MODULE PATHS ${PlusLib_DIR} PATH_SUFFIX src)

  MESSAGE(STATUS "Using PlusLib available at: ${PlusLib_DIR}")
ELSE()
  MESSAGE(STATUS "Downloading and building Plus from: https://subversion.assembla.com/svn/plus/trunk/PlusBuild")

  SET (PLUS_SRC_DIR ${ep_dependency_DIR}/Plus CACHE INTERNAL "Path to store PlusBuild contents.")
  SET (PLUS_BIN_DIR ${ep_dependency_DIR}/Plus-bin CACHE INTERNAL "Path to store PlusBuild contents.")
  ExternalProject_Add(Plus
    PREFIX "${ep_dependency_DIR}/Plus-prefix"
    SOURCE_DIR "${PLUS_SRC_DIR}"
    BINARY_DIR "${PLUS_BIN_DIR}"
    #--Download step--------------
    SVN_USERNAME ${PLUS_ASSEMBLA_USERNAME}
    SVN_PASSWORD ${PLUS_ASSEMBLA_PASSWORD}
    SVN_REPOSITORY https://subversion.assembla.com/svn/plus/trunk/PlusBuild
    #--Configure step-------------
    CMAKE_ARGS 
      ${ep_common_args}
      -DVTK_DIR:PATH=${VTK_DIR}
      -DITK_DIR:PATH=${ITK_DIR}
      -DBUILD_TESTING:BOOL=OFF
      -DBUILD_SHARED_LIBS:BOOL=ON
      -DPLUSBUILD_BUILD_PLUSAPP:BOOL=OFF
      -DQT_QMAKE_EXECUTABLE:FILEPATH=${QT_QMAKE_EXECUTABLE}
      -DQt5_DIR:PATH=${Qt5_DIR}
      -DCMAKE_CXX_FLAGS:STRING=${ep_common_cxx_flags}
      -DCMAKE_C_FLAGS:STRING=${ep_common_c_flags}    
      -DPLUS_USE_OpenIGTLink:BOOL=ON
      -DPLUS_USE_tesseract:BOOL=ON
      -DPLUS_USE_ULTRASONIX_VIDEO:BOOL=OFF
      -DPLUS_USE_BKPROFOCUS_VIDEO:BOOL=OFF
      -DPLUS_USE_BKPROFOCUS_CAMERALINK:BOOL=OFF
      -DPLUS_USE_ICCAPTURING_VIDEO:BOOL=OFF
      -DPLUS_USE_CAPISTRANO_VIDEO:BOOL=OFF
      -DPLUS_USE_INTERSON_VIDEO:BOOL=OFF
      -DPLUS_USE_INTERSONSDKCXX_VIDEO:BOOL=OFF
      -DPLUS_USE_TELEMED_VIDEO:BOOL=OFF
      -DPLUS_USE_THORLABS_VIDEO:BOOL=OFF
      -DPLUS_USE_VFW_VIDEO:BOOL=ON
      -DPLUS_USE_EPIPHAN:BOOL=ON
      -DPLUS_USE_POLARIS:BOOL=OFF
      -DPLUS_USE_CERTUS:BOOL=OFF
      -DPLUS_USE_MICRONTRACKER:BOOL=OFF
      -DPLUS_USE_OPTIMET_CONOPROBE:BOOL=OFF
      -DPLUS_USE_OPTITRACK:BOOL=OFF
      -DPLUS_USE_IntuitiveDaVinci:BOOL=OFF
      -DPLUS_USE_BRACHY_TRACKER:BOOL=OFF
      -DPLUS_USE_Ascension3DG:BOOL=OFF
      -DPLUS_USE_Ascension3DGm:BOOL=OFF
      -DPLUS_USE_PHIDGET_SPATIAL_TRACKER:BOOL=OFF
      -DPLUS_USE_3dConnexion_TRACKER:BOOL=OFF
      -DPLUS_USE_MMF_VIDEO:BOOL=ON
      -DPLUS_USE_STEALTHLINK:BOOL=OFF
      -DPLUS_USE_PHILIPS_3D_ULTRASOUND:BOOL=OFF
      -DBUILD_DOCUMENTATION:BOOL=OFF
    #--Install step-----------------
    INSTALL_COMMAND "" # Do not install
    DEPENDS ${Plus_DEPENDENCIES}
    )
ENDIF()
IF(WIN32 AND NOT UNIX)

    # Libs needed for packaging
    FIND_PACKAGE(ZLIB REQUIRED)
    FIND_PACKAGE(CURL REQUIRED)
    FIND_PACKAGE(Sword REQUIRED)

    SET(CPACK_PACKAGE_NAME "BibleTime")
    SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "BibleTime for Windows")
    SET(CPACK_PACKAGE_VENDOR "http://www.bibletime.info")
    SET(CPACK_PACKAGE_VERSION_MAJOR ${BT_VERSION_MAJOR})
    SET(CPACK_PACKAGE_VERSION_MINOR ${BT_VERSION_MINOR})
    SET(CPACK_PACKAGE_VERSION_PATCH ${BT_VERSION_PATCH})
    SET(CPACK_PACKAGE_INSTALL_DIRECTORY "BibleTime")

    SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
    # There is a bug in NSI that does not handle full unix paths properly. Make
    # sure there is at least one set of four (4) backlasshes.

    # We need the libraries, and they're not pulled in automatically
    SET(CMAKE_INSTALL_DEBUG_LIBRARIES TRUE)

    SET(QT_BINARY_DIR "${Qt5Core_DIR}/../../../bin")
    SET(QT_PLUGINS_DIR "${Qt5Core_DIR}/../../../plugins")
    INSTALL(FILES
        "${QT_BINARY_DIR}/icudt54.dll"
        "${QT_BINARY_DIR}/icuin54.dll"
        "${QT_BINARY_DIR}/icuuc54.dll"
        "${QT_BINARY_DIR}/libEGLd.dll"
        "${QT_BINARY_DIR}/libGLESv2d.dll"
        "${QT_BINARY_DIR}/Qt5Cored.dll"
        "${QT_BINARY_DIR}/Qt5Guid.dll"
        "${QT_BINARY_DIR}/Qt5Networkd.dll"
        "${QT_BINARY_DIR}/Qt5PrintSupportd.dll"
        "${QT_BINARY_DIR}/Qt5Qmld.dll"
        "${QT_BINARY_DIR}/Qt5Quickd.dll"
        "${QT_BINARY_DIR}/Qt5Svgd.dll"
        "${QT_BINARY_DIR}/Qt5WebChanneld.dll"
        "${QT_BINARY_DIR}/Qt5WebEngineCored.dll"
        "${QT_BINARY_DIR}/Qt5WebEngineWidgetsd.dll"
        "${QT_BINARY_DIR}/Qt5Widgetsd.dll"
        "${QT_BINARY_DIR}/Qt5Xmld.dll"
        "${QT_BINARY_DIR}/QtWebEngineProcess.exe"
        DESTINATION "${BT_DESTINATION}"
        CONFIGURATIONS "Debug"
    )
    INSTALL(FILES
        "${QT_BINARY_DIR}/icudt54.dll"
        "${QT_BINARY_DIR}/icuin54.dll"
        "${QT_BINARY_DIR}/icuuc54.dll"
        "${QT_BINARY_DIR}/libEGL.dll"
        "${QT_BINARY_DIR}/libGLESv2.dll"
        "${QT_BINARY_DIR}/Qt5Core.dll"
        "${QT_BINARY_DIR}/Qt5Gui.dll"
        "${QT_BINARY_DIR}/Qt5Network.dll"
        "${QT_BINARY_DIR}/Qt5PrintSupport.dll"
        "${QT_BINARY_DIR}/Qt5Qml.dll"
        "${QT_BINARY_DIR}/Qt5Quick.dll"
        "${QT_BINARY_DIR}/Qt5Svg.dll"
        "${QT_BINARY_DIR}/Qt5WebChannel.dll"
        "${QT_BINARY_DIR}/Qt5WebEngineCore.dll"
        "${QT_BINARY_DIR}/Qt5WebEngineWidgets.dll"
        "${QT_BINARY_DIR}/Qt5Widgets.dll"
        "${QT_BINARY_DIR}/Qt5Xml.dll"
        "${QT_BINARY_DIR}/QtWebEngineProcess.exe"
        "${QT_BINARY_DIR}/D3Dcompiler_47.dll"
        "${QT_BINARY_DIR}/opengl32sw.dll"
        "${QT_PLUGINS_DIR}/../resources/icudtl.dat"
        DESTINATION "${BT_DESTINATION}"
        CONFIGURATIONS "Release"
    )
    INSTALL(FILES
        "${QT_PLUGINS_DIR}/bearer/qgenericbearer.dll"
        "${QT_PLUGINS_DIR}/bearer/qnativewifibearer.dll"
        DESTINATION "${BT_DESTINATION}/bearer"
        CONFIGURATIONS "Release"
    )
    INSTALL(FILES
        "${QT_PLUGINS_DIR}/iconengines/qsvgicon.dll"
        DESTINATION "${BT_DESTINATION}/iconengines"
        CONFIGURATIONS "Release"
    )
    INSTALL(FILES
        "${QT_PLUGINS_DIR}/platforms/qwindows.dll"
        DESTINATION "${BT_DESTINATION}/platforms"
        CONFIGURATIONS "Release"
    )
    INSTALL(FILES
        "${QT_PLUGINS_DIR}/printsupport/windowsprintersupport.dll"
        DESTINATION "${BT_DESTINATION}/printsupport"
        CONFIGURATIONS "Release"
    )
    INSTALL(FILES
        "${QT_PLUGINS_DIR}/../resources/qtwebengine_resources.pak"
        "${QT_PLUGINS_DIR}/../resources/qtwebengine_resources_100p.pak"
        "${QT_PLUGINS_DIR}/../resources/qtwebengine_resources_200p.pak"
        DESTINATION "${BT_DESTINATION}"
        CONFIGURATIONS "Release"
    )
    INSTALL(FILES
        "${QT_PLUGINS_DIR}/imageformats/qdds.dll"
        "${QT_PLUGINS_DIR}/imageformats/qgif.dll"
        "${QT_PLUGINS_DIR}/imageformats/qico.dll"
        "${QT_PLUGINS_DIR}/imageformats/qicns.dll"
        "${QT_PLUGINS_DIR}/imageformats/qjpeg.dll"
        "${QT_PLUGINS_DIR}/imageformats/qsvg.dll"
        "${QT_PLUGINS_DIR}/imageformats/qtga.dll"
        "${QT_PLUGINS_DIR}/imageformats/qtiff.dll"
        "${QT_PLUGINS_DIR}/imageformats/qwbmp.dll"
        "${QT_PLUGINS_DIR}/imageformats/qwebp.dll"
        DESTINATION "${BT_DESTINATION}/imageformats"
        CONFIGURATIONS "Release"
    )
    INSTALL(DIRECTORY
        "${QT_BINARY_DIR}/../translations"
        DESTINATION "${BT_DESTINATION}"
        CONFIGURATIONS "Release"
    )

    # This adds in the required Windows system libraries
    MESSAGE(STATUS  "INSTALL Microsoft Redist ${MSVC_REDIST}" )
    INSTALL(PROGRAMS ${MSVC_REDIST} DESTINATION bin)
    SET(CPACK_NSIS_EXTRA_INSTALL_COMMANDS "
        ExecWait \\\"$INSTDIR\\\\bin\\\\vcredist.x86.exe  /quiet\\\"
        Delete   \\\"$INSTDIR\\\\bin\\\\vcredist.x86.exe\\\"
    ")

    IF(CMAKE_BUILD_TYPE STREQUAL "Debug")
        SET(ZLIB_LIBRARY ${ZLIB_LIBRARY_DEBUG})
    ELSE()
        SET(ZLIB_LIBRARY ${ZLIB_LIBRARY_RELEASE})
    ENDIF()

    MESSAGE(STATUS  "INSTALL Zlib_LIBRARY ${ZLIB_LIBRARY}" )
    STRING(REPLACE ".lib" ".dll" ZLIB_DLL "${ZLIB_LIBRARY}")
    INSTALL(FILES ${ZLIB_DLL} DESTINATION ${BT_DESTINATION})

    MESSAGE(STATUS  "INSTALL CLucene_LIBRARY ${CLucene_LIBRARY}" )
    STRING(REPLACE ".lib" ".dll" CLUCENE_DLL "${CLucene_LIBRARY}")
    INSTALL(FILES ${CLUCENE_DLL} DESTINATION ${BT_DESTINATION})

    MESSAGE(STATUS  "INSTALL CLucene_LIBRARY ${CLucene_SHARED_LIB}" )
    STRING(REPLACE ".lib" ".dll" CLUCENE_SHARED_DLL "${CLucene_SHARED_LIB}")
    INSTALL(FILES ${CLUCENE_SHARED_DLL} DESTINATION ${BT_DESTINATION})

    MESSAGE(STATUS  "INSTALL CURL_LIBRARY ${CURL_LIBRARY}" )
    STRING(REPLACE "_imp.lib" ".dll" CURL_DLL "${CURL_LIBRARY}")
    INSTALL(FILES ${CURL_DLL} DESTINATION ${BT_DESTINATION})

    SET(SWORD_DLL "${Sword_LIBRARY_DIRS}/sword.dll")
    MESSAGE(STATUS  "INSTALL SWORD_LIBRARY ${SWORD_DLL}" )
    INSTALL(FILES ${SWORD_DLL} DESTINATION ${BT_DESTINATION})

    # Some options for the CPack system.  These should be pretty self-evident
    SET(CPACK_PACKAGE_ICON "${CMAKE_CURRENT_SOURCE_DIR}\\\\pics\\\\icons\\\\bibletime.png")
    SET(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\bibletime.exe")
    SET(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY}")
    SET(CPACK_NSIS_HELP_LINK "http:\\\\\\\\www.bibletime.info")
    SET(CPACK_NSIS_URL_INFO_ABOUT "http:\\\\\\\\www.bibletime.info")
    SET(CPACK_NSIS_CONTACT "bt-devel@crosswire.org")
    SET(CPACK_NSIS_MODIFY_PATH OFF)
    SET(CPACK_GENERATOR "NSIS")

    SET(CPACK_PACKAGE_EXECUTABLES "bibletime" "BibleTime")

    INCLUDE(CPack)

ENDIF(WIN32 AND NOT UNIX)


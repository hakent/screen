
if (CMAKE_VERSION VERSION_LESS 3.1.0)
    message(FATAL_ERROR "Qt 5 XcbQpa module requires at least CMake version 3.1.0")
endif()

get_filename_component(_qt5XcbQpa_install_prefix "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# For backwards compatibility only. Use Qt5XcbQpa_VERSION instead.
set(Qt5XcbQpa_VERSION_STRING 5.13.1)

set(Qt5XcbQpa_LIBRARIES Qt5::XcbQpa)

macro(_qt5_XcbQpa_check_file_exists file)
    if(NOT EXISTS "${file}" )
        message(FATAL_ERROR "The imported target \"Qt5::XcbQpa\" references the file
   \"${file}\"
but this file does not exist.  Possible reasons include:
* The file was deleted, renamed, or moved to another location.
* An install or uninstall procedure did not complete successfully.
* The installation package was faulty and contained
   \"${CMAKE_CURRENT_LIST_FILE}\"
but not all the files it references.
")
    endif()
endmacro()


macro(_populate_XcbQpa_target_properties Configuration LIB_LOCATION IMPLIB_LOCATION
      IsDebugAndRelease)
    set_property(TARGET Qt5::XcbQpa APPEND PROPERTY IMPORTED_CONFIGURATIONS ${Configuration})

    set(imported_location "${_qt5XcbQpa_install_prefix}/lib/${LIB_LOCATION}")
    _qt5_XcbQpa_check_file_exists(${imported_location})
    set(_deps
        ${_Qt5XcbQpa_LIB_DEPENDENCIES}
    )
    set(_static_deps
    )

    set_target_properties(Qt5::XcbQpa PROPERTIES
        "IMPORTED_LOCATION_${Configuration}" ${imported_location}
        "IMPORTED_SONAME_${Configuration}" "libQt5XcbQpa.so.5"
        # For backward compatibility with CMake < 2.8.12
        "IMPORTED_LINK_INTERFACE_LIBRARIES_${Configuration}" "${_deps};${_static_deps}"
    )
    set_property(TARGET Qt5::XcbQpa APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 "${_deps}"
    )


endmacro()

if (NOT TARGET Qt5::XcbQpa)

    set(_Qt5XcbQpa_OWN_INCLUDE_DIRS "")
    set(Qt5XcbQpa_PRIVATE_INCLUDE_DIRS "")

    foreach(_dir ${_Qt5XcbQpa_OWN_INCLUDE_DIRS})
        _qt5_XcbQpa_check_file_exists(${_dir})
    endforeach()

    # Only check existence of private includes if the Private component is
    # specified.
    list(FIND Qt5XcbQpa_FIND_COMPONENTS Private _check_private)
    if (NOT _check_private STREQUAL -1)
        foreach(_dir ${Qt5XcbQpa_PRIVATE_INCLUDE_DIRS})
            _qt5_XcbQpa_check_file_exists(${_dir})
        endforeach()
    endif()

    set(Qt5XcbQpa_INCLUDE_DIRS ${_Qt5XcbQpa_OWN_INCLUDE_DIRS})

    set(Qt5XcbQpa_DEFINITIONS -DQT_XCB_QPA_LIB_LIB)
    set(Qt5XcbQpa_COMPILE_DEFINITIONS QT_XCB_QPA_LIB_LIB)
    set(_Qt5XcbQpa_MODULE_DEPENDENCIES "ServiceSupport;ThemeSupport;FontDatabaseSupport;XkbCommonSupport;LinuxAccessibilitySupport;VulkanSupport;Gui;Gui;EdidSupport;Core;Core")


    set(Qt5XcbQpa_OWN_PRIVATE_INCLUDE_DIRS ${Qt5XcbQpa_PRIVATE_INCLUDE_DIRS})

    set(_Qt5XcbQpa_FIND_DEPENDENCIES_REQUIRED)
    if (Qt5XcbQpa_FIND_REQUIRED)
        set(_Qt5XcbQpa_FIND_DEPENDENCIES_REQUIRED REQUIRED)
    endif()
    set(_Qt5XcbQpa_FIND_DEPENDENCIES_QUIET)
    if (Qt5XcbQpa_FIND_QUIETLY)
        set(_Qt5XcbQpa_DEPENDENCIES_FIND_QUIET QUIET)
    endif()
    set(_Qt5XcbQpa_FIND_VERSION_EXACT)
    if (Qt5XcbQpa_FIND_VERSION_EXACT)
        set(_Qt5XcbQpa_FIND_VERSION_EXACT EXACT)
    endif()

    set(Qt5XcbQpa_EXECUTABLE_COMPILE_FLAGS "")

    foreach(_module_dep ${_Qt5XcbQpa_MODULE_DEPENDENCIES})
        if (NOT Qt5${_module_dep}_FOUND)
            find_package(Qt5${_module_dep}
                5.13.1 ${_Qt5XcbQpa_FIND_VERSION_EXACT}
                ${_Qt5XcbQpa_DEPENDENCIES_FIND_QUIET}
                ${_Qt5XcbQpa_FIND_DEPENDENCIES_REQUIRED}
                PATHS "${CMAKE_CURRENT_LIST_DIR}/.." NO_DEFAULT_PATH
            )
        endif()

        if (NOT Qt5${_module_dep}_FOUND)
            set(Qt5XcbQpa_FOUND False)
            return()
        endif()

        list(APPEND Qt5XcbQpa_INCLUDE_DIRS "${Qt5${_module_dep}_INCLUDE_DIRS}")
        list(APPEND Qt5XcbQpa_PRIVATE_INCLUDE_DIRS "${Qt5${_module_dep}_PRIVATE_INCLUDE_DIRS}")
        list(APPEND Qt5XcbQpa_DEFINITIONS ${Qt5${_module_dep}_DEFINITIONS})
        list(APPEND Qt5XcbQpa_COMPILE_DEFINITIONS ${Qt5${_module_dep}_COMPILE_DEFINITIONS})
        list(APPEND Qt5XcbQpa_EXECUTABLE_COMPILE_FLAGS ${Qt5${_module_dep}_EXECUTABLE_COMPILE_FLAGS})
    endforeach()
    list(REMOVE_DUPLICATES Qt5XcbQpa_INCLUDE_DIRS)
    list(REMOVE_DUPLICATES Qt5XcbQpa_PRIVATE_INCLUDE_DIRS)
    list(REMOVE_DUPLICATES Qt5XcbQpa_DEFINITIONS)
    list(REMOVE_DUPLICATES Qt5XcbQpa_COMPILE_DEFINITIONS)
    list(REMOVE_DUPLICATES Qt5XcbQpa_EXECUTABLE_COMPILE_FLAGS)

    set(_Qt5XcbQpa_LIB_DEPENDENCIES "Qt5::ServiceSupport;Qt5::ThemeSupport;Qt5::FontDatabaseSupport;Qt5::XkbCommonSupport;Qt5::LinuxAccessibilitySupport;Qt5::VulkanSupport;Qt5::Gui;Qt5::Gui;Qt5::EdidSupport;Qt5::Core;Qt5::Core")


    add_library(Qt5::XcbQpa SHARED IMPORTED)

    set_property(TARGET Qt5::XcbQpa PROPERTY
      INTERFACE_INCLUDE_DIRECTORIES ${_Qt5XcbQpa_OWN_INCLUDE_DIRS})
    set_property(TARGET Qt5::XcbQpa PROPERTY
      INTERFACE_COMPILE_DEFINITIONS QT_XCB_QPA_LIB_LIB)

    set_property(TARGET Qt5::XcbQpa PROPERTY INTERFACE_QT_ENABLED_FEATURES )
    set_property(TARGET Qt5::XcbQpa PROPERTY INTERFACE_QT_DISABLED_FEATURES )

    set(_Qt5XcbQpa_PRIVATE_DIRS_EXIST TRUE)
    foreach (_Qt5XcbQpa_PRIVATE_DIR ${Qt5XcbQpa_OWN_PRIVATE_INCLUDE_DIRS})
        if (NOT EXISTS ${_Qt5XcbQpa_PRIVATE_DIR})
            set(_Qt5XcbQpa_PRIVATE_DIRS_EXIST FALSE)
        endif()
    endforeach()

    if (_Qt5XcbQpa_PRIVATE_DIRS_EXIST)
        add_library(Qt5::XcbQpaPrivate INTERFACE IMPORTED)
        set_property(TARGET Qt5::XcbQpaPrivate PROPERTY
            INTERFACE_INCLUDE_DIRECTORIES ${Qt5XcbQpa_OWN_PRIVATE_INCLUDE_DIRS}
        )
        set(_Qt5XcbQpa_PRIVATEDEPS)
        foreach(dep ${_Qt5XcbQpa_LIB_DEPENDENCIES})
            if (TARGET ${dep}Private)
                list(APPEND _Qt5XcbQpa_PRIVATEDEPS ${dep}Private)
            endif()
        endforeach()
        set_property(TARGET Qt5::XcbQpaPrivate PROPERTY
            INTERFACE_LINK_LIBRARIES Qt5::XcbQpa ${_Qt5XcbQpa_PRIVATEDEPS}
        )
    endif()

    _populate_XcbQpa_target_properties(RELEASE "libQt5XcbQpa.so.5.13.1" "" FALSE)








_qt5_XcbQpa_check_file_exists("${CMAKE_CURRENT_LIST_DIR}/Qt5XcbQpaConfigVersion.cmake")

endif()

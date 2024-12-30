cmake_minimum_required(VERSION 3.16)

project(SSHViewer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBSSH REQUIRED libssh)

include_directories(${CMAKE_SOURCE_DIR}/include)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_resources(SHARED_RESOURCES ${RESOURCE_FILES})

qt_add_executable(appSSHViewer
    src/main.cpp
    src/models/sshmodel.cpp
)

qt_add_qml_module(appSSHViewer
    URI SSHViewer
    VERSION 1.0
    QML_FILES
    RESOURCES qml.qrc
    qml/Main.qml
    qml/Components/ImageButton.qml
    qml/Consts/Images.qml
    SOURCES include/models/sshmodel.h
    SOURCES src/models/sshmanager.cpp
    SOURCES include/models/sshmanager.h
    SOURCES include/common.h
)

set_target_properties(appSSHViewer PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_include_directories(appSSHViewer
    PRIVATE ${CMAKE_SOURCE_DIR}/include
    PRIVATE ${LIBSSH_INCLUDE_DIRS}
)

target_link_directories(appSSHViewer PRIVATE ${LIBSSH_LIBRARY_DIRS})
target_link_libraries(appSSHViewer PRIVATE ${LIBSSH_LIBRARIES} Qt6::Quick)

include(GNUInstallDirs)
install(TARGETS appSSHViewer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

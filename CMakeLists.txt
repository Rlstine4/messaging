cmake_minimum_required(VERSION 3.26)

project(messaging
    VERSION 0.1.0
    DESCRIPTION "General messaging library"
    LANGUAGES CXX
)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

option(BUILD_SHARED_LIBS "Build shared libraries" ON)
option(USE_LOCAL_PACKAGES "Use locally installed packages when available" ON)
option(OPTION_ASAN "Build with AddressSanitizer" OFF)

list(PREPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
include(dependencies)

if(OPTION_ASAN)
    add_compile_options(-fsanitize=address)
    add_link_options(-fsanitize=address)
endif()

add_library(messaging
    src/messaging/topic/TopicPublisher.cpp
)
add_library(messaging::messaging ALIAS messaging)

set_target_properties(messaging PROPERTIES
    VERSION     ${PROJECT_VERSION}
    SOVERSION   ${PROJECT_VERSION_MAJOR}
    EXPORT_NAME messaging
)

target_compile_features(messaging PUBLIC cxx_std_20)
target_include_directories(messaging PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
target_link_libraries(messaging PUBLIC
    cppzmq-static
    tl::expected
)

install(TARGETS messaging
    EXPORT messagingTargets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

set(messaging_package_dir "${CMAKE_INSTALL_LIBDIR}/cmake/messaging")
configure_package_config_file(
    cmake/messagingConfig.cmake.in
    "${PROJECT_BINARY_DIR}/messagingConfig.cmake"
    INSTALL_DESTINATION "${messaging_package_dir}"
)
write_basic_package_version_file(
    "${PROJECT_BINARY_DIR}/messagingConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)
install(FILES
    "${PROJECT_BINARY_DIR}/messagingConfig.cmake"
    "${PROJECT_BINARY_DIR}/messagingConfigVersion.cmake"
    DESTINATION "${messaging_package_dir}"
)
install(EXPORT messagingTargets
    NAMESPACE messaging::
    FILE messagingTargets.cmake
    DESTINATION "${messaging_package_dir}"
)

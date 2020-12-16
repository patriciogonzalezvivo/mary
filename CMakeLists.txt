cmake_minimum_required(VERSION 3.1)

if(${CMAKE_VERSION} VERSION_LESS 3.15)
    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
else()
    cmake_policy(VERSION 3.15)
endif()

# project(mary)
project(mary    VERSION 0.1
                DESCRIPTION "Mary sensor library"
                LANGUAGES CXX)

# Only do these if this is the main project, and not if it is included through add_subdirectory
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)

    # Optionally set things like CMAKE_CXX_STANDARD, CMAKE_POSITION_INDEPENDENT_CODE here
    
    set(CMAKE_CXX_STANDARD 11)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    # Let's ensure -std=c++xx instead of -std=g++xx
    set(CMAKE_CXX_EXTENSIONS OFF)

    # Let's nicely support folders in IDE's
    set_property(GLOBAL PROPERTY USE_FOLDERS ON)

    # Docs only available if this is the main app
    find_package(Doxygen)
    if(Doxygen_FOUND)
	add_subdirectory(docs)
    else()
	message(STATUS "Doxygen not found, not building docs")
    endif()

    add_definitions(-DDEBUG_USING_SIMULATE_DATA)
endif()

# GLM
find_package(glm REQUIRED)
include_directories(${GLM_INCLUDE_DIRS})
link_directories(${GLM_LIBRARY_DIRS})
add_definitions(${GLM_DEFINITIONS})

# GPS
find_path(GPS_INCLUDE_DIR NAMES libgpsmm.h)
find_library(GPS_LIBRARY NAMES gps)
if(NOT GPS_INCLUDE_DIR OR NOT GPS_LIBRARY)
    MESSAGE(FATAL_ERROR "Could not find GPS library")
endif(NOT GPS_INCLUDE_DIR OR NOT GPS_LIBRARY)
message(STATUS "Found GPS: ${GPS_LIBRARY}")

# Threads
find_package (Threads)

# RPLIDAR DRIVER
set(RPLIDAR_SDK_PATH "${CMAKE_CURRENT_SOURCE_DIR}/include/mary/lidar/rplidar_sdk")
FILE(GLOB RPLIDAR_SDK_SRC 
    "${RPLIDAR_SDK_PATH}/src/arch/linux/*.cpp"
    "${RPLIDAR_SDK_PATH}/src/hal/*.cpp"
    "${RPLIDAR_SDK_PATH}/src/*.cpp"
)

include_directories(
  ${RPLIDAR_SDK_PATH}/include
  ${RPLIDAR_SDK_PATH}/src
)

# MARY folders
SET( MARY_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src )
SET( MARY_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include )

file(GLOB MARY_ROOT_HEADER "${MARY_INCLUDE_DIR}/mary/*.h")
file(GLOB MARY_TOOLS_HEADER "${MARY_INCLUDE_DIR}/mary/tools/*.h")
file(GLOB MARY_DRIVERS_HEADER "${MARY_INCLUDE_DIR}/mary/drivers/*.h")
file(GLOB MARY_GPS_HEADER "${MARY_INCLUDE_DIR}/mary/drivers/gps/*.h")
file(GLOB MARY_IMU_HEADER "${MARY_INCLUDE_DIR}/mary/drivers/imu/*.h")
file(GLOB MARY_MOUNT_HEADER "${MARY_INCLUDE_DIR}/mary/drivers/mount/*.h")
file(GLOB MARY_LIDAR_HEADER "${MARY_INCLUDE_DIR}/mary/drivers/lidar/*.h")
file(GLOB MARY_LIDAR_HEADER "${MARY_INCLUDE_DIR}/mary/drivers/lidar/*.h")

SET( MARY_SOURCE
    ${MARY_SOURCE_DIR}/drivers/gps/Gpsd.cpp
    ${MARY_SOURCE_DIR}/drivers/imu/BerryIMU.cpp 
    ${MARY_SOURCE_DIR}/drivers/lidar/RPLidar.cpp 
    ${MARY_SOURCE_DIR}/drivers/mount/Celestron.cpp 
)

message(STATUS "add_library")
add_library(mary ${MARY_SOURCE} ${RPLIDAR_SDK_SRC})
 
message(STATUS "set_target_properties")
set_target_properties(mary PROPERTIES
    CXX_STANDARD 11
    CXX_STANDARD_REQUIRED ON
)

include_directories(mary PUBLIC
    ${MARY_INCLUDE_DIR}
)

target_link_libraries(mary PUBLIC
    ${GPS_LIBRARY} ${CMAKE_THREAD_LIBS_INIT} 
)

# Testing only available if this is the main app
# Emergency override MODERN_CMAKE_BUILD_TESTING provided as well
if((CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME OR MODERN_CMAKE_BUILD_TESTING) AND BUILD_TESTING)
    add_subdirectory(tests)
endif()


if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    # add_subdirectory(tests)

    install(TARGETS ${PROJECT_NAME} DESTINATION lib)
    install(FILES ${MARY_ROOT_HEADER} DESTINATION include/mary)
    install(FILES ${MARY_TOOLS_HEADER} DESTINATION include/mary/tools)
    install(FILES ${MARY_DRIVERS_HEADER} DESTINATION include/mary/drivers)
    install(FILES ${MARY_GPS_HEADER} DESTINATION include/mary/drivers/gps)
    install(FILES ${MARY_IMU_HEADER} DESTINATION include/mary/drivers/imu)
    install(FILES ${MARY_LIDAR_HEADER} DESTINATION include/mary/drivers/lidar)
    install(FILES ${MARY_MOUNT_HEADER} DESTINATION include/mary/drivers/mount)
endif()
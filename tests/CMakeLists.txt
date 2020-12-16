add_executable (celestron _celestron.cpp)
target_link_libraries (celestron PRIVATE mary)

add_executable (rplidar _rplidar.cpp)
target_link_libraries (rplidar PRIVATE mary ${CMAKE_THREAD_LIBS_INIT})

add_executable (gpsd _gpsd.cpp)
target_link_libraries (gpsd PRIVATE mary ${GPS_LIBRARY})

add_executable (berryimu _berryimu.cpp)
target_link_libraries (berryimu PRIVATE mary)
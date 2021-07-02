cmake_minimum_required(VERSION 3.7)

project(my_project)

if (EXISTS ${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    conan_basic_setup()
else ()
    message(WARNING "The file conanbuildinfo.cmake doesn't exist, you have to run conan install first")
endif ()

add_executable(my_project src/main.cpp)

target_link_libraries(my_project ${CONAN_LIBS})

target_link_libraries(my_project -static-libgcc -static-libstdc++)

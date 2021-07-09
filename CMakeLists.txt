cmake_minimum_required(VERSION 3.7)

project(my_project)

if (EXISTS ${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    conan_basic_setup()
else ()
    message(WARNING "The file conanbuildinfo.cmake doesn't exist, you have to run conan install first")
endif ()

add_executable(crow src/main.cpp)

add_executable(vg_status src/vg_status/main.cpp)


target_link_libraries(crow ${CONAN_LIBS})

target_link_libraries(crow -static-libgcc -static-libstdc++)

target_link_libraries(vg_status -static-libgcc -static-libstdc++)

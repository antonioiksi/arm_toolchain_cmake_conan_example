set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR "aarch64")
#set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_EXE_LINKER_FLAGS "-static")

#set(CMAKE_SYSROOT /home/devel/rasp-pi-rootfs)
#set(CMAKE_STAGING_PREFIX /home/devel/stage)

set(tools /opt/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu)
set(CMAKE_C_COMPILER ${tools}/bin/aarch64-none-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER ${tools}/bin/aarch64-none-linux-gnu-g++)

set(CMAKE_FIND_ROOT_PATH /opt/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/aarch64-none-linux-gnu)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

#set(CMAKE_SYSROOT /home/devel/rasp-pi-rootfs)
#set(CMAKE_STAGING_PREFIX /home/devel/stage)

set(tools /opt/gcc-linaro-7.4.1-2019.02-i686_aarch64-linux-gnu)
set(CMAKE_C_COMPILER ${tools}/bin/aarch64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER ${tools}/bin/aarch64-linux-gnu-g++)

SET(CMAKE_FIND_ROOT_PATH  /opt/gcc-linaro-7.4.1-2019.02-i686_aarch64-linux-gnu/aarch64-linux-gnu)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

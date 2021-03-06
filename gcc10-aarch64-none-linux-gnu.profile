toolchain=aarch64-none-linux-gnu
toolchainroot=/opt/gcc-arm-10.2-2020.11-x86_64-$toolchain

[settings]
os=Linux
arch=armv8
compiler=gcc
compiler.version=10
compiler.libcxx=libstdc++
build_type=Release

[env]
CONAN_CMAKE_FIND_ROOT_PATH=$toolchainroot
#CHOST=$toolchain
#AR=$toolchain-ar
#AS=$toolchain-as
#RANLIB=$toolchain-ranlib
#STRIP=$toolchain-strip

CC=$toolchain-gcc
CXX=$toolchain-g++

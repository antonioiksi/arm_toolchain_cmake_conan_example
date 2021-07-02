toolchain=aarch64-linux-gnu
toolchainroot=/opt/gcc-linaro-7.4.1-2019.02-i686_$toolchain

[settings]
os=Linux
arch=armv8
compiler=gcc
compiler.version=7
compiler.libcxx=libstdc++
build_type=Release

[env]
CONAN_CMAKE_FIND_ROOT_PATH=$toolchainroot
#CHOST=$toolchain
#AR=$toolchain-ar
#AS=$toolchain-as
#RANLIB=$toolchain-ranlib
#STRIP=$toolchain-strip

CC=$toolchain-gcc-7
CXX=$toolchain-g++-7

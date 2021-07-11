# c++ crosscompiling project example

**Requirements**
* Linux 5.10 (tested on Ubuntu 18.04)
* cmake (apt install cmake)
* conan (pip3 install conan)

---
## Develop in docker
```sh
docker-compose up -d
docker exec -it ubuntu_arm64_compiler bash
```


## Build for ARMv8 (aarch64)
### Install toolchain
```sh
make -f armv8.Makefile config
```

> DO NOT FORGET ADD GCC LOCATION TO $PATH
`PATH=$PATH:/opt/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/bin`

### Build
> for dependencies using conan package manager
```sh
make -f armv8.Makefile build
```

### Enjoy
find out *snack* in the `build/bin` folder


---

## Build for AMD64
### Install toolchain
```sh
apt install software-properties-common
add-apt-repository ppa:ubuntu-toolchain-r/test
apt update
apt install gcc-10 g++-10 
```

> check `gcc-10` and `g++-10` location found in `$PATH`, default installed in 

### Build
> for dependencies using conan package manager
```sh
make -f amd64.Makefile build
```

### Enjoy
find out *snack* in the `build/bin` folder


------
### IF YOU GET ERROR!!!
```
./my_project: /usr/lib/aarch64-linux-gnu/libstdc++.so.6: version `CXXABI_1.3.11' not found (required by ./my_project)
./my_project: /usr/lib/aarch64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.26' not found (required by ./my_project)
```
Resolves with two lines CMAKE (add std into executer)
```
# file: CMakeLists.txt
target_link_libraries(my_project -static-libgcc -static-libstdc++)
```
and
```
# file: gcc10-aarch64-none-linux-gnu.cmake
set(CMAKE_EXE_LINKER_FLAGS "-static")
```

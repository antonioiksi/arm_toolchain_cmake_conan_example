# c++ crosscompiling project example

** Requirements **
* Linux 4+ (tested on Ubuntu 18.04)
* cmake
* conan

## Install toolchain

```sh
wget --no-http-keep-alive --show-progress -O toolchain.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu-a/10.2-2020.11/binrel/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar.xz?revision=972019b5-912f-4ae6-864a-f61f570e2e7e&la=en&hash=B8618949E6095C87E4C9FFA1648CAA67D4997D88"
tar -xfv toolchain.tar.xz
mv gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu /opt
```

Edit ~/.bashrc, add at the end of file
```
PATH=$PATH:/opt/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/bin
```

## Compile
```sh
rm -rf build && mkdir build && cd build
rm -rf ~/.conan/data

conan install .. --build=missing --profile ../conan-aarch64.profile

cmake -DCMAKE_TOOLCHAIN_FILE=../aarch64-linux-gnu.cmake ..

cmake --build . --config Release
```


## ERRORS
```
./my_project: /usr/lib/aarch64-linux-gnu/libstdc++.so.6: version `CXXABI_1.3.11' not found (required by ./my_project)
./my_project: /usr/lib/aarch64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.26' not found (required by ./my_project)
```
Resolves with two lines CMAKE (add std into executer)
```
target_link_libraries(my_project -static-libgcc -static-libstdc++)
```


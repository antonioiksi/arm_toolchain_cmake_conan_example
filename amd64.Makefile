# Makefile
# for using `source` in  install
SHELL := /bin/bash

# Do not forget install gcc-10 and g++-10 
# apt install software-properties-common
# add-apt-repository ppa:ubuntu-toolchain-r/test
# apt update
# apt install gcc-10 g++-10 
BUILD_DIR := build_amd64

.PHONY: build

build:
	rm -rf $(BUILD_DIR) && mkdir $(BUILD_DIR) && cd $(BUILD_DIR) && \
	conan install .. --build=missing --profile ../gcc10-amd64-linux.profile && \
	cmake -DCMAKE_TOOLCHAIN_FILE=../gcc10-amd64-linux.cmake -DCMAKE_BUILD_TYPE=Release .. && \
	cmake --build . --config Release

clean: clean-build clean-conan

clean-build:
	rm -rf $(BUILD_DIR) && mkdir $(BUILD_DIR)

clean-conan: 
	rm -rf ~/.conan/data

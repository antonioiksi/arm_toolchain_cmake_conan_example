# Makefile
# for using `source` in  install
SHELL := /bin/bash

BUILD_DIR := build_armv8


TOOLCHAIN := gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu
TOOLCHAIN_BIN := /opt/${TOOLCHAIN}/bin

TOOLCHAIN_BIN_EXPORTS= \
if [[ "${PATH}" != *"${TOOLCHAIN}"* ]]; then export PATH=$$PATH:${TOOLCHAIN_BIN}; echo "added"; echo $$PATH; else echo "no"; fi
	
config: download install

download:
	if [ ! -f toolchains/${TOOLCHAIN}.tar.xz ]; then \
		rm -rf toolchains && mkdir toolchains && cd toolchains && \
		wget --no-http-keep-alive --show-progress -O ${TOOLCHAIN}.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu-a/10.2-2020.11/binrel/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar.xz?revision=972019b5-912f-4ae6-864a-f61f570e2e7e&la=en&hash=B8618949E6095C87E4C9FFA1648CAA67D4997D88"; \
	fi

install:
	if [ ! -d ${TOOLCHAIN_BIN} ]; then \
		tar -xvf ${TOOLCHAIN}.tar.xz -C /opt; \
	fi

.PHONY: build

build:
	$(TOOLCHAIN_BIN_EXPORTS) ;\
	rm -rf $(BUILD_DIR) && mkdir $(BUILD_DIR) && cd $(BUILD_DIR) && \
	conan install .. --build=missing --profile ../gcc10-aarch64-none-linux-gnu.profile && \
	cmake -DCMAKE_TOOLCHAIN_FILE=../gcc10-aarch64-none-linux-gnu.cmake -DCMAKE_BUILD_TYPE=Release .. && \
	cmake --build . --config Release

build-clean:
	rm -rf $(BUILD_DIR) && mkdir $(BUILD_DIR)

clean-conan: 
	rm -rf ~/.conan/data

clean-toolchain: 
	rm -rf /opt/$(TOOLCHAIN)

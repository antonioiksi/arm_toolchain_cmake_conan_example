all: release

.PHONY: clean-conan clean-build

install-toolchain:
	wget --no-http-keep-alive --show-progress -O gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu-a/10.2-2020.11/binrel/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar.xz?revision=972019b5-912f-4ae6-864a-f61f570e2e7e&la=en&hash=B8618949E6095C87E4C9FFA1648CAA67D4997D88" && \
	tar -xvf gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu.tar.xz -C /opt 

export-path:
	export PATH=$PATH:/opt/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/bin
#	echo "PATH=$PATH:/opt/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/bin" >> ~/.bashrc 

release: 
	rm -rf build && mkdir build && cd build && \
	conan install .. --build=missing --profile ../gcc10-aarch64-none-linux-gnu.profile && \
	cmake -DCMAKE_TOOLCHAIN_FILE=../gcc10-aarch64-none-linux-gnu.cmake -DCMAKE_BUILD_TYPE=Release .. && \
	cmake --build . --config Release

clean: clean-conan clean-build

clean-conan: 
	rm -rf ~/.conan/data

clean-build:
	rm -rf build && mkdir build

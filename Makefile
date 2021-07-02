all: release

release-all-in-one:
	rm -rf build && mkdir build && cd build && \
	conan install .. --build=missing --profile ../toolchain.profile && \
	cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake -DCMAKE_BUILD_TYPE=Release .. &&\
	cmake --build . --config Release;

release:
	clean-build && cd build && \
	install-conan && \
	create-make && \
	build-release

install-conan: 
	conan install .. --build=missing --profile ../toolchain.profile

create-make:
	cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake -DCMAKE_BUILD_TYPE=Release ..

build-release:
	cmake --build . --config Release

clean: 
	clean-conan && clean-build

clean-conan: 
	rm -rf ~/.conan/data

clean-build: 
	rm -rf build && mkdir build

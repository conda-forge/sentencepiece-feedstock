#!/bin/bash
set -ex

# we're trying to avoid the third_party sources, and not building them;
# to avoid weird errors if those sources got picked up nevertheless, delete them
rm -rf third_party/absl
rm -rf third_party/protobuf-lite

mkdir build
cd build

if [[ "${target_platform}" != "${build_platform}" ]]; then
    CMAKE_ARGS="${CMAKE_ARGS} -DProtobuf_PROTOC_EXECUTABLE=$BUILD_PREFIX/bin/protoc"
fi

cmake -G "Ninja" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib \
    -DCMAKE_AR="${AR}" \
    -DSPM_ENABLE_SHARED=ON \
    -DSPM_ENABLE_TCMALLOC=OFF \
    -DSPM_USE_EXTERNAL_ABSL=ON \
    -DSPM_USE_BUILTIN_PROTOBUF=OFF \
    ${CMAKE_ARGS} \
    ..

cmake --build .
cmake --install .

if [[ "$PKG_NAME" == "libsentencepiece" ]]; then
    rm ${PREFIX}/bin/spm_*
fi

# clean up for rerun
cd ..
rm -rf build

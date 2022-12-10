#!/bin/bash
set -ex

# we're trying to avoid the third_party sources, and not building them;
# to avoid weird errors if those sources got picked up nevertheless, delete them
rm -rf third_party/absl
rm -rf third_party/protobuf-lite

mkdir build
cd build

export LD_LIBRARY_PATH=${PREFIX}/lib
export CPATH=${PREFIX}/include
export INCLUDE=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib

cmake -G "Ninja" \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib \
    -DCMAKE_AR="${AR}" \
    -DSPM_ENABLE_SHARED=ON \
    -DSPM_ENABLE_TCMALLOC=OFF \
    -DSPM_USE_EXTERNAL_ABSL=ON \
    -DSPM_USE_BUILTIN_PROTOBUF=OFF \
    ..

cmake --build .
cmake --install .

if [[ "${target_platform}" == linux-* ]]; then
    ldconfig -v -N
fi

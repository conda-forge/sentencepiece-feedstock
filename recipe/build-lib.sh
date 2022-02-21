#!/bin/bash

set -ex

# debug for osx
ls -l src/
ls -l third_party/absl/flags || true
mv third_party/absl/flags/flag.h src/parse.h || true
mv third_party/absl/flags/flag.cc src/parse.cc || true

# we're trying to avoid the third_party sources, and not building them;
# to avoid weird errors if those sources got picked up nevertheless, delete them
rm -rf third_party/absl
if [[ "${target_platform}" != "osx-arm64" ]]; then
    rm -rf third_party/protobuf-lite
    export CMAKE_EXTRA="-DSPM_USE_BUILTIN_PROTOBUF=OFF"
else
    # building against external protobuf needs to call protoc,
    # which fails with bad CPU type in cross-compilation
    export CMAKE_EXTRA=""
fi

mkdir build
cd build

export LD_LIBRARY_PATH=${PREFIX}/lib
export CPATH=${PREFIX}/include
export INCLUDE=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib

cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib \
    -DCMAKE_AR="${AR}" \
    -DSPM_ENABLE_SHARED=ON \
    -DSPM_ENABLE_TCMALLOC=OFF \
    -DSPM_USE_EXTERNAL_ABSL=ON \
    $CMAKE_EXTRA \
    -S ..

make -j ${CPU_COUNT}
make install

if [[ "${target_platform}" == linux-* ]]; then
    ldconfig -v -N
fi

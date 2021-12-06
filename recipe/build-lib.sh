mkdir build
cd build

export LD_LIBRARY_PATH=${PREFIX}/lib
export CPATH=${PREFIX}/include
export INCLUDE=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib

export CMAKE_EXTRA="-DSPM_USE_BUILTIN_PROTOBUF=OFF"
if [[ "${target_platform}" == "osx-arm64" ]]; then
    # build calls protoc, which fails with bad CPU in cross-compilation
    export CMAKE_EXTRA=""
fi

cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib \
    -DCMAKE_AR="${AR}" \
    -DSPM_ENABLE_SHARED=ON \
    -DSPM_ENABLE_TCMALLOC=OFF \
    $CMAKE_EXTRA \
    -S ..

make -j ${CPU_COUNT}
make install

if [[ "${target_platform}" == linux-* ]]; then
    ldconfig -v -N
fi

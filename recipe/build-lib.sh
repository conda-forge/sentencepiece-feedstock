mkdir build
cd build

export LD_LIBRARY_PATH=${PREFIX}/lib
export CPATH=${PREFIX}/include
export INCLUDE=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib

cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    # sentencepiece uses this _relative_ to $PREFIX, see
    # https://github.com/google/sentencepiece/blob/v0.1.96/CMakeLists.txt#L45
    -DCMAKE_INSTALL_LIBDIR="lib" \
    -DCMAKE_AR="${AR}" \
    -DSPM_ENABLE_SHARED=ON \
    -DSPM_ENABLE_TCMALLOC=OFF \
    -S ..

make -j ${CPU_COUNT}
make install

ldconfig -v -N

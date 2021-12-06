mkdir build
cd build

export LD_LIBRARY_PATH=${PREFIX}/lib
export CPATH=${PREFIX}/include
export INCLUDE=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib

cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_AR="${AR}" \
    -DSPM_ENABLE_SHARED=ON \
    -DSPM_ENABLE_TCMALLOC=OFF \
    -DSPM_USE_BUILTIN_PROTOBUF=OFF \
    -S ..

make -j ${CPU_COUNT}
make install

# haven't found a way to avoid installing into $PREFIX/lib64;
# -DCMAKE_INSTALL_LIBDIR is not working as intended
mv ${PREFIX}/lib64/* ${PREFIX}/lib

ldconfig -v -N

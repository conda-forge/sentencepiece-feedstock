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
    -DSPM_ENABLE_TCMALLOC=OFF \
    -S ..
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

make -j ${CPU_COUNT}
make install

if [[ "$target_platform" == "linux-64" ]]; then
     ldconfig -v -N
fi

if [[ "$target_platform" == "osx-64" ]]; then
     update_dyld_shared_cache
fi

cd $SRC_DIR/python
${PYTHON} setup.py build
${PYTHON} setup.py install

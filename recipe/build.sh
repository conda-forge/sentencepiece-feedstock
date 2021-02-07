if [[ "${target_platform}" == linux-* ]]; then
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

    make -j ${CPU_COUNT}
    make install

    ldconfig -v -N
    cd $SRC_DIR/python
    ${PYTHON} setup.py build
    ${PYTHON} setup.py install
elif [[ "${target_platform}" == osx-* ]]; then
      {{ PYTHON }} -m pip install python/ -vv
fi

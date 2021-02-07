mkdir build
cd build

export LD_LIBRARY_PATH=${PREFIX}/lib
export CPATH=${PREFIX}/include
export INCLUDE=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib

cmake ../.. -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib -DCMAKE_AR="${AR}" -DSPM_ENABLE_SHARED=OFF -DSPM_NO_THREADLOCAL=ON

make -j ${CPU_COUNT}
make install

if [ "$(uname)" == "Linux" ];
then
    ldconfig -v -N
elif [ "$(uname)" == "Darwin" ];
then
    sudo update_dyld_shared_cache
fi

cd ..
cd python

${PYTHON} setup.py build
${PYTHON} setup.py install

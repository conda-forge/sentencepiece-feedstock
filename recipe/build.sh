mkdir build
cd build

export LD_LIBRARY_PATH=${PREFIX}/lib
export CPATH=${PREFIX}/include
export INCLUDE=${PREFIX}/include
export LIBRARY_PATH=${PREFIX}/lib

cmake .. -DSPM_ENABLE_SHARED=OFF -DCMAKE_INSTALL_PREFIX=../.. -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib -DCMAKE_AR="${AR}" -DSPM_ENABLE_TCMALLOC=OFF

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

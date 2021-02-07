mkdir build
cd build

cmake .. -DSPM_ENABLE_SHARED=OFF -DCMAKE_INSTALL_PREFIX=../..
sudo make -j ${CPU_COUNT}
sudo make install

if [ "$(uname)" == "Linux" ];
then
    sudo ldconfig -v -N
elif [ "$(uname)" == "Darwin" ];
then
    sudo update_dyld_shared_cache
fi

cd ..
cd python

${PYTHON} setup.py build
${PYTHON} setup.py install

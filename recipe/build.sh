mkdir build
cd build

cmake .. -DSPM_ENABLE_SHARED=OFF -DCMAKE_INSTALL_PREFIX=../..
make -j ${CPU_COUNT}
make install

if [ "$(uname)" == "Linux" ];
then
    ldconfig -v -N
fi

cd ..
cd python

${PYTHON} setup.py build
${PYTHON} setup.py install

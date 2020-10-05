mkdir build
cd build

set INCLUDE=%LIBRARY_INC%;%INCLUDE%;%RECIPE_DIR%
set LIBPATH=%LIBRARY_LIB%;%LIBPATH%

cmake ^
    -D CMAKE_INSTALL_PREFIX=%PREFIX% ^
    -DCMAKE_INSTALL_LIBDIR=%PREFIX%\lib ^
    -DCMAKE_AR="${AR}" ^
    -DSPM_ENABLE_TCMALLOC=OFF ^
    -S ..

make -j ${CPU_COUNT}
make install

ldconfig -v -N
cd %SRC_DIR%\python
python setup.py build
python setup.py install

mkdir build
cd build

set LD_LIBRARY_PATH=%PREFIX%\lib
set CPATH=%PREFIX%\include
set INCLUDE=%PREFIX%\include
set LIBRARY_PATH=%PREFIX%\lib

cmake .. -DCMAKE_INSTALL_PREFIX=%PREFIX% -DCMAKE_INSTALL_LIBDIR=%PREFIX%\lib -DSPM_ENABLE_SHARED=OFF
cmake --build . --config Release --target install || goto :error

:: make -j %CPU_COUNT%
:: make install

:: ldconfig -v -N

cd %SRC_DIR%\python
%PYTHON% setup.py build
%PYTHON% setup.py install

IF %ERRORLEVEL% NEQ 0 exit 1

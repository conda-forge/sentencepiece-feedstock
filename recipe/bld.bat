mkdir build
cd build

set PLATFORM=%1
if "%PLATFORM%"=="" set PLATFORM=x64
set PLATFORM_PREFIX=
if "%PLATFORM%"=="x64" set PLATFORM_PREFIX=-x64
set _CL_=/utf-8
set INCLUDE=%LIBRARY_INC%;%INCLUDE%;%RECIPE_DIR%
set CPATH=%PREFIX%\include
set CURRENT_PATH=%~dp0
set LIBRARY_PATH=%CURRENT_PATH%build\root
set PATH=%LIBRARY_PATH%\mingw-w64\bin;%LIBRARY_PREFIX%\usr\bin;%LIBRARY_BIN%;%PATH%

cmake .. -A %PLATFORM% -DSPM_BUILD_TEST=ON -DSPM_ENABLE_SHARED=OFF -DCMAKE_INSTALL_PREFIX=%LIBRARY_PATH%
cmake --build . --config Release --target install || goto :error
ctest -C Release || goto :error

ldconfig -v -N
cd %SRC_DIR%\python
python setup.py build
python setup.py install

@echo on

mkdir build
cd build

set CURRENT_PATH=%~dp0
set LIBRARY_PATH=%CURRENT_PATH%build\root
set PATH=%LIBRARY_PATH%\mingw-w64\bin;%LIBRARY_PREFIX%\usr\bin;%LIBRARY_BIN%;%PATH%
set _CL_=/utf-8
set _USE_EXTERNAL_ABSL=1

cmake ^
    -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PATH% ^
    -DSPM_ENABLE_SHARED=ON ^
    ..
IF %ERRORLEVEL% NEQ 0 exit 1

cmake --build . --config Release --target install
IF %ERRORLEVEL% NEQ 0 exit 1

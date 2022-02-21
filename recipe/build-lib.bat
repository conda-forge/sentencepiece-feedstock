@echo on

:: we're trying to avoid the third_party sources, and not building them;
:: to avoid weird errors if those sources got picked up nevertheless, delete them
rmdir /S /Q third_party\absl
rmdir /S /Q third_party\protobuf-lite

mkdir build
cd build

set _CL_=/utf-8
set _USE_EXTERNAL_ABSL=1
set PROTOBUF_USE_DLLS=1

cmake ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%;%LIBRARY_BIN%;%LIBRARY_LIB% ^
    -DCMAKE_INCLUDE_PATH=%LIBRARY_INC% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DSPM_ENABLE_SHARED=ON ^
    -DSPM_USE_BUILTIN_PROTOBUF=OFF ^
    -DSPM_USE_EXTERNAL_ABSL=ON ^
    ..
IF %ERRORLEVEL% NEQ 0 exit 1

cmake --build . --config Release --target install
IF %ERRORLEVEL% NEQ 0 exit 1

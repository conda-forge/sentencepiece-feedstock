@echo on

cd %SRC_DIR%\python
%PYTHON% setup.py build
IF %ERRORLEVEL% NEQ 0 exit 1
%PYTHON% setup.py install
IF %ERRORLEVEL% NEQ 0 exit 1

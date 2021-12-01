cd %SRC_DIR%\python
%PYTHON% setup.py build
%PYTHON% setup.py install
IF %ERRORLEVEL% NEQ 0 exit 1

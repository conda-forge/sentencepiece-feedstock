@echo on

cd %SRC_DIR%\python
%PYTHON% -m pip install --no-deps --ignore-installed -v .
IF %ERRORLEVEL% NEQ 0 exit 1

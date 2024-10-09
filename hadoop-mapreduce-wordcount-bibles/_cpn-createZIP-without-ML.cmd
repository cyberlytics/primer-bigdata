@echo off
setlocal enableDelayedExpansion

rem ***************************************************************************
rem * author: Christoph P. Neumann
rem ***************************************************************************
cd /D "%~dp0"
for %%i in (%CD%) do set BASEDIR=%%~ni
echo == %BASEDIR% ==

rem RESET
del "%BASEDIR%.zip" > NUL 2>&1

echo ^> Clean...
cmd /D/C _cpn_clean.cmd 2> NUL

cmd /D/C eolConverter lf "**/*.sh" > NUL 2>&1

echo ^> Zipping...
cd ..
7z a -xr@"%BASEDIR%\%~n0.lst" "%BASEDIR%.zip" .\%BASEDIR%\*
move "%BASEDIR%.zip" .\%BASEDIR%\ > NUL 2>&1
cd /D "%~dp0"

pause
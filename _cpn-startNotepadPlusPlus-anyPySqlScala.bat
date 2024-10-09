@echo off
setlocal enableDelayedExpansion

rem ***************************************************************************
rem * author: Christoph P. Neumann
rem ***************************************************************************
cd /D "%~dp0"

set EXEC=NOTEPAD++.EXE

echo Going to open PY, SQL, SCALA
rem echo Press ENTER to continue...
rem pause
for /R %%F in (*.py *.sql *.scala) do ("%EXEC%" "%%~dpnxF")

pause
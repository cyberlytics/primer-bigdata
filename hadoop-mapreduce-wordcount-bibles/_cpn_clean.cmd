@echo off
setlocal enableDelayedExpansion

rem ***************************************************************************
rem * author: Christoph P. Neumann
rem ***************************************************************************
cd /D "%~dp0"

del *.pyc 2> nul
rmdir __pycache__ /S /Q 2> nul
rmdir SZ1 /S /Q 2> nul
del data\allbibles-result.txt 2> nul

pause
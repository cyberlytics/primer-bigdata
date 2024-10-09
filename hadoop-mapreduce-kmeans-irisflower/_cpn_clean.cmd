@echo off
setlocal enableDelayedExpansion

rem ***************************************************************************
rem * author: Christoph P. Neumann
rem ***************************************************************************
cd /D "%~dp0"

del *.pyc 2> nul
rmdir __pycache__ /S /Q 2> nul
rmdir SZ1 SZ2 SZ3 /S /Q 2> nul
del data\centroids-iter-last.csv 2> nul
del data\centroids-iter-current.csv 2> nul
del data\centroids-result.csv 2> nul

pause
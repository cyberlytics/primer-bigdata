@echo off

rem ***************************************************************************
rem * author: Christoph P. Neumann
rem ***************************************************************************
cd /d "%~dp0"

rem Copy given file into all subfolders:
for /D %%D in (*) do (
	copy "%~dpnx1" "%%~D\%~nx1"
)

pause
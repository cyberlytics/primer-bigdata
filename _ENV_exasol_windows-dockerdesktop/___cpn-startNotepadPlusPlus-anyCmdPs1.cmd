@echo off
setlocal enableDelayedExpansion

rem ***************************************************************************
rem * author: Christoph P. Neumann
rem ***************************************************************************
cd /D "%~dp0"

set EXEC=NOTEPAD++.EXE

echo Going to open CMD, pwsh:PS1, bash:SH
rem echo Press ENTER to continue...
rem pause
for /R %%F in (*.cmd *.ps1) do ("%EXEC%" "%%~dpnxF")

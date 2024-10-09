@echo off
rem ***************************************************************************
rem * author: Christoph P. Neumann
rem ***************************************************************************
cd /D "%~dp0"

cmd /D/C eolConverter crlf "**/*.{cmd,bat,ps1,py,sql,scala,csv}"
cmd /D/C eolConverter lf "**/*.sh"

pause
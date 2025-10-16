@echo off
setlocal EnableExtensions EnableDelayedExpansion
rem ===========================================================================
rem * Author: Christoph Peter Neumann
rem ===========================================================================
cd /d "%~dp0"

rem ===========================================================================
rem * Drag-and-drop PowerShell wrapper for acompanying .ps1 file
rem ===========================================================================
if "%~1"=="" (
    echo Usage: Drag and drop a file onto this script to replace all matching files.
    pause
    exit /b 1
)
pwsh -NoProfile -ExecutionPolicy Bypass -File "%~dpn0.ps1" -SourceFile "%~f1"

pause
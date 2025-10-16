# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Output "PowerShell Version: $($PSVersionTable.PSVersion)"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1" -ErrorAction SilentlyContinue
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 # Set code page to UTF-8

Write-Output "`n==== PYTHON ===="
python --version
Write-Output "`n==== PANDAS===="
python -m pip show pandas

Write-Output "`nPress ENTER to continue..."
cmd /c Pause | Out-Null
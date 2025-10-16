# Run PowerShell Script as Administrator in the Same Directory as Original Script
Set-Location -Path $PSScriptRoot

Write-Output "PowerShell Version: $($PSVersionTable.PSVersion)"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1" -ErrorAction SilentlyContinue
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 # Set code page to UTF-8

Write-Host "Leaving Powershell, entering WSL:"
bash -c "cat /etc/os-release | grep PRETTY_NAME | sed -e 's/PRETTY_NAME=/> /g'"
bash -c "dos2unix *.sh > /dev/null 2>&1"
bash
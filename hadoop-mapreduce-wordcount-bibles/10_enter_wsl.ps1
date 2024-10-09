# Run PowerShell Script as Administrator in the Same Directory as Original Script
Set-Location -Path $PSScriptRoot

Write-Host "Leaving Powershell, entering WSL:"
bash -c "cat /etc/os-release | grep PRETTY_NAME | sed -e 's/PRETTY_NAME=/> /g'"
bash -c "dos2unix *.sh > /dev/null 2>&1"
bash
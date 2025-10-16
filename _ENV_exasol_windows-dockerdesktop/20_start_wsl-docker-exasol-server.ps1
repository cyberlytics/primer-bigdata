# Run PowerShell Script as Administrator in the Same Directory as Original Script
Set-Location -Path $PSScriptRoot

if ((Get-Service -Name com.docker.service).Status -ne 'Running') { Start-Service -Name com.docker.service }

docker start exasoldb
docker logs exasoldb

Write-Host "`nCHECK whether docker start exasoldb did execute WITHOUT ERROR!?"
Write-Host "`nFor your information (by Christoph P. Neumann) if everything worked out:"
Write-Host "`nAccess Exasol via:"
Write-Host "  HOST: localhost/NOCERTCHECK"
Write-Host "  PORT: 8563"
Write-Host "  USER: sys"
Write-Host "  PSWD: exasol"
Write-Host ""

Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null
# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Output "PowerShell Version: $($PSVersionTable.PSVersion)"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1" -ErrorAction SilentlyContinue
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 # Set code page to UTF-8

Write-Output "`n==== DOCKER ===="
docker --version

Write-Output "`n==== EXASOL IMAGE ===="
if ($(docker images -q exasol/docker-db)) {
    Write-Host "[OK] exasol/docker-db image is available."
}
else {
	Write-Host "[ERROR] exasol/docker-db image is NOT available" -ForegroundColor Red
}

Write-Output "`n==== EXASOL CONTAINER ===="
$container = docker ps --filter "name=exasoldb" --format "{{.Names}}"
if ($container -eq "exasoldb") {
    Write-Host "[OK] Container 'exasoldb' is running."
}
else {
    Write-Host "[WARNING] Container 'exasoldb' is NOT running." -ForegroundColor Yellow
}

Write-Output "`nPress ENTER to continue..."
cmd /c Pause | Out-Null
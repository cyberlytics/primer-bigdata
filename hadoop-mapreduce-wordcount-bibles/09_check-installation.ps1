# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Output "PowerShell Version: $($PSVersionTable.PSVersion)"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1" -ErrorAction SilentlyContinue
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 # Set code page to UTF-8

Write-Output "`n==== JAVA===="
bash -c "source ~/.sdkman/bin/sdkman-init.sh; java -version"
Write-Output "`n==== HADOOP===="
bash -c "source ~/.sdkman/bin/sdkman-init.sh; hadoop version"

Write-Output "`nPress ENTER to continue..."
cmd /c Pause | Out-Null
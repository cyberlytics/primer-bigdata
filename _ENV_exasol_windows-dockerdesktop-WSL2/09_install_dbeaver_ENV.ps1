# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

choco install dbeaver -y

Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null
# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

choco install wsl2 -y
choco install docker-desktop -y

Write-Host "`nFINISHED with preparing docker desktop environment."
Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null
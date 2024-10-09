# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

choco install mariadb -y --ignore-dependencies

Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null
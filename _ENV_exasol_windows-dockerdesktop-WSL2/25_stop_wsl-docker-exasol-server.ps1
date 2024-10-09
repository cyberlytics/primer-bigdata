# Run PowerShell Script as Administrator in the Same Directory as Original Script
Set-Location -Path $PSScriptRoot

# Stop:
docker exec -ti exasoldb dwad_client stop-wait DB1
docker stop exasoldb
docker kill exasoldb 2>$null

Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null
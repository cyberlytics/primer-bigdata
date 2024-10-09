# Run PowerShell Script as Administrator in the Same Directory as Original Script
Set-Location -Path $PSScriptRoot

# Stop:
docker kill exasoldb 2>$null
docker rm exasoldb 2>$null
docker volume rm exasoldb 2>$null

# Re-Init:
docker volume create exa_volume
docker run --name exasoldb  -p 127.0.0.1:8563:8563 -p 2580:2580 --detach --privileged --stop-timeout 120 -v exa_volume:/exa exasol/docker-db
docker start exasoldb
docker logs exasoldb

Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null
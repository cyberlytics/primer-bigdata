# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

if ((Get-Service -Name com.docker.service).Status -ne 'Running') { Start-Service -Name com.docker.service }

docker pull exasol/docker-db

docker volume create exa_volume

# Init (und start):
docker run --name exasoldb  -p 127.0.0.1:8563:8563 -p 2580:2580 --detach --privileged --stop-timeout 120 -v exa_volume:/exa exasol/docker-db

docker start exasoldb
docker logs exasoldb

Write-Host "`nFINISHED with preparing exasol server docker environment."
Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null
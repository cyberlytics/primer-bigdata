# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

bash -c "source ~/.sdkman/bin/sdkman-init.sh; sdk install spark"

Write-Host "`nFINISHED with preparing Hadoop and Spark installation inside WSL2/Ubuntu."
Write-Host "(You can re-enter ubuntu with PowerShell-command 'bash'!)"
Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null
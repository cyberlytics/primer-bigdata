# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

Enable-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart

Write-Host "`nFINISHED with preparing WindowsOptionalFeature environment."
Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null
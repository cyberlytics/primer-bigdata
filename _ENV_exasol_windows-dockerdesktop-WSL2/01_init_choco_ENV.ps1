# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RefreshEnv

choco feature enable -n stopOnFirstPackageFailure
choco feature enable -n allowGlobalConfirmation
choco feature enable -n allowEmptyChecksums
choco feature enable -n allowEmptyChecksumsSecure
choco feature enable -n useRememberedArgumentsForUpgrades

Write-Host "`nFINISHED with preparing chocolatey environment."
Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null
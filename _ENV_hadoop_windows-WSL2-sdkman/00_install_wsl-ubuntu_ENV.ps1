# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Output "PowerShell Version: $($PSVersionTable.PSVersion)"
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1" -ErrorAction SilentlyContinue
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 # Set code page to UTF-8

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RefreshEnv

choco feature enable -n stopOnFirstPackageFailure
choco feature enable -n allowGlobalConfirmation 
choco feature enable -n allowEmptyChecksums
choco feature enable -n allowEmptyChecksumsSecure
choco feature enable -n useRememberedArgumentsForUpgrades 

choco install lxrunoffline --limit-output

Write-Host "List of the Linux distributions installed on your Windows machine:"
wsl --list --verbose
Write-Host "List of the Linux distributions available through the online store"
wsl --list --online

# install Ubuntu
Write-Host "`nBEWARE: After 'wsl --install ...', you are in BASH and must return to POWERSHELL!"
Write-Host "Please exit bash after successful completion of the distro installation!"
Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null
wsl --install "Ubuntu-24.04"

Write-Host "`nYes, we are now back to PowerShell"
Write-Host "(You can re-enter ubuntu with PowerShell-command 'bash'!)"
Write-Host "We are finished with this ps1-Script and we will exit the console."
Write-Output "Press ENTER to continue..."
cmd /c Pause | Out-Null
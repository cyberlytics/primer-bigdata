[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [ValidateScript({ Test-Path $_ -PathType 'Leaf' })]
    [string]$SourceFile
)

$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

$FileName = [System.IO.Path]::GetFileName($SourceFile)
Write-Host "Replacing all `"$FileName`" files under '$PWD'..." -ForegroundColor Cyan

$replaced = 0
$errors = 0

try {
    [System.IO.Directory]::EnumerateFiles($PWD.Path, $FileName, [System.IO.SearchOption]::AllDirectories) |
        Where-Object { $_ -ne $SourceFile } |
        ForEach-Object {
            try {
                Copy-Item -Path $SourceFile -Destination $_ -Force
                Write-Host "Replaced: $_" -ForegroundColor Green
                $replaced++
            } catch {
                Write-Warning "Failed to replace $_. Error: $_"
                $errors++
            }
        }

    Write-Host "`nSummary: $replaced replaced, $errors errors." -ForegroundColor Cyan
} catch {
    Write-Error "Unexpected error: $_"
}

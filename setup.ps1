#Requires -RunAsAdministrator

$ScriptsPath = $PSScriptRoot + "\scripts"

Write-Output "Calling generate-symlinks.ps1"
.("$ScriptsPath\generate-symlinks.ps1")
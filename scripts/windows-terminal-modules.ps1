Install-Module posh-git -Force -Scope CurrentUser
Install-Module oh-my-posh -Force -Scope CurrentUser
Install-Module Terminal-Icons -Force -Scope CurrentUser -Repository PSGallery

Import-Module oh-my-posh
Import-Module posh-git
Set-PoshPrompt Aliens

Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

function make-backup {
  param(
    [string]$fileName
  )

  Rename-Item -Path $fileName -NewName $(-join ($fileName, ".bak"))
}

if (Test-Path -Path $env:userprofile\Documents\PowerShell\Microsoft.PowerShell_profile.ps1) {
  Write-Host "Warning! There is already a powershell core profile, saving backup..." -ForegroundColor Yellow
  make-backup $env:userprofile\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
}

if (Test-Path -Path $env:userprofile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1) {
  Write-Host "Warning! There is already a powershell profile, saving backup..." -ForegroundColor Yellow
  make-backup $env:userprofile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
}

Copy-Item ..\configs\powershell\profile.ps1 $env:userprofile\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
Copy-Item ..\configs\powershell\profile.ps1 $env:userprofile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

#Requires -RunAsAdministrator

# Copy and load modules
$modulesPath = "$home\Documents\WindowsPowerShell\Modules"

# - utilities
New-Item -ItemType Directory -Force -Path $modulesPath\utilities | Out-Null
Copy-Item .\utilities.psm1 -Destination $modulesPath\utilities\utilities.psm1 | Out-Null

Import-Module utilities

$ScriptsPath = $PSScriptRoot + "\scripts"
$ConfigurationsPath = $PSScriptRoot + "\configs"

# 
# Chocolatey
#
RunAction -m "(SETUP) Installing Chocolatey..." -a { 
	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
} 

#
# Vim
#
RunAction -m  "(SETUP) Installing Vim..." -a {
	choco install vim --yes --params '/NoDesktopShortcuts /NoDefaultVimrc'
}

#
# Git - Installation
#
RunAction -m  "(SETUP) Installing Git..." -a {
	choco install git --yes --params '/GitAndUnixToolsOnPath /WindowsTerminal'
}

#
# Git - Configuration
#
RunAction -m "(SETUP) Configuring Git..." -a {
	.("$ConfigurationsPath\git-config.ps1")
}

# Git - PS tooling
#Install-Module posh-git -Force -Scope CurrentUser
#Install-Module oh-my-posh -Force -Scope CurrentUser
#Set-Prompt
#Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
#Add-Content $PROFILE "`nImport-Module posh-git`nImport-Module oh-my-posh`nSet-Theme Paradox"
#
#Write-Output "(SETUP) Configuring windows explorer (windows-configs.ps1)"
#.("$ConfigurationsPath\windows-explorer-config.ps1")

#Write-Output "Calling generate-symlinks.ps1"
#.("$ScriptsPath\generate-symlinks.ps1")
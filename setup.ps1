#Requires -RunAsAdministrator

$ScriptsPath = $PSScriptRoot + "\scripts"
$ConfigurationsPath = $PSScriptRoot + "\configs"

# Copy and load modules
$modulesPath = "$home\Documents\WindowsPowerShell\Modules"

# - utilities
New-Item -ItemType Directory -Force -Path $modulesPath\utilities | Out-Null
Copy-Item .\utilities.psm1 -Destination $modulesPath\utilities\utilities.psm1 | Out-Null

Import-Module utilities

#
# Setup
#

# Chocolatey
RunAction -m "(SETUP) Installing Chocolatey..." -a { 
	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
} 

# Vim
RunAction -m  "(SETUP) Installing Vim..." -a {
	choco install vim --yes --params '/NoDesktopShortcuts /NoDefaultVimrc'
}

# Git - Installation
RunAction -m  "(SETUP) Installing Git..." -a {
	choco install git --yes --params '/GitAndUnixToolsOnPath /WindowsTerminal'
}

# Git - Configuration
RunAction -m "(SETUP) Configuring Git..." -a {
	.("$ConfigurationsPath\git-config.ps1")
}

# Windows Terminal Plugins
RunAction -m "(SETUP) Set-up Windows Terminal for Git (posh)" -a {
	Install-Module posh-git -Force -Scope CurrentUser
	Install-Module oh-my-posh -Force -Scope CurrentUser
	Set-Prompt
	Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
	Add-Content $PROFILE "`nImport-Module posh-git`nImport-Module oh-my-posh`nSet-Theme Paradox"
}

# Nerd Fonts
RunAction -m "(SETUP) Installing nerd-fonts..." -a {
	git clone https://github.com/ryanoasis/nerd-fonts.git
	Set-Location nerd-fonts
	.\install.ps1
	Set-Location ..\

	Write-Host "MANUALLY SETUP FONT ON WINDOWS TERMINAL CONFIG, MesloLGM NF" -ForegroundColor Red
}

# Windows Explorer Settings
RunAction -m "(SETUP) Configuring Windows Explorer settings..." -a {
	.("$ConfigurationsPath\windows-explorer-config.ps1")
}

# Symlinks
RunAction -m "(SETUP) Generating symlinks..." -a {
	.("$ScriptsPath\generate-symlinks.ps1")
}
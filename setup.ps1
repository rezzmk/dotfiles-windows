# Setup script;
# This script will take care of:
#   1) install chocolatey as a package manager
#   2) run software-installer script
#   3) run configuration scripts

#Requires -RunAsAdministrator

Import-Module utilities

$ScriptsPath = $PSScriptRoot + "\scripts"
$ConfigurationsPath = $PSScriptRoot + "\configs"

# Installs chocolatey
RunAction -m "(SETUP) Installing Chocolatey..." -a { 
	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
}

# Installs apps via chocolatey
RunAction -m  "(SETUP) Installing choco apps..." -a {
	.("$ScriptsPath\choco_install_apps.ps1")
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
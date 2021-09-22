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
	if (-Not (choco -v)) {
		Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
	}
}

# Installs apps via chocolatey
RunAction -m  "(SETUP) Installing choco apps..." -a {
	.("$ScriptsPath\choco_install_apps.ps1")
}

# Windows Terminal Plugins
RunAction -m "(SETUP) Installing windows terminal modules..." -a {
	.("$ScriptsPath\windows-terminal-modules.ps1")
}

# Nerd Fonts
if (-Not (Test-Path -Path "nerd-fonts")) {
	RunAction -m "(SETUP) Installing nerd-fonts..." -a {
		git clone https://github.com/ryanoasis/nerd-fonts.git
		Set-Location nerd-fonts
		.\install.ps1
		Set-Location ..\

		Write-Host "MANUALLY SETUP FONT ON WINDOWS TERMINAL CONFIG, MesloLGM NF" -ForegroundColor Red
	}
}

# Git - Configuration
RunAction -m "(SETUP) Configuring git..." -a {
	.("$ConfigurationsPath\git-config.ps1")
}

# Windows Settings
RunAction -m "(SETUP) Configuring Windows..." -a {
	.("$ConfigurationsPath\windows-config.ps1")
}

# Windows Explorer Settings
RunAction -m "(SETUP) Configuring Windows Explorer settings..." -a {
	.("$ConfigurationsPath\windows-explorer-config.ps1")
}

# Symlinks
RunAction -m "(SETUP) Generating symlinks..." -a {
	.("$ScriptsPath\generate-symlinks.ps1")
}

# Install WSL2 with ubuntu
wsl --install

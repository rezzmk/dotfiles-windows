# Yeah we need to run this as administrator to create a symbolic link :)
#Requires -RunAsAdministrator


# The reason we do this and not something like '../../dotfiles-common' is because I'll be calling this script
# from deeper directories and in order to not make it break this is the best way I found. It's ugly af but so is Windows and Powershell
Write-Output "Generating Symlinks, listing variables..."
$DotfilesCommonPath = "$(Split-Path (Split-Path $PSScriptRoot -Parent) -Parent)" + "\dotfiles-common" 

Write-Output "`tdotfiles-common path: $DotfilesCommonPath"

# For jetbrains ideavim plugin configuration
# This assumes you have dotfiles-common repo cloned on your machine
Write-Output "`nSymlinking $DotfilesCommonPath\vim\.ideavimrc to ~\.ideavimrc  (.ideavimrc is used to configure ideavim on jetbrains IDE)"
New-Item -ItemType SymbolicLink -Path "~\.ideavimrc" -Target "$DotfilesCommonPath\vim\.ideavimrc"
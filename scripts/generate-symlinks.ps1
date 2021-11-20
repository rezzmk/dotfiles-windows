# This assumes you have dotfiles-common repo cloned on your machine
$AppData = $env:APPDATA
$UserProfile = $env:USERPROFILE
$DotfilesCommonPath = "$(Split-Path (Split-Path $PSScriptRoot -Parent) -Parent)" + "\dotfiles-common" 

function Symlink {
	Param (
         [Parameter(Mandatory=$true, Position=0)] [string] $TargetPath,
         [Parameter(Mandatory=$true, Position=1)] [string] $SourcePath
    )

	Write-Output "`nSymlinking $TargetPath to $SourcePath"
	New-Item -ItemType SymbolicLink -Path "$SourcePath" -Target "$TargetPath"
}

Write-Output "Generating Symlinks, listing variables..."
Write-Output "`tdotfiles-common path: $DotfilesCommonPath"
Write-Output "`tapp-data path: $AppData"
Write-Output "`tuser-profile path: $AppData"

#
# VIM stuff
#
Symlink "$DotfilesCommonPath\vim\ideavimrc" "~\.ideavimrc" 
Symlink "$DotfilesCommonPath\vim\vimrc" "~\.vimrc" 
# Installs vundle
git clone https://github.com/VundleVim/Vundle.vim.git $home/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

#
# Powershell stuff
#
Symlink "$DotfilesCommonPath\powershell\profile.ps1" $env:userprofile\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
Symlink "$DotfilesCommonPath\powershell\profile.ps1" $env:userprofile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

# VS Code extensions and settings
#if ($false) {
#    Symlink "$DotfilesCommonPath\vscode\config\settings.json" "$AppData\Code\User\settings.json" 
#    
#    # Behold bitches!
#    Write-Output "`nSymlinking extensions like a true professional gamer"
#    $VsCodeExtensionsPath = $DotfilesCommonPath + "\vscode\extensions"
#    $Extensions = Get-ChildItem $VsCodeExtensionsPath | Where-Object {$_.PSIsContainer} | Foreach-Object {$_.Name}
#    Write-Output "The following extensions are going to be symlinked: $Extensions"
#    Foreach($extension in $Extensions) {
#    	Symlink "$VsCodeExtensionsPath\$extension" "$UserProfile\.vscode\extensions\$extension"
#    }
#}

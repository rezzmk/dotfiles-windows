Import-Module posh-git
Import-Module oh-my-posh

Set-PoshPrompt -Theme Aliens

cd "C:\@\appointmaster\repo-main"

function reload-profile { & $PROFILE }
function get-git-status { git status }
function git-lfg { git add .; git commit -m $args; git push }
function edit-config-ini { vim C:\@\appointmaster\shared\config\config.ini }
function edit-win-term-profile { 
  vim %LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json 
}
function edit-current-posh-theme {
  $returnValue = $(Get-PoshContext)
  vim $returnValue[0]
}

Set-Alias -Name reload -Value reload-profile
Set-Alias -Name gst -Value get-git-status
Set-Alias -Name config-ini -Value edit-config-ini
Set-Alias -Name config-winterm -Value edit-win-term-profile
Set-Alias -Name edit-theme -Value edit-current-posh-theme
Set-Alias -Name lfg -Value git-lfg

#$HOST.UI.RawUI.WindowTitle = Get-Location

$env:POSH_GIT_ENABLED = $true

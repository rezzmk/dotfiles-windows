#Requires -RunAsAdministrator

function Set-Environment-Variable {
  param (
    [string]$name,
    [string]$value
  )

  [System.Environment]::SetEnvironmentVariable($name, $value, [System.EnvironmentVariableTarget]::User)
}

function Get-Environment-Value {
  param (
    [string]$name
  ) 

  return [System.Environment]::GetEnvironmentVariable($name, "User")
}

$JB_SHELL_SCRIPTS = "$env:userprofile\.dotfiles\dotfiles-common\jetbrains-shell-scripts"
if (!$(Get-Environment-Value("Path")).Contains($JB_SHELL_SCRIPTS)) {
	Write-Host "`tAdding $JB_SHELL_SCRIPTS to PATH..." -ForegroundColor Yellow
	$curPathValue = "$(Get-Environment-Value("Path"));$JB_SHELL_SCRIPTS"
	Set-Environment-Variable "Path" $curPathValue
}
else {
	Write-Host "`t$varToSet already exists in PATH, bypassing..." -ForegroundColor Green
}

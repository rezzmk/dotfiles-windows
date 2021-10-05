function ReloadPath {
	Write-Host "Updating path..." -ForegroundColor Blue

	$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") `
	    + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function RunAction {
	param(
		[Parameter(Mandatory=$false, Position=0)]
		[string] $m,

		[Parameter(Mandatory=$true, Position=1)]
		[ScriptBlock] $a
	)

	Write-Host $m -ForegroundColor Red
	$a.Invoke()
	Write-Host "Done" -ForegroundColor Green
	ReloadPath
}

function ChocoInstallApps {
  param(
    [Parameter(Mandatory=$true, Position=0)]
    [string[]] $apps
  )

  foreach ($app in $apps) {
    $res = (choco list -lo | Where-Object { $_.ToLower().StartsWith($app.ToLower()) })
    if ($null -eq $res) {
      Write-Host "Installing $app..." -ForegroundColor Yellow
      & choco install $app --yes --limit-output --log-file choco.log
    }
    else {
      Write-Host "$app already installed!" -ForegroundColor Green
    }
  }
}

function ChocoInstallWinFeatures {
  param(
    [Parameter(Mandatory=$true, Position=0)]
    [string[]] $apps
  )

  foreach ($app in $apps) {
    Write-Host "Installing $app..." -ForegroundColor Yellow
    & choco install $app --yes --source windowsfeatures --log-file choco.log
  }
}

Export-ModuleMember -Function RunAction
Export-ModuleMember -Function ReloadPath
Export-ModuleMember -Function ChocoInstallApps
Export-ModuleMember -Function ChocoInstallWinFeatures

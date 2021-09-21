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

Export-ModuleMember -Function RunAction
Export-ModuleMember -Function ReloadPath
$appList = "googlechrome,firefox,7zip,dotnetcore-sdk,dotnetcore-windowshosting"
if ([string]::IsNullOrWhiteSpace($appList) -eq $false) {
	$appArray = $appList -split "," | foreach { "$($_.Trim())" }

	foreach ($app in $appArray) {
		Write-Host "Installing $app ..."
		& choco install $app /y
	}
}
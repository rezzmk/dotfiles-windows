[string[]]$applicationsArray = Get-Content -Path choco-apps-to-install.txt

foreach ($app in $applicationsArray) {
	Write-Host "Installing $app ..."
	& choco install $app /y
}

Write-Host "Installing applications with custom parameters..."

choco install vim --yes --params '/NoDesktopShortcuts /NoDefaultVimrc'
choco install git --yes --params '/GitAndUnixToolsOnPath /WindowsTerminal'
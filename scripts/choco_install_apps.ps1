[string[]]$installedApplications = choco list --local-only --limit-output
[string[]]$applicationsArray = Get-Content -Path choco-apps-to-install.txt

for ($i = 0; $i -lt $installedApplications.Count; $i++) {
	$installedApplications[$i] = $installedApplications[$i].Split("|")[0]
}

foreach ($app in $applicationsArray) {
	if (-Not ($installedApplications -contains $app)) {
		Write-Host "Installing $app ..." -ForegroundColor Yellow
		& choco install $app --yes --limit-output
	}
	else {
		Write-Host "$app is already installed!" -ForegroundColor Red
	}
}

Write-Host "Installing applications with custom parameters..."

# TODO: This is fugly, fix it
if (-Not ($installedApplications -contains "git")) {
	Write-Host "Installing vim..." -ForegroundColor Yellow
	choco install vim --yes --params '/NoDesktopShortcuts /NoDefaultVimrc'
}
else {
	Write-Host "vim is already installed!" -ForegroundColor Red
}

if (-Not ($installedApplications -contains "git")) {
	Write-Host "Installing git..." -ForegroundColor Yellow
	choco install git --yes --params '/GitAndUnixToolsOnPath /WindowsTerminal'
}
else {
	Write-Host "git is already installed!" -ForegroundColor Red
}
Import-Module Utilities

Push-Location $PSScriptRoot

[string[]]$applicationsArray = Get-Content -Path choco-apps-to-install.txt
[string[]]$dismFeatures = Get-Content -Path choco-windows-features-to-install.txt

# Install applications
ChocoInstallApps($applicationsArray)

# Install Windows Features
ChocoInstallWinFeatures($dismFeatures)

Pop-Location

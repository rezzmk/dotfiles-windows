$ModulesPath = "$home\Documents\WindowsPowerShell\Modules"

function LoadUtilities {
	New-Item -ItemType Directory -Force -Path $ModulesPath\utilities | Out-Null
	Copy-Item .\utilities.psm1 -Destination $ModulesPath\utilities\utilities.psm1 | Out-Null
}

# Loads the utilities module.
# It will rewrite any existent utilities module
LoadUtilities

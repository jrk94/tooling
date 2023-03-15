### environment variables vars
$env:TOOLING_REPO = "$PSScriptRoot/../.."
$env:LOCAL_DOMAIN = "jopereira.local"

# Check if PowerShell is running with administrative privileges
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if(!$IsAdmin)
{
	Write-Host "PowerShell is not running with administrative privileges" -ForegroundColor Yellow
}

### terminal customizations
. $PSScriptRoot/scripts/terminal-customizations.ps1

### git
## CREDITS: https://github.com/gluons/powershell-git-aliases
Install-Module git-aliases -Scope CurrentUser -AllowClobber -Force

### wsl
. $PSScriptRoot/scripts/wsl-alias.ps1

### tooling
Set-Alias -Name portainer-stacks "$env:TOOLING_REPO/pwsh/portainer/portainer-manage-stacks.ps1" -Option AllScope

#region lazy alias

function chocoupgrade {
	choco upgrade all -y
}

function ansible {
	docker run --rm -ti -v ${pwd}:/local ansible bash
}

function open {
	explorer .
	Clear-Host
}

function drive {
	Set-Location "G:/My Drive"
	Clear-Host
}

function temp {
	$myTemp = "C:/_temp"
	if (!(Get-Item $myTemp)) {
		New-Item -ItemType Directory -Path $myTemp
	}
	Set-Location $myTemp
	Clear-Host
}

#endregion

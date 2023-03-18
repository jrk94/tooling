### environment variables
$env:TOOLING_REPO = "$PSScriptRoot/../.."
$env:LOCAL_DOMAIN = $env:LOCAL_DOMAIN ?? "jopereira.local"

### pre-requirements
# chocolatey
$global:IS_CHOCO_INSTALLED = [bool](Get-Command choco -ErrorAction SilentlyContinue)
if($IsWindows -and !$global:IS_CHOCO_INSTALLED)
{
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

### global variables
# Check if PowerShell is running with administrative privileges
$global:IS_ADMIN = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if($IsWindows -and !$global:IS_ADMIN)
{
	Write-Host "PowerShell is not running with administrative privileges. Some features may not work." -ForegroundColor Yellow
}



### terminal customizations
. $PSScriptRoot/scripts/terminal-customizations.ps1

### git-aliases
#### CREDITS: https://github.com/gluons/powershell-git-aliases
Import-Module "$env:TOOLING_REPO/pwsh/profile/plugins/git-aliases/src/git-aliases.psd1" -DisableNameChecking

### wsl
. $PSScriptRoot/scripts/wsl-alias.ps1

### tooling
Set-Alias -Name portainer-stacks "$env:TOOLING_REPO/pwsh/portainer/portainer-manage-stacks.ps1" -Option AllScope

### git subrepo
$env:GIT_SUBREPO_ROOT="$env:TOOLING_REPO/pwsh/profile/plugins/git-subrepo"
$env:PATH="$env:PATH;$env:GIT_SUBREPO_ROOT/lib"
$env:MANPATH="$env:GIT_SUBREPO_ROOT/man"


#region lazy alias

function chocoupgrade { choco upgrade all -y }

function ansible { docker run --rm -ti -v ${pwd}:/local ansible bash }

function o { explorer .;Clear-Host }

#endregion

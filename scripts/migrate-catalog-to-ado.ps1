#Requires -Version 5.1
<#
  Import Aganox catalog from GitHub into Azure DevOps project Aga-Pay.
  See docs/AZURE_DEVOPS_MIGRATION.md
#>
param(
    [string] $Organization = "https://dev.azure.com/aganox",
    [string] $Project = "Aga-Pay",
    [switch] $ImportPrivate
)

$ErrorActionPreference = "Stop"

$repos = @(
    @{ AdoName = "standards";  GitHub = "aganox-standards"; Private = $false },
    @{ AdoName = "platform";   GitHub = "aganox";            Private = $true },
    @{ AdoName = "lms";        GitHub = "aganox-lms";        Private = $false },
    @{ AdoName = "identity";   GitHub = "aganox-identity";   Private = $false },
    @{ AdoName = "rental";     GitHub = "aganox-rental";     Private = $false },
    @{ AdoName = "keyvault";   GitHub = "aganox-keyvault";   Private = $true },
    @{ AdoName = "pay-site";   GitHub = "aga-pay-site";      Private = $false }
)

if (-not $env:AZURE_DEVOPS_EXT_PAT) {
    throw "Set AZURE_DEVOPS_EXT_PAT then: `$env:AZURE_DEVOPS_EXT_PAT | az devops login --organization $Organization"
}

az devops configure --defaults "organization=$Organization" "project=$Project" | Out-Null
az devops project show --project $Project -o none

foreach ($r in $repos) {
    if ($r.Private -and -not $ImportPrivate) {
        Write-Host "SKIP $($r.AdoName) (private; use -ImportPrivate)" -ForegroundColor Yellow
        continue
    }

    $existing = az repos list --query "[?name=='$($r.AdoName)'].id" -o tsv
    if (-not $existing) {
        az repos create --name $r.AdoName | Out-Null
    }

    $gitUrl = "https://github.com/Arun01-hub/$($r.GitHub).git"
    if ($r.Private) {
        if (-not $env:GITHUB_IMPORT_PAT) { throw "GITHUB_IMPORT_PAT required for $($r.GitHub)" }
        $env:AZURE_DEVOPS_EXT_GIT_SOURCE_PASSWORD_OR_PAT = $env:GITHUB_IMPORT_PAT
        az repos import create --repository $r.AdoName --git-source-url $gitUrl --requires-authorization true --user-name Arun01-hub
    } else {
        az repos import create --repository $r.AdoName --git-source-url $gitUrl --requires-authorization false
    }
    Write-Host "Import started: $($r.AdoName)"
}

az repos list -o table

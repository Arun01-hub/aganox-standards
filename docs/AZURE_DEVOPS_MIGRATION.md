# Migrate Aganox repos from GitHub to Azure DevOps

**Organization:** `https://dev.azure.com/aganox`  
**Project:** `Aga-Pay`  
**Strategy:** Dual-run (Azure Repos primary; GitHub mirror until cutover)

## CLI setup (done / required on each machine)

```powershell
az extension add --name azure-devops
```

### Authentication (required)

Entra token sign-in is often blocked by **Security Defaults**. Use a **Personal Access Token**:

1. Create PAT: `https://dev.azure.com/aganox/_usersSettings/tokens`  
   Scopes: **Code (Read & write)**, **Project and team (Read)**
2. In PowerShell (do not commit the token):

```powershell
$env:AZURE_DEVOPS_EXT_PAT = '<your-ado-pat>'
$env:AZURE_DEVOPS_EXT_PAT | az devops login --organization https://dev.azure.com/aganox
az devops configure --defaults organization=https://dev.azure.com/aganox project="Aga-Pay"
```

For **private GitHub** imports (`aganox`, `aganox-keyvault`), add a GitHub PAT with `repo` read:

```powershell
$env:GITHUB_IMPORT_PAT = '<github-pat>'
```

## Automated import (catalog)

```powershell
# Public repos only first
./scripts/migrate-catalog-to-ado.ps1

# Include private GitHub repos
./scripts/migrate-catalog-to-ado.ps1 -ImportPrivate
```

| ADO repo | GitHub source |
|----------|----------------|
| `standards` | Arun01-hub/aganox-standards |
| `platform` | Arun01-hub/aganox (private) |
| `lms` | Arun01-hub/aganox-lms |
| `identity` | Arun01-hub/aganox-identity |
| `rental` | Arun01-hub/aganox-rental |
| `keyvault` | Arun01-hub/aganox-keyvault (private) |
| `pay-site` | Arun01-hub/aga-pay-site |

Clone URL pattern:

```
https://dev.azure.com/aganox/Aga-Pay/_git/<repo-name>
```

## Post-import

- Set branch policies on `main`
- Add `azure-pipelines.yml` per stack
- Update local `origin` or use dual remotes (`origin` = ADO, `github` = mirror)

See [REPOSITORY_STANDARDS.md](REPOSITORY_STANDARDS.md) for branching and CI expectations.

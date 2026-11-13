# Migrate Aganox repos from GitHub to Azure DevOps

This guide complements [APP_CATALOG.md](APP_CATALOG.md) and [REPOSITORY_STANDARDS.md](REPOSITORY_STANDARDS.md). GitHub remains the current source of truth until you complete cutover.

## Can we migrate?

**Yes.** All catalog apps are Git repos suitable for **Azure Repos** import or `git push --mirror`. Expect additional work for **CI/CD** (GitHub Actions → Azure Pipelines), **private repo auth**, and **Vercel** (if `pay-site` stays on Vercel, you may keep a GitHub mirror or switch deploy source to Azure DevOps).

## Cost (typical small team)

| Item | Notes |
|------|--------|
| Azure DevOps organization | No Azure subscription required to create an org |
| Git repos | Unlimited private repos on free tier |
| Users | First **5 users** free (Basic) |
| Pipelines | **1,800** Microsoft-hosted minutes/month free; parallel jobs may need paid tier |

Paid Azure **compute** (App Service, AKS, etc.) is separate — confirm before enabling production pipelines that deploy to Azure.

## Recommended Azure DevOps layout

| GitHub source | Azure DevOps repo name | Suggested project |
|---------------|------------------------|-------------------|
| `aganox-standards` | `standards` | **Aganox** (single shared project) |
| `aganox` | `platform` | Aganox |
| `aganox-lms` | `lms` | Aganox |
| `aganox-identity` | `identity` | Aganox |
| `aganox-rental` | `rental` | Aganox |
| `aganox-keyvault` | `keyvault` | Aganox |
| `aga-pay-site` | `pay-site` | Aganox |

Use one project **Aganox** with multiple repos (mirrors the catalog). Split into multiple projects only if you need strict permission boundaries.

**ADO URLs** will look like:

```
https://dev.azure.com/<org>/Aganox/_git/<repo-name>
```

## Prerequisites

1. Azure DevOps organization URL (example: `https://dev.azure.com/aganox`).
2. Project **Aganox** created with **Repos** enabled.
3. **Project Administrator** (or Create repository permission) for imports.
4. For **private** GitHub repos (`aganox`, `aganox-keyvault`): GitHub **fine-grained PAT** or classic PAT with `repo` read, or use mirror clone with your authenticated `gh` session locally.
5. Optional: `az extension add --name azure-devops` and `az devops login` / `az devops configure`.

Docs: [Import a Git repository](https://learn.microsoft.com/en-us/azure/devops/repos/git/import-git-repository?view=azure-devops).

## Migration methods

### Option A — Portal (good for one repo at a time)

1. **Repos** → **Import repository** (new repo) or **Import** on empty repo.
2. Paste GitHub clone URL (`https://github.com/Arun01-hub/<name>.git`).
3. For private sources: enable authorization; use GitHub PAT as password (username = GitHub username).

### Option B — Azure CLI (scriptable)

```powershell
az extension add --name azure-devops
az devops configure --defaults organization=https://dev.azure.com/<ORG> project=Aganox

# Create empty repo then import (example: public aganox-lms)
az repos create --name lms
az repos import create `
  --repository lms `
  --git-source-url https://github.com/Arun01-hub/aganox-lms `
  --requires-authorization false

# Private repo: set PAT in env (do not commit)
$env:AZURE_DEVOPS_EXT_GIT_SOURCE_PASSWORD_OR_PAT = '<github-pat>'
az repos import create `
  --repository platform `
  --git-source-url https://github.com/Arun01-hub/aganox `
  --requires-authorization true `
  --user-name Arun01-hub
```

### Option C — Mirror push (full history + tags, works offline)

```powershell
git clone --bare https://github.com/Arun01-hub/aga-pay-site.git
cd aga-pay-site.git
git push --mirror https://dev.azure.com/<ORG>/Aganox/_git/pay-site
```

Use a **PAT** or Git Credential Manager when prompted for Azure DevOps.

## Suggested migration order

1. `standards` — documents and templates land first.
2. `platform`, `identity`, `lms`, `rental`, `keyvault` — .NET/Rust backends.
3. `pay-site` — last if Vercel still pulls from GitHub until reconnect.

## Post-migration checklist (per repo)

- [ ] Default branch `main` verified in Azure Repos
- [ ] Branch policies on `main` (min 1 reviewer, build validation)
- [ ] Replace `.github/workflows/*.yml` with `azure-pipelines.yml` where CI is required
- [ ] Service connections for Azure deploy (Key Vault, App Service) — use Entra/workload identity where possible
- [ ] Update local remotes: `git remote set-url origin <ado-clone-url>`
- [ ] Update README clone URLs and catalog links
- [ ] Archive or mark GitHub repo read-only after cutover (optional mirror)

## CI/CD notes

| Stack | GitHub today | Azure target |
|-------|--------------|---------------|
| Next.js `pay-site` | Actions `ci.yml` | Pipeline: `npm ci`, lint, build; deploy to SWA/Vercel via service connection |
| .NET apps | Add `azure-pipelines.yml` | `UseDotNet@2`, `dotnet build/test` |
| Rust `keyvault` | Add pipeline | `cargo test`, `cargo clippy` |

GitHub-specific features (Dependabot, GitHub Issues templates) do not transfer; use **Azure Boards** and **Renovate** or **Dependabot on GitHub mirror** if you keep a mirror.

## What does *not* import automatically

- GitHub Issues / PRs / Discussions
- GitHub Actions secrets and environments
- Branch protection rules (re-create as Azure **branch policies**)
- Vercel project link (reconnect in Vercel or migrate hosting)

## Dual-run strategy (recommended)

Run **2–4 weeks** with Azure Repos as primary and GitHub as read-only mirror, or vice versa, until pipelines and deploys are green. Then disable GitHub Actions on the old remote.

## Verification script (after configure defaults)

```powershell
az repos list --project Aganox -o table
```

Record results in the catalog table below.

## Catalog tracking (update after migration)

| App repo | GitHub | Azure DevOps | Migrated | CI on ADO |
|----------|--------|--------------|----------|------------|
| standards | Arun01-hub/aganox-standards | | Pending | |
| platform | Arun01-hub/aganox | | Pending | |
| lms | Arun01-hub/aganox-lms | | Pending | |
| identity | Arun01-hub/aganox-identity | | Pending | |
| rental | Arun01-hub/aganox-rental | | Pending | |
| keyvault | Arun01-hub/aganox-keyvault | | Pending | |
| pay-site | Arun01-hub/aga-pay-site | | Pending | |

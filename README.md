# Aganox Repository Standards

Central standards for all **Aganox** application repositories. Use this repo as the source of truth for naming, layout, Git hosting, and migration.

## Quick links

| Document | Purpose |
|----------|---------|
| [docs/REPOSITORY_STANDARDS.md](docs/REPOSITORY_STANDARDS.md) | Required files, branching, releases, security |
| [docs/APP_CATALOG.md](docs/APP_CATALOG.md) | Active apps, target names, owners |
| [docs/ORG_MIGRATION.md](docs/ORG_MIGRATION.md) | GitHub org: create org, transfer repos |
| [docs/AZURE_DEVOPS_MIGRATION.md](docs/AZURE_DEVOPS_MIGRATION.md) | **GitHub → Azure DevOps** import and cutover |
| [templates/README.template.md](templates/README.template.md) | README structure for app repos |
| [templates/.github/](templates/.github/) | Copy-ready GitHub templates |

## Golden rules

1. **One repo = one deployable app or shared library** with a clear name (`aganox-<service>`).
2. **Default branch `main`**, protected in production.
3. **MIT license** unless legal specifies otherwise (see each repo `LICENSE`).
4. **No secrets in git** — use Key Vault / pipeline secret variables.
5. **Topics / tags**: `aganox` plus domain tags from the catalog.

## Hosting options

- **GitHub** (`aganox` org) — see [ORG_MIGRATION.md](docs/ORG_MIGRATION.md)
- **Azure DevOps** (`dev.azure.com/<org>/Aganox`) — see [AZURE_DEVOPS_MIGRATION.md](docs/AZURE_DEVOPS_MIGRATION.md)

Repos may live in one host or dual-run during migration; update [APP_CATALOG.md](docs/APP_CATALOG.md) when cutover completes.

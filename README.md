# Aganox Repository Standards

Central standards for all **Aganox** application repositories. Use this repo as the source of truth for naming, layout, GitHub settings, and migration into the **`aganox`** GitHub organization.

## Quick links

| Document | Purpose |
|----------|---------|
| [docs/REPOSITORY_STANDARDS.md](docs/REPOSITORY_STANDARDS.md) | Required files, branching, releases, security |
| [docs/APP_CATALOG.md](docs/APP_CATALOG.md) | Active apps, target org names, owners |
| [docs/ORG_MIGRATION.md](docs/ORG_MIGRATION.md) | Create org, transfer repos, update remotes |
| [templates/README.template.md](templates/README.template.md) | README structure for app repos |
| [templates/.github/](templates/.github/) | Copy-ready GitHub templates |

## Golden rules

1. **One repo = one deployable app or shared library** with a clear name (`aganox-<service>`).
2. **Default branch `main`**, protected in production org (see migration doc).
3. **MIT license** unless legal specifies otherwise (see each repo `LICENSE`).
4. **No secrets in git** — use Key Vault / environment secrets in CI.
5. **Topics** on every repo: `aganox` plus domain tags from the catalog.

## Status

The GitHub organization **`aganox`** must be created by an org owner (see [ORG_MIGRATION.md](docs/ORG_MIGRATION.md)). Repositories currently live under **`Arun01-hub`** until transfer completes.

## Applying standards to a repo

```bash
# From repo root (example: aganox-lms)
cp -r path/to/aganox-standards/templates/.github .
# Merge README sections from templates/README.template.md
# Set topics: gh repo edit --add-topic aganox --add-topic <domain>
```

On Windows, copy files from `templates\.github` manually or use `robocopy`.

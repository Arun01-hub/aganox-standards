# Aganox application catalog

**Active** application repositories (excludes archived `lms-pay` and legacy `aganox`). Target home: GitHub org **`aganox`**.

## Catalog

| App | Current repo | Target org repo | Stack | Visibility | Status |
|-----|--------------|-----------------|-------|------------|--------|
| Leave management (LMS) | [Arun01-hub/aganox-lms](https://github.com/Arun01-hub/aganox-lms) | `aganox/lms` | C# | Public | Pending transfer |
| Identity / auth | [Arun01-hub/aganox-identity](https://github.com/Arun01-hub/aganox-identity) | `aganox/identity` | C# | Public | Pending transfer |
| Property rental | [Arun01-hub/aganox-rental](https://github.com/Arun01-hub/aganox-rental) | `aganox/rental` | — | Public | Pending transfer |
| Key Vault utilities | [Arun01-hub/aganox-keyvault](https://github.com/Arun01-hub/aganox-keyvault) | `aganox/keyvault` | Rust | Private | Pending transfer |
| Aga Pay marketing site | [Arun01-hub/aga-pay-site](https://github.com/Arun01-hub/aga-pay-site) | `aganox/pay-site` | Next.js | Public | Pending transfer |
| Standards & templates | [Arun01-hub/aganox-standards](https://github.com/Arun01-hub/aganox-standards) | `aganox/standards` | Markdown | Public | **Source of truth** |

### Archived / out of scope

| Repo | Notes |
|------|--------|
| [Arun01-hub/aganox](https://github.com/Arun01-hub/aganox) | Archived **2026-11-14** — legacy monorepo (LMS + embedded auth/rental); superseded by split app repos; do not migrate |
| [Arun01-hub/lms-pay](https://github.com/Arun01-hub/lms-pay) | Archived — do not migrate |

## Suggested GitHub topics (by repo)

| Target repo | Topics |
|-------------|--------|
| `lms` | `aganox`, `dotnet`, `hr`, `leave-management` |
| `identity` | `aganox`, `dotnet`, `openid`, `authentication` |
| `rental` | `aganox`, `api`, `property` |
| `keyvault` | `aganox`, `rust`, `security`, `azure-keyvault` |
| `pay-site` | `aganox`, `nextjs`, `marketing`, `aga-pay` |
| `standards` | `aganox`, `documentation`, `governance` |

## Ownership

| Role | Responsibility |
|------|----------------|
| Org owner | Create `aganox` org, billing, SSO (future) |
| Repo admin | Transfer repos, branch protection |
| App team | CODEOWNERS, reviews, releases |

Update CODEOWNERS in each repo with real GitHub usernames or teams (`@aganox/platform-admins`).

# Repository standards

Applies to all **active Aganox application** repositories listed in [APP_CATALOG.md](APP_CATALOG.md).

## Naming

| Type | Pattern | Example |
|------|---------|--------|
| GitHub org repo | `aganox/<name>` | `aganox/lms` |
| Legacy / transfer name | `aganox-<name>` | `aganox-lms` (ok until rename) |
| Marketing / site | `aganox-<product>-site` or `aga-pay-site` | `aganox/pay-site` (target) |

Prefer short names under the org (`lms`, `identity`, `rental`, `keyvault`, `pay-site`, `platform`).

## Required repository files

| File | Required | Notes |
|------|----------|--------|
| `README.md` | Yes | Use [README template](../templates/README.template.md) |
| `LICENSE` | Yes | MIT default |
| `.gitignore` | Yes | Stack-appropriate |
| `.github/pull_request_template.md` | Yes | From templates |
| `AGENTS.md` | Yes | From [templates/.cursor/AGENTS.md.template](../templates/.cursor/AGENTS.md.template) |
| `.cursor/rules/*.mdc` | Yes | See [AI_DRIVEN_DEVELOPMENT.md](AI_DRIVEN_DEVELOPMENT.md) |
| `*.example` secret templates | Yes | One per gitignored secret path |
| `.github/dependabot.yml` | Yes | npm / nuget / cargo as applicable |
| `CODEOWNERS` | Recommended | `.github/CODEOWNERS` |
| Issue templates | Recommended | Bug + feature |

## Repository settings (GitHub)

- **Description**: One line — product name + purpose.
- **Website**: Production or docs URL when available.
- **Topics**: `aganox` + tags from catalog (e.g. `dotnet`, `payroll`, `nextjs`).
- **Features**: Issues on; Wiki off unless documented; Discussions optional.
- **Merge**: Squash merge preferred; delete head branches after merge.
- **Default branch**: `main`.

## Branching

- `main` — production-ready; protected after org setup.
- `feature/<ticket>-short-desc` — new work.
- `fix/<ticket>-short-desc` — bug fixes.
- `chore/<desc>` — tooling, deps only.

Releases: annotated tags `vMAJOR.MINOR.PATCH` (SemVer).

## CI expectations

| Stack | Minimum CI |
|-------|----------------|
| .NET (C#) | `dotnet build` + `dotnet test` on PR |
| Next.js / Node | `npm ci`, `npm run lint`, `npm run build` |
| Rust | `cargo fmt --check`, `cargo clippy`, `cargo test` |

Workflows live in `.github/workflows/`. Use org secrets, not repo plaintext secrets for production deploys.

## Security

- Enable **Dependabot** security updates and version updates.
- Enable **secret scanning** when available on the org plan.
- No credentials, connection strings, or API keys in source.
- Private repos: `aganox`, `aganox-keyvault`, and payroll-related code stay **private** unless explicitly approved public.

## Documentation structure (apps)

```
README.md           # Overview, run locally, deploy
AGENTS.md           # AI agent entry point (required)
/docs              # Optional ADRs, architecture
/.cursor/rules     # Cursor agent rules (.mdc)
/.github           # Templates, workflows, CODEOWNERS
```

See [AI_DRIVEN_DEVELOPMENT.md](AI_DRIVEN_DEVELOPMENT.md) for rule files, `AGENTS.md` sections, and committed `*.example` templates for gitignored secrets.

## Compliance checklist (per repo)

- [ ] README matches template sections
- [ ] `AGENTS.md` and `.cursor/rules/` (see AI-driven development doc)
- [ ] Committed `*.example` for each gitignored secret path
- [ ] LICENSE present
- [ ] `.github` templates copied
- [ ] Topics include `aganox`
- [ ] Transferred to `aganox` org (or tracked in catalog as pending)
- [ ] Remote updated for all developers
- [ ] CI runs on PR

# AI-driven development standards (Aganox)

How to set up **Cursor** and other AI coding agents for Aganox application repos. Governance docs live here; each app repo carries its own `AGENTS.md` and `.cursor/rules/`.

## Goals

- Give agents **repo-specific context** without leaking secrets.
- Keep behavior aligned with [REPOSITORY_STANDARDS.md](REPOSITORY_STANDARDS.md) and [APP_CATALOG.md](APP_CATALOG.md).
- Make local-only files **reproducible** via committed `*.example` templates.

## Required files (application repos)

| File | Purpose |
|------|---------|
| `AGENTS.md` | Entry point: product purpose, layout, scripts, cross-repo deps, test commands |
| `.cursor/rules/aganox-core.mdc` | Platform-wide agent rules (`alwaysApply: true`) |
| `.cursor/rules/<repo>-context.mdc` | Short repo facts (`alwaysApply: true`) |
| `.cursor/rules/<stack>.mdc` | Stack conventions (globs: `**/*.cs`, `**/*.ts`, etc.) |
| `.cursor/rules/no-billable-cloud-actions.mdc` | No paid Azure/Cloudflare mutations via agent |

Optional: `docs/adr/` for decisions the agent should respect.

## Required secret templates (committed)

For every **gitignored** local secret path, commit a matching example under `templates/gitignored/` (standards) and in the app repo:

| Ignored pattern | Committed template | Typical location |
|-----------------|--------------------|------------------|
| `appsettings.*.local.json` | `appsettings.Development.local.json.example` | ASP.NET host project |
| `.env` | `.env.example` | Node, Docker, Playwright |
| `.env*.local` | `.env.local.example` | Next.js |
| `.cursor/mcp.json` (if used locally) | `.cursor/mcp.json.example` | Personal MCP; optional |

Copy instructions: duplicate the example, drop `.example` / `.local.example` suffix, fill values locally, never commit.

## Bootstrap a new app repo

1. Copy from [templates/.cursor/](../templates/.cursor/) into the repo root.
2. Rename `AGENTS.md.template` → `AGENTS.md` and fill product sections.
3. Copy stack rule (`dotnet-aganox.mdc`, `nextjs-aganox.mdc`, `rust-tauri-aganox.mdc`).
4. Add `no-billable-cloud-actions.mdc` if the app deploys to Azure/Cloudflare.
5. Add `*.example` files for each gitignored secret path (see [templates/gitignored/README.md](../templates/gitignored/README.md)).
6. Link `AGENTS.md` from README under “Development”.

## Agent workflow

1. Read `AGENTS.md` and open catalog entry in this repo.
2. Use **scripts** in `scripts/` (PowerShell on Windows) instead of inventing one-off commands.
3. **Small diffs**; respect layer boundaries (.NET Clean Architecture, Rust crate graph, Next app router).
4. Run tests listed in `AGENTS.md` before finishing.
5. **No secrets in git** — update examples, not real `.env` / `*.local.json`.
6. **Cloud**: read-only discovery by default; see `no-billable-cloud-actions.mdc`.

## Multi-repo layout (local)

Sibling clones under `C:\Aganox\` (or your workspace root):

- `Aganox-Standards` — this repo (governance)
- `Aganox-Identity` — OIDC authority
- `Aganox-LMS`, `Aganox-Rental`, `Aganox-KeyVault`, `Aganox-Pay-Site` — apps

When a task spans services, state which repos change and integration order (usually Identity first).

## Standards repo (this repository)

- Markdown and templates only — no application runtime.
- Agents **must not** invent new catalog apps without updating `APP_CATALOG.md`.
- Prefer editing `docs/` and `templates/`; keep rules concise (&lt; 50 lines per `.mdc` when possible).

## Compliance checklist (AI)

- [ ] `AGENTS.md` present and accurate
- [ ] `.cursor/rules/` includes core + context + stack + cloud policy
- [ ] Every gitignored secret path has a committed `*.example`
- [ ] README links to `AGENTS.md` and aganox-standards AI doc
- [ ] No `.env` or `*.local.json` tracked in git
# Gitignored file templates

Committed **examples** for files that must never be checked in. Developers and AI agents copy these to the paths in each app’s `.gitignore`.

| Template file | Copy to (typical) |
|---------------|-------------------|
| `dotnet-appsettings.Development.local.json.example` | `appsettings.Development.local.json` next to the API/Identity host |
| `playwright-ui-tests.env.example` | `tests/**/.env` for Playwright |
| `keyvault-deploy.env.example` | `deploy/.env` for Docker stack |
| `nextjs-env.local.example` | `.env.local` at Next.js app root |
| `cursor-mcp.json.example` | `.cursor/mcp.json` (optional local MCP) |
| `android-local.properties.example` | `apps/mobile/android/local.properties` (KeyVault) |

After copy, remove `.example` from the filename (or use the naming shown in the app README). Fill real secrets locally only.
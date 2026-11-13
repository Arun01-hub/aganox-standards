# Link repositories to the Aganox organization

## Prerequisites

1. Create the organization: [Create an organization](https://github.com/organizations/plan) — use login **`aganox`** (or your chosen name; update catalog if different).
2. Authenticate GitHub CLI with org admin scope:

```bash
gh auth refresh -h github.com -s admin:org,repo,workflow
```

3. Add yourself (and teammates) as **Owners** on the org.

## Recommended org settings

- Base permissions: **Read** for members; grant per-repo write via teams.
- Create teams: `platform`, `payroll`, `identity`, `frontend`.
- Enable **2FA required** for org members (when team is ready).

## Transfer sequence

Transfer **`aganox-standards` first** so other repos can reference it.

For each repo in [APP_CATALOG.md](APP_CATALOG.md):

```bash
OWNER=Arun01-hub
ORG=aganox
REPO=aganox-lms   # example

gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  "/repos/${OWNER}/${REPO}/transfer" \
  -f new_owner="${ORG}"
```

Optional rename after transfer (example: `aganox-lms` → `lms`):

```bash
gh repo rename lms --repo aganox/aganox-lms
```

### Post-transfer: update local clones

```bash
git remote set-url origin https://github.com/aganox/lms.git
git fetch origin
```

### Post-transfer: GitHub settings

Run for each repo (adjust topics):

```bash
gh repo edit aganox/lms \
  --description "Aganox LMS — enterprise leave management" \
  --add-topic aganox --add-topic dotnet --add-topic hr
```

### Branch protection (example)

```bash
gh api \
  --method PUT \
  repos/aganox/lms/branches/main/protection \
  -f required_status_checks='{"strict":true,"contexts":["ci"]}' \
  -F enforce_admins=false \
  -f required_pull_request_reviews='{"required_approving_review_count":1}'
```

Adjust `contexts` to match your workflow job names.

## Vercel / CI remotes

After moving `pay-site`, reconnect Vercel to `aganox/pay-site` and verify deploy hooks.

## Verification checklist

- [ ] Org `aganox` exists
- [ ] All catalog repos show under `github.com/aganox`
- [ ] Standards repo at `aganox/standards` (or `aganox/aganox-standards`)
- [ ] Developers updated `origin` URL
- [ ] Topics and descriptions set
- [ ] Dependabot enabled on each repo

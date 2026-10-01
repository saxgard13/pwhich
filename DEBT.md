# Technical Debt

Known gaps and pending decisions. Each entry must be re-evaluated on its date or event.

## Quality

[NOTE][Debt][quality/lefthook] `source: feat/update` — lefthook not installed.
No git hook runs ShellCheck before a commit, so the "run ShellCheck before each commit" rule (see README, Development) depends on manual discipline.
Proposal: add `lefthook.yml` with a `pre-commit` hook running `shellcheck pwhich.sh install.sh uninstall.sh`.
Risk: low — a missed run can only let a style or minor bug reach a PR.
Re-evaluate: 2026-12 or on the next change to a shell script.

[NOTE][Debt][quality/gitleaks] `source: feat/update` — gitleaks not installed, no `.gitleaks.toml`.
Nothing scans staged files or git history for secrets. The project holds no secrets today (no `.env`, no credentials).
Proposal: add `.gitleaks.toml` (`useDefault = true`) and wire `gitleaks protect --staged --redact --exit-code=1` as a lefthook pre-commit hook, together with the ShellCheck hook above.
Risk: low — no secret is handled by the project; this is a safety net for future changes.
Re-evaluate: 2026-12 or on the first config or credential file added to the repo.

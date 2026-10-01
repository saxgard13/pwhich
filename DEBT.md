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

## Features

Goal: answer "how did I install this application, and how do I update it?" reliably. Today `pwhich` does a name-based search, not an ownership check, and gives no update guidance.

[NOTE][Debt][feature/owner-lookup] `source: feat/update` — APT lookup is name-based, not file-based.
`dpkg -l "*$app*"` returns every package whose name contains the input (e.g. `pwhich c++` lists `libstdc++6`, unrelated libraries), not the package that installed the binary.
Proposal: resolve the real path (`readlink -f`) and ask APT which package owns it (`dpkg -S <path>`). Keep the name-based search only as a fallback when the binary is not in PATH (e.g. GUI-only applications).
Risk: low — output is noisy and can mislead, nothing breaks.
Re-evaluate: 2026-12 or before adding any new lookup source.

[NOTE][Debt][feature/path-detection] `source: feat/update` — installs outside APT/Snap/Flatpak are not detected.
Manual installs show only "Executable: <path>" with no conclusion. The real path reveals the origin:
`/snap/` → Snap · `/var/lib/flatpak/` or `~/.local/share/flatpak/` → Flatpak · `/opt/` → manual install ·
`~/.local/bin/` → user install (pip, pipx, script) · `~/.nvm/` → npm · `~/.cargo/bin/` → cargo · `*.AppImage` → AppImage.
Risk: low — missing detection, not a defect.
Re-evaluate: 2026-12 or on the first manual install that pwhich fails to explain.

[NOTE][Debt][feature/verdict-line] `source: feat/update` — no summary line.
Results are a list the user must interpret. Proposal: print a verdict line first, e.g. `✅ Installed via: Snap`, or `❓ Origin unknown (manual install?)` when nothing matches.
Depends on: feature/owner-lookup and feature/path-detection (the verdict needs reliable origin detection).
Risk: low — usability only.
Re-evaluate: 2026-12 or together with feature/owner-lookup.

[NOTE][Debt][feature/install-history] `source: feat/update` — optional extra context for APT packages.
Proposal: tell whether the package was installed manually or pulled in as a dependency (`apt-mark showmanual`), and show the install date from `/var/log/apt/history.log`.
Risk: none — nice-to-have.
Re-evaluate: 2027-01 or once the verdict line is implemented.

[NOTE][Debt][feature/update-hint] `source: feat/update` — no guidance on how to update the application.
Knowing the origin is only a means: the real need is knowing how to update the app, which depends on how it was installed. Proposal: after the verdict line, print an update hint per origin, and say whether the app updates itself.
- APT: `sudo apt update && sudo apt install --only-upgrade <package>` (or the Software Updater).
- Snap: automatic in the background; manual `sudo snap refresh <name>`.
- Flatpak: not automatic; `flatpak update <app-id>`.
- AppImage: no automatic update; close the app, download the new file, delete the old one, `chmod +x` the new one (some AppImages embed an updater).
- npm global: `npm update -g <package>` (per Node version when using nvm).
- cargo: `cargo install <crate>` to reinstall the latest version.
- pip / pipx: `pipx upgrade <package>`.
- `/opt` or archive: no general rule; download again from the vendor.
Edge case: a manually installed `.deb` is not updated by APT unless a third-party repository was added (e.g. Chrome, VS Code). The script should tell the two cases apart.
Scope: written hints only — no check for available updates (querying repositories is slow and much more complex).
Depends on: feature/path-detection (same origin detection, plus one hint text per origin).
Risk: low — usability only; hints may go stale if a tool changes its update command.
Re-evaluate: 2026-12 or together with feature/path-detection.

Suggested order: owner-lookup + verdict-line first (main gain), then path-detection together with update-hint (same detection mechanism), then install-history.

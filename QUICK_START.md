# Quick Start (Fork Operations)

## Weekly Routine

1. Double‑click `check-updates.bat`
2. If updates are available and acceptable → double‑click `safe-update.bat`
3. Resolve conflicts if prompted, then build and sanity test
4. Update `CUSTOM_CHANGES.md`

## Build

- Preferred: `Build-Skua.ps1` (see `BUILD.md`)
- Manual: `dotnet restore` → `dotnet build` per project

## Scripts

- `check-updates.bat` – Shows new upstream commits and changed files
- `safe-update.bat` – Creates backup, merges `upstream/master`, pushes `origin/master`

## After Updating

- Build Release x64 for `Skua.App.WPF` and `Skua.Manager`
- Launch apps to confirm startup and basic flows
- Optionally build MSI installers

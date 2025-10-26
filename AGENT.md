# Skua Fork Maintenance Agent

## Project Overview

This repository is a fork of `BrenoHenrike/Skua` maintained at `MehdiMamas/Skua`. Skua is a Windows desktop suite (.NET 6, WPF) with supporting tools and installers (WiX) for interacting with AQW.

Relevant top-level projects:

- `Skua.App.WPF` / `Skua.App.WPF.Lite` / `Skua.App.WPF.Follower` / `Skua.App.WPF.Sync` – main desktop apps
- `Skua.Manager` – auxiliary manager app
- `Skua.WPF` – shared components
- `Skua.Core*` – core libraries, generators, interfaces, models, utils
- `Skua.Installer*` – WiX Toolset projects (MSI installers)

See `BUILD.md` for complete build details.

## Your Role

Maintain a practical, conflict-resilient fork by:

- Keeping up with upstream changes while preserving local edits
- Documenting every deviation in `CUSTOM_CHANGES.md`
- Ensuring the repo builds cleanly (Debug/Release, x64/x86, installer optional)
- Adding improvements without diverging unnecessarily from upstream

## Critical Workflow

1. Run `check-updates.bat` to preview upstream commits and changed files
2. If acceptable, run `safe-update.bat` to merge with a timestamped backup branch
3. Resolve conflicts, preferring to keep upstream formatting and structure while reapplying minimal local changes
4. Build and smoke test apps (see Build & Test below)
5. Update `CUSTOM_CHANGES.md` (what/why/impact) and bump version notes

## Build & Test

- Pre-reqs: .NET 6 SDK+, Visual Studio 2022 (or Build Tools), WiX CLI (optional for installer)
- Quick build: use `Build-Skua.ps1` (see `BUILD.md` for parameters)
- Manual: `dotnet restore` then `dotnet build` per project/solution
- Installer: WiX projects in `Skua.Installer*` (optional)

Smoke tests to run after updates:

- Launch `Skua.App.WPF` (x64 Release) and verify UI loads, script loading works
- Launch `Skua.Manager`, verify it enumerates scripts and options
- Optionally build and install MSI; launch installed app

## Update Strategy (Fork Hygiene)

- Keep local edits as small, well-isolated commits
- Prefer targeted fixes in core libs or app code rather than broad refactors
- Track upstream formatting to minimize conflict churn
- Document every change in `CUSTOM_CHANGES.md`

## Likely Conflict Hotspots

- Shared UI (`Skua.WPF`) and large `Core` files tend to change upstream
- Installer definitions (`Skua.Installer*`), project files, and solution file
- Any file with manual region merges should be carefully reconciled

When merging:

- Keep upstream improvements, reapply local changes on top
- Avoid wholesale file replacement unless necessary; prefer minimal diffs

## Debugging Tips

- Use Visual Studio with Just My Code and first‑chance exceptions enabled
- Enable verbose build logs when diagnosing CI/build issues
- Validate runtime configuration files (e.g., `appsettings.json` in `Skua.Manager`)

## Documentation Discipline

- After each change: update `CUSTOM_CHANGES.md` (what/why/impact), and note date
- If you add processes or standards, expand this `AGENT.md`
- Keep `BUILD.md` accurate if build steps change

## Quick Checklist

- Preview upstream: `check-updates.bat`
- Safe merge with backup: `safe-update.bat`
- Build Debug/Release x64/x86
- Optional: build MSI
- Sanity run primary apps
- Update `CUSTOM_CHANGES.md`

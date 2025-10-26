# Fork Management & Update Strategy

## Remotes

- Origin (your fork): `https://github.com/MehdiMamas/Skua.git`
- Upstream (source): `https://github.com/BrenoHenrike/Skua.git`
- Tracking branch: `master` (this repo currently uses `master`)

Verify:

```bash
git remote -v
git branch --show-current
```

If `upstream` is missing:

```bash
git remote add upstream https://github.com/BrenoHenrike/Skua.git
```

## Update Workflow (Manual)

```bash
# Save work
git add . && git commit -m "Save work before upstream update"

# Ensure upstream exists
git remote get-url upstream || git remote add upstream https://github.com/BrenoHenrike/Skua.git

# Fetch upstream
git fetch upstream

# Preview changes
git log HEAD..upstream/master --oneline -10
git diff --name-only HEAD..upstream/master | wc -l

# Create backup branch (safety net)
git branch backup-before-update-$(date +%Y%m%d-%H%M%S)

# Merge
git merge upstream/master

# Resolve conflicts if any, then push
git push origin master
```

## Using the Scripts (Recommended)

- `check-updates.bat`: previews upstream commits and changed files
- `safe-update.bat`: saves work, creates timestamped backup, merges, and pushes

## Handling Conflicts

1. Open conflicted files, look for markers `<<<<<<<`, `=======`, `>>>>>>>`
2. Keep upstream improvements and reapply minimal local customizations
3. Build locally; run primary apps; fix any breakages
4. Commit resolved files and continue the merge

Tips:

- Prefer minimal diffs; avoid reformatting unrelated code
- If a file was heavily refactored upstream, reimplement your change on top of the new structure

## Post‑Update Testing

- Build Release x64 for `Skua.App.WPF` and `Skua.Manager`
- Launch apps to verify startup, basic navigation, and script loading
- Optionally build WiX installers and verify install/launch

## Recommended Cadence

- Weekly update checks, and before major development sessions
- After significant upstream releases

## Recovery

```bash
# Abort a problematic merge
git merge --abort

# Restore to backup
git reset --hard backup-before-update-YYYYMMDD-HHMMSS

# Restore a specific file to last commit
git checkout -- path/to/file
```

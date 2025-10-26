@echo off
REM Safe update from upstream/master with automatic backup and push

cd /d "D:\Upwork\Skua"

echo ============================================
echo   Safe Update from Upstream (Skua)
echo ============================================
echo.

REM Save current work
echo Step 1: Saving current work...
git add .
git commit -m "Auto-save before upstream update %date% %time%" 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo    (No changes to save)
)

REM Create timestamped backup branch
set BACKUP_BRANCH=backup-%date:~-4%%date:~-10,2%%date:~-7,2%-%time:~0,2%%time:~3,2%%time:~6,2%
set BACKUP_BRANCH=%BACKUP_BRANCH: =0%
echo.
echo Step 2: Creating backup branch: %BACKUP_BRANCH%
git branch %BACKUP_BRANCH%
echo    Backup created. Restore with: git reset --hard %BACKUP_BRANCH%

REM Ensure upstream exists and fetch
echo.
echo Step 3: Ensuring upstream remote and fetching...
git remote get-url upstream >nul 2>&1 || git remote add upstream https://github.com/BrenoHenrike/Skua.git
git fetch upstream

REM Check for updates
for /f %%i in ('git rev-list --count HEAD..upstream/master') do set COUNT=%%i
if "%COUNT%"=="0" (
    echo.
    echo ================================
    echo   Already up-to-date!
    echo   No updates to merge.
    echo ================================
    pause
    exit /b 0
)

REM Preview changes
echo.
echo Step 4: Preview of changes
echo -------------------------------------------
git log HEAD..upstream/master --oneline -5
echo -------------------------------------------
echo.
git diff --name-only HEAD..upstream/master > temp_files.txt
for /f %%i in ('find /c /v "" ^< temp_files.txt') do set FILECOUNT=%%i
echo Files to be changed: %FILECOUNT%
echo First 20 files:
more /e +0 temp_files.txt | findstr /n "^" | findstr /b "1: 2: 3: 4: 5: 6: 7: 8: 9: 10: 11: 12: 13: 14: 15: 16: 17: 18: 19: 20:"
del temp_files.txt

echo.
echo -------------------------------------------
set /p CONTINUE=Continue with merge? (y/N): 
if /i not "%CONTINUE%"=="y" (
    echo.
    echo Update cancelled. Backup branch %BACKUP_BRANCH% retained.
    pause
    exit /b 0
)

REM Merge
echo.
echo Step 5: Merging upstream/master...
git merge upstream/master
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ============================================
    echo   CONFLICTS DETECTED
    echo ============================================
    echo Resolve conflicts, then run:
    echo    git add <files> ^&^& git merge --continue
    echo To abort: git merge --abort
    echo To restore: git reset --hard %BACKUP_BRANCH%
    pause
    exit /b 1
)

REM Push
echo.
echo Step 6: Pushing to origin/master...
git push origin master

echo.
echo ============================================
echo   Update Complete
echo ============================================
echo Reminder: build and sanity test apps; update CUSTOM_CHANGES.md
pause



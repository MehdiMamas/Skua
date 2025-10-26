@echo off
REM Check for updates from upstream (BrenoHenrike/Skua) against current branch (master)

cd /d "D:\Upwork\Skua"

echo ============================================
echo   Checking for Upstream Updates (Skua)
echo ============================================
echo.

REM Ensure upstream remote exists
git remote get-url upstream >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Adding upstream remote...
    git remote add upstream https://github.com/BrenoHenrike/Skua.git
)

echo Fetching upstream...
git fetch upstream
echo.

echo Current branch:
git branch --show-current
echo.

REM Count commits ahead in upstream/master
for /f %%i in ('git rev-list --count HEAD..upstream/master') do set COUNT=%%i

if "%COUNT%"=="0" (
    echo ================================
    echo   Your fork is up-to-date!
    echo   No new commits from upstream.
    echo ================================
) else (
    echo ================================
    echo   NEW UPDATES AVAILABLE!
    echo ================================
    echo.
    echo Latest upstream commits:
    echo -------------------------------------------
    git log HEAD..upstream/master --oneline -10
    echo -------------------------------------------
    echo.
    echo Total new commits: %COUNT%
    echo.
    echo Computing changed files...
    git diff --name-only HEAD..upstream/master > temp_files.txt
    for /f %%i in ('find /c /v "" ^< temp_files.txt') do set FILECOUNT=%%i
    echo Files that will be affected: %FILECOUNT% file^(s^)
    echo.
    echo First 20 files:
    echo -------------------------------------------
    more /e +0 temp_files.txt | findstr /n "^" | findstr /b "1: 2: 3: 4: 5: 6: 7: 8: 9: 10: 11: 12: 13: 14: 15: 16: 17: 18: 19: 20:"
    del temp_files.txt 2>nul
    echo -------------------------------------------
    echo.
    echo Tip: run safe-update.bat to merge with a backup branch.
)

echo.
echo ============================================
echo   Done.
echo ============================================
pause



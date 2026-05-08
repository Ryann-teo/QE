@echo off
REM Double-click to push your latest changes to GitHub Pages.
REM Runs in this folder, prompts for a commit message, then pauses at the end.

setlocal enabledelayedexpansion
title QE Dashboard - Push Updates
color 0B
cd /d "%~dp0"

set REPO_URL=https://github.com/Ryann-teo/QE.git
set LIVE_URL=https://ryann-teo.github.io/QE/

echo.
echo ===============================================================
echo   QE Dashboard - push updates to GitHub Pages
echo ===============================================================
echo   Folder: %CD%
echo   Repo:   %REPO_URL%
echo   Live:   %LIVE_URL%
echo ===============================================================
echo.

REM Verify git is installed
where git >nul 2>nul
if errorlevel 1 (
  color 0C
  echo [ERROR] git is not installed or not on PATH.
  echo         Install Git for Windows: https://git-scm.com/download/win
  echo.
  pause
  exit /b 1
)

REM Verify this folder is a git repo. If not, offer to run setup.
if not exist ".git" (
  color 0E
  echo [INFO] No git repository here yet.
  echo        This is your first deploy.
  echo.
  set /p doSetup="Run setup-website.bat now to initialise and push? [Y/n]: "
  if /i "!doSetup!"=="" set doSetup=Y
  if /i "!doSetup!"=="Y" (
    call "%~dp0setup-website.bat"
    pause
    exit /b 0
  ) else (
    echo Aborting. Run setup-website.bat when ready.
    pause
    exit /b 1
  )
)

REM Show what's about to be committed
echo Status:
echo ---------------------------------------------------------------
git status -s
echo ---------------------------------------------------------------
echo.

REM Check for any changes
git diff --quiet
set DIFF1=%errorlevel%
git diff --cached --quiet
set DIFF2=%errorlevel%
git ls-files --others --exclude-standard --error-unmatch . >nul 2>nul
set UNTRACKED=%errorlevel%

if %DIFF1%==0 if %DIFF2%==0 if not %UNTRACKED%==0 (
  echo [OK] No changes detected. Nothing to push.
  echo.
  pause
  exit /b 0
)

REM Prompt for a commit message
echo.
set "MSG="
set /p MSG="Commit message (press Enter for 'Update QE dashboard'): "
if "%MSG%"=="" set "MSG=Update QE dashboard"

echo.
echo Staging changes...
git add .
if errorlevel 1 (
  color 0C
  echo [ERROR] git add failed.
  pause
  exit /b 1
)

echo Committing as: %MSG%
git commit -m "%MSG%"
if errorlevel 1 (
  color 0E
  echo [INFO] Nothing new to commit (working tree may already be clean).
)

echo.
echo Pushing to origin/main...
git push origin main
if errorlevel 1 (
  color 0C
  echo.
  echo [ERROR] push failed.
  echo.
  echo Common fixes:
  echo  - First-time push: run setup-website.bat instead.
  echo  - Authentication: when prompted for a password, paste a
  echo    GitHub Personal Access Token with 'repo' scope.
  echo  - Non-fast-forward: run 'git pull --rebase' then try again.
  echo.
  pause
  exit /b 1
)

color 0A
echo.
echo ===============================================================
echo   Pushed successfully.
echo   The live site rebuilds in 30 to 60 seconds:
echo     %LIVE_URL%
echo ===============================================================
echo.
pause

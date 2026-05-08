@echo off
REM One-time GitHub setup for the QE Dashboard.
REM Run this once. After that, use push-updates.bat to deploy changes.

setlocal

set REPO_URL=https://github.com/Ryann-teo/QE.git
set LIVE_URL=https://ryann-teo.github.io/QE/

cd /d "%~dp0"

echo === QE Dashboard: one-time GitHub setup ===
echo Folder: %CD%
echo Remote: %REPO_URL%
echo.

if not exist ".git" (
  echo Initialising git repository...
  git init
  git branch -M main
)

git remote get-url origin >nul 2>&1
if errorlevel 1 (
  echo Adding remote origin...
  git remote add origin %REPO_URL%
) else (
  echo Remote origin already configured.
)

echo Staging files...
git add .

git diff --cached --quiet
if errorlevel 1 (
  echo Creating initial commit...
  git commit -m "Initial commit: QE interactive dashboard"
) else (
  echo No changes to commit.
)

echo Pushing to GitHub...
git push -u origin main

echo.
echo === Done. ===
echo Now go to https://github.com/Ryann-teo/QE -^> Settings -^> Pages
echo Set Source to "Deploy from a branch", branch "main", folder "/ (root)" and save.
echo Your site will be live at %LIVE_URL% within ~60 seconds of saving.

endlocal

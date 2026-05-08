@echo off
title QE Dashboard - One-Time Setup
color 0B
cd /d "%~dp0"

set REPO_URL=https://github.com/Ryann-teo/QE.git
set LIVE_URL=https://ryann-teo.github.io/QE/

echo.
echo ==================================================================
echo   QE Dashboard - one-time GitHub setup
echo ==================================================================
echo   Folder: %CD%
echo   Remote: %REPO_URL%
echo ==================================================================
echo.

where git >nul 2>nul
if errorlevel 1 goto :nogit

if exist ".git" goto :hasrepo

echo Initialising git repository...
git init
git branch -M main

:hasrepo
git remote get-url origin >nul 2>nul
if errorlevel 1 git remote add origin %REPO_URL%

echo Staging files...
git add .

echo Committing...
git commit -m "Initial commit: QE interactive dashboard"

echo.
echo Pushing to GitHub...
git push -u origin main
if errorlevel 1 goto :pushfail

color 0A
echo.
echo ==================================================================
echo   Setup done.
echo ==================================================================
echo Now go to https://github.com/Ryann-teo/QE
echo   Settings -^> Pages
echo   Source = "Deploy from a branch"
echo   Branch = main, folder = / (root). Save.
echo Site will be live at %LIVE_URL% within ~60 seconds.
echo ==================================================================
echo.
pause
exit /b 0

:nogit
color 0C
echo [ERROR] git is not installed.
echo Install Git for Windows: https://git-scm.com/download/win
echo.
pause
exit /b 1

:pushfail
color 0C
echo.
echo [ERROR] push failed. Possible causes:
echo  1. Repo doesn't exist on GitHub yet. Create it (empty, no README) at:
echo       https://github.com/new   (name it "QE", owner "Ryann-teo")
echo  2. Authentication. Use a Personal Access Token, not your password.
echo  3. The remote main branch already has commits. Run:
echo       git pull --rebase origin main
echo     then re-run this script.
echo.
pause
exit /b 1

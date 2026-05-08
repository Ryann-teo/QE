@echo off
title QE Dashboard - Push Updates
color 0B
cd /d "%~dp0"

set REPO_URL=https://github.com/Ryann-teo/QE.git
set LIVE_URL=https://ryann-teo.github.io/QE/

echo.
echo ==================================================================
echo   QE Dashboard - push updates to GitHub Pages
echo ==================================================================
echo   Folder: %CD%
echo   Repo:   %REPO_URL%
echo   Live:   %LIVE_URL%
echo ==================================================================
echo.

where git >nul 2>nul
if errorlevel 1 goto :nogit

if not exist ".git" goto :noinit

echo Status:
echo ------------------------------------------------------------------
git status -s
echo ------------------------------------------------------------------
echo.

set "MSG="
set /p "MSG=Commit message (press Enter for 'Update QE dashboard'): "
if "%MSG%"=="" set "MSG=Update QE dashboard"

echo.
echo Staging changes...
git add .

echo Committing as: %MSG%
git commit -m "%MSG%"

echo.
echo Pushing to origin/main...
git push origin main
if errorlevel 1 goto :pushfail

color 0A
echo.
echo ==================================================================
echo   Pushed successfully.
echo   The live site rebuilds in 30 to 60 seconds:
echo     %LIVE_URL%
echo ==================================================================
echo.
pause
exit /b 0

:nogit
color 0C
echo [ERROR] git is not installed or not on PATH.
echo Install Git for Windows: https://git-scm.com/download/win
echo.
pause
exit /b 1

:noinit
color 0E
echo [INFO] No git repo here yet. Running setup-website.bat...
echo.
call "%~dp0setup-website.bat"
pause
exit /b 0

:pushfail
color 0C
echo.
echo [ERROR] git push failed.
echo.
echo Common fixes:
echo  - Authentication: when prompted for a password, paste a GitHub
echo    Personal Access Token with 'repo' scope (NOT your password).
echo    Get one at: GitHub.com -^> Settings -^> Developer settings
echo    -^> Personal access tokens -^> Tokens (classic) -^> Generate.
echo  - Non-fast-forward: someone pushed first. Run:
echo      git pull --rebase origin main
echo    then re-run this script.
echo  - First-time push: run setup-website.bat instead.
echo.
pause
exit /b 1

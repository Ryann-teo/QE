@echo off
REM Stage, commit, and push any changes to the QE Dashboard.
REM Pass an optional commit message: push-updates.bat "Tweak FWL derivation"

setlocal

set LIVE_URL=https://ryann-teo.github.io/QE/

cd /d "%~dp0"

if not exist ".git" (
  echo No git repo here yet. Run setup-website.bat first.
  exit /b 1
)

set "MSG=%~1"
if "%MSG%"=="" set "MSG=Update QE dashboard"

echo === QE Dashboard: pushing updates ===
git add .

git diff --cached --quiet
if not errorlevel 1 (
  echo No changes to commit. Nothing to push.
  exit /b 0
)

git commit -m "%MSG%"
git push origin main

echo.
echo Pushed. The live site will refresh in 30 to 60 seconds:
echo   %LIVE_URL%

endlocal

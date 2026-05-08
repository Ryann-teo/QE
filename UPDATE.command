#!/usr/bin/env bash
# Double-click on Mac, or run from Git Bash / Terminal.
# Prompts for a commit message, pushes to GitHub, waits for keypress.

set -e
cd "$(dirname "$0")"

REPO_URL="https://github.com/Ryann-teo/QE.git"
LIVE_URL="https://ryann-teo.github.io/QE/"

if [ -t 1 ]; then
  C_BOLD='\033[1m'; C_RED='\033[31m'; C_GRN='\033[32m'; C_YEL='\033[33m'; C_OFF='\033[0m'
else
  C_BOLD=''; C_RED=''; C_GRN=''; C_YEL=''; C_OFF=''
fi

pause(){ read -rn1 -p "Press any key to close..."; echo; }

echo
echo "=================================================================="
echo -e "${C_BOLD}  QE Dashboard - push updates to GitHub Pages${C_OFF}"
echo "=================================================================="
echo "  Folder: $(pwd)"
echo "  Repo:   $REPO_URL"
echo "  Live:   $LIVE_URL"
echo "=================================================================="
echo

if ! command -v git >/dev/null 2>&1; then
  echo -e "${C_RED}[ERROR] git is not installed or not on PATH.${C_OFF}"
  pause; exit 1
fi

if [ ! -d ".git" ]; then
  echo -e "${C_YEL}[INFO] No git repo here yet. Running setup-website.sh...${C_OFF}"
  bash "$(dirname "$0")/setup-website.sh"
  pause; exit 0
fi

echo "Status:"
echo "------------------------------------------------------------------"
git status -s
echo "------------------------------------------------------------------"
echo

read -rp "Commit message (press Enter for 'Update QE dashboard'): " MSG
MSG=${MSG:-Update QE dashboard}

echo
echo "Staging changes..."
git add .

echo "Committing as: $MSG"
git commit -m "$MSG" || echo -e "${C_YEL}[INFO] Nothing new to commit.${C_OFF}"

echo
echo "Pushing to origin/main..."
if git push origin main; then
  echo
  echo -e "${C_GRN}==================================================================${C_OFF}"
  echo -e "${C_GRN}  Pushed successfully.${C_OFF}"
  echo "  The live site rebuilds in 30 to 60 seconds:"
  echo "    $LIVE_URL"
  echo -e "${C_GRN}==================================================================${C_OFF}"
else
  echo -e "${C_RED}[ERROR] push failed.${C_OFF}"
  echo "Common fixes:"
  echo "  - First push: run ./setup-website.sh"
  echo "  - When prompted for a password, paste a GitHub Personal Access Token (repo scope)."
  echo "  - 'non-fast-forward' rejection: run 'git pull --rebase' then retry."
fi

pause

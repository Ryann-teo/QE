#!/usr/bin/env bash
# Double-click (Git Bash / Terminal) or run from the shell to push updates.
# Prompts for a commit message, runs the push, and waits for keypress.

set -e
cd "$(dirname "$0")"

REPO_URL="https://github.com/Ryann-teo/QE.git"
LIVE_URL="https://ryann-teo.github.io/QE/"

# Colours (ANSI). Skip if not a TTY.
if [ -t 1 ]; then
  C_BOLD='\033[1m'; C_DIM='\033[2m'; C_RED='\033[31m'; C_GRN='\033[32m'; C_YEL='\033[33m'; C_BLU='\033[36m'; C_OFF='\033[0m'
else
  C_BOLD=''; C_DIM=''; C_RED=''; C_GRN=''; C_YEL=''; C_BLU=''; C_OFF=''
fi

pause(){ read -rn1 -p "Press any key to close..."; echo; }

echo
echo "==============================================================="
echo -e "${C_BOLD}  QE Dashboard - push updates to GitHub Pages${C_OFF}"
echo "==============================================================="
echo "  Folder: $(pwd)"
echo "  Repo:   $REPO_URL"
echo "  Live:   $LIVE_URL"
echo "==============================================================="
echo

if ! command -v git >/dev/null 2>&1; then
  echo -e "${C_RED}[ERROR] git is not installed or not on PATH.${C_OFF}"
  pause; exit 1
fi

if [ ! -d ".git" ]; then
  echo -e "${C_YEL}[INFO] No git repository here yet.${C_OFF}"
  read -rp "Run setup-website.sh now? [Y/n]: " ans
  ans=${ans:-Y}
  if [[ "$ans" =~ ^[Yy] ]]; then
    bash "$(dirname "$0")/setup-website.sh"
    pause; exit 0
  else
    echo "Aborting."
    pause; exit 1
  fi
fi

echo "Status:"
echo "---------------------------------------------------------------"
git status -s
echo "---------------------------------------------------------------"
echo

if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  echo -e "${C_GRN}[OK] No changes detected. Nothing to push.${C_OFF}"
  pause; exit 0
fi

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
  echo -e "${C_GRN}===============================================================${C_OFF}"
  echo -e "${C_GRN}  Pushed successfully.${C_OFF}"
  echo "  The live site rebuilds in 30 to 60 seconds:"
  echo "    $LIVE_URL"
  echo -e "${C_GRN}===============================================================${C_OFF}"
else
  echo -e "${C_RED}[ERROR] push failed.${C_OFF}"
  echo "Common fixes:"
  echo "  - First-time push: run ./setup-website.sh"
  echo "  - When prompted for a password, paste a GitHub Personal Access Token (repo scope)."
  echo "  - 'non-fast-forward' rejection: run 'git pull --rebase' then retry."
fi

pause

#!/usr/bin/env bash
# One-time GitHub setup for the QE Dashboard.
# Run this once. After that, use ./push-updates.sh to deploy changes.

set -e

REPO_URL="https://github.com/Ryann-teo/QE.git"
LIVE_URL="https://ryann-teo.github.io/QE/"

cd "$(dirname "$0")"

echo "=== QE Dashboard: one-time GitHub setup ==="
echo "Folder: $(pwd)"
echo "Remote: $REPO_URL"
echo

if [ ! -d ".git" ]; then
  echo "Initialising git repository..."
  git init
  git branch -M main
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  echo "Adding remote origin..."
  git remote add origin "$REPO_URL"
else
  echo "Remote origin already configured."
fi

echo "Staging files..."
git add .

if git diff --cached --quiet; then
  echo "No changes to commit."
else
  echo "Creating initial commit..."
  git commit -m "Initial commit: QE interactive dashboard"
fi

echo "Pushing to GitHub..."
git push -u origin main

echo
echo "=== Done. ==="
echo "Now go to https://github.com/Ryann-teo/QE → Settings → Pages"
echo "Set Source to 'Deploy from a branch', branch 'main', folder '/ (root)' and save."
echo "Your site will be live at $LIVE_URL within ~60 seconds of saving."

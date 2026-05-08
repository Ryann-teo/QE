#!/usr/bin/env bash
# Stage, commit, and push any changes to the QE Dashboard.
# Pass an optional commit message: ./push-updates.sh "Tweak FWL derivation"

set -e

LIVE_URL="https://ryann-teo.github.io/QE/"

cd "$(dirname "$0")"

if [ ! -d ".git" ]; then
  echo "No git repo here yet. Run ./setup-website.sh first."
  exit 1
fi

MSG="${1:-Update QE dashboard}"

echo "=== QE Dashboard: pushing updates ==="
git add .

if git diff --cached --quiet; then
  echo "No changes to commit. Nothing to push."
  exit 0
fi

git commit -m "$MSG"
git push origin main

echo
echo "Pushed. The live site will refresh in 30 to 60 seconds:"
echo "  $LIVE_URL"

#!/usr/bin/env bash
# Mac Finder treats .command files as double-clickable.
# This is a thin wrapper around push-updates.sh.
cd "$(dirname "$0")"
exec bash "$(dirname "$0")/push-updates.sh"

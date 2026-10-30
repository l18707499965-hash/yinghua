#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_DIR"

if [[ ! -f "index.html" ]]; then
  echo "index.html not found in $PROJECT_DIR" >&2
  exit 1
fi

echo "Static site ready at $PROJECT_DIR"
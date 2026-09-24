#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_DIR"

EXPOSE_PORT="$(awk -F '[ =]+' '/^expose_port/ {gsub(/[^0-9]/, "", $2); print $2; exit}' "$PROJECT_DIR/.preview" 2>/dev/null || true)"
if [[ -z "$EXPOSE_PORT" ]]; then
  EXPOSE_PORT="${DEPLOY_RUN_PORT:-5000}"
fi

fuser -k "${EXPOSE_PORT}/tcp" 2>/dev/null || true
sleep 1

exec python3 -m http.server "$EXPOSE_PORT" --bind 0.0.0.0 --directory "$PROJECT_DIR"
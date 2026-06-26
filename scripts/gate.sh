#!/usr/bin/env bash
set -euo pipefail

gate="${1:-fast}"

case "$gate" in
  fast|medium|full|release)
    echo "foundry gate: $gate"
    ;;
  *)
    echo "Unknown gate: $gate" >&2
    exit 1
    ;;
esac

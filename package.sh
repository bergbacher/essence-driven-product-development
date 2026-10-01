#!/usr/bin/env bash
# Build one upload-ready zip per skill in dist/, for claude.ai skill upload.
#
# Usage:
#   ./package.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_DIR="$REPO_DIR/dist"

shopt -s nullglob
mkdir -p "$DIST_DIR"

found=0
for d in "$REPO_DIR"/*/; do
  [[ -f "${d}SKILL.md" ]] || continue
  name="$(basename "$d")"
  out="$DIST_DIR/$name.zip"
  rm -f "$out"
  (cd "$REPO_DIR" && zip -qr "$out" "$name" -x '*.DS_Store')
  echo "built: $out"
  found=1
done

if [[ $found -eq 0 ]]; then
  echo "no skills found in $REPO_DIR (looking for */SKILL.md)" >&2
  exit 1
fi

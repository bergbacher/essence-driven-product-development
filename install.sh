#!/usr/bin/env bash
# Symlink this repo's skills into ~/.claude/skills and/or ~/.codex/skills.
# Idempotent: re-running refreshes symlinks in place.
#
# Usage:
#   ./install.sh                # interactive prompt
#   ./install.sh claude         # non-interactive: claude only
#   ./install.sh codex          # non-interactive: codex only
#   ./install.sh both           # non-interactive: claude + codex

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${CLAUDE_HOME:-$HOME/.claude}"
CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"

prompt_target() {
  echo "Where do you want to install the skills?" >&2
  echo "  1) Claude  ($CLAUDE_DIR/skills)" >&2
  echo "  2) Codex   ($CODEX_DIR/skills)" >&2
  echo "  3) Both" >&2
  local choice
  read -r -p "Select [1/2/3]: " choice </dev/tty
  case "$choice" in
    1) echo "claude" ;;
    2) echo "codex" ;;
    3) echo "both" ;;
    *) echo "invalid choice: $choice" >&2; exit 1 ;;
  esac
}

target="${1:-}"
if [[ -z "$target" ]]; then
  target="$(prompt_target)"
fi

targets=()
case "$target" in
  claude) targets=("$CLAUDE_DIR") ;;
  codex)  targets=("$CODEX_DIR") ;;
  both)   targets=("$CLAUDE_DIR" "$CODEX_DIR") ;;
  *) echo "unknown target: $target (expected: claude | codex | both)" >&2; exit 1 ;;
esac

link() {
  local src="$1" dst="$2"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    echo "skip: $dst exists and is not a symlink" >&2
    return
  fi
  ln -snf "$src" "$dst"
  echo "linked: $dst -> $src"
}

shopt -s nullglob

# Skills are directories at the repo root containing a SKILL.md.
skills=()
for d in "$REPO_DIR"/*/; do
  [[ -f "${d}SKILL.md" ]] && skills+=("${d%/}")
done

if [[ ${#skills[@]} -eq 0 ]]; then
  echo "no skills found in $REPO_DIR (looking for */SKILL.md)" >&2
  exit 1
fi

for base in "${targets[@]}"; do
  mkdir -p "$base/skills"
  for src in "${skills[@]}"; do
    name="$(basename "$src")"
    # A copy synced from claude.ai would load alongside the symlink under the same name.
    for synced in "$base"/skills/synced/*/"$name"; do
      echo "warning: synced copy also present: $synced" >&2
    done
    link "$src" "$base/skills/$name"
  done
done

echo "done."

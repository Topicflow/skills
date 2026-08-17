#!/usr/bin/env bash
set -euo pipefail

# NOTE: dev-only, for maintainers of this repo. It is not a supported installer —
# managers should install via the Claude Code plugin or `npx skills@latest add
# Topicflow/skills` (see README.md).
#
# Symlinks every skill in this repo into the local skill directories used by each
# agent harness:
#   ~/.claude/skills  — Claude Code
#   ~/.agents/skills  — Codex and other Agent-Skills-compatible harnesses
# Because each entry is a symlink into this repo, `git pull` is all that is needed
# to keep the installed skills current.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DESTS=("$HOME/.claude/skills" "$HOME/.agents/skills")

names=()
srcs=()
while IFS= read -r -d '' skill_md; do
  src="$(dirname "$skill_md")"
  names+=("$(basename "$src")")
  srcs+=("$src")
done < <(find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -print0)

if [ "${#names[@]}" -eq 0 ]; then
  echo "error: no skills found under $REPO/skills" >&2
  exit 1
fi

for DEST in "${DESTS[@]}"; do
  # A $DEST symlinked into this repo would make us write the per-skill symlinks
  # back into the working copy. Bail out instead of polluting it.
  if [ -L "$DEST" ]; then
    resolved="$(readlink "$DEST")"
    case "$resolved" in
      "$REPO"|"$REPO"/*)
        echo "error: $DEST is a symlink into this repo ($resolved)." >&2
        echo "Remove it (rm \"$DEST\") and re-run; it will be recreated as a real dir." >&2
        exit 1
        ;;
    esac
  fi

  mkdir -p "$DEST"

  for i in "${!names[@]}"; do
    name="${names[$i]}"
    src="${srcs[$i]}"
    target="$DEST/$name"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
      rm -rf "$target"
    fi

    ln -sfn "$src" "$target"
    echo "linked $name -> $src ($DEST)"
  done
done

echo
echo "Done. ${#names[@]} skills linked into ${#DESTS[@]} destinations."
echo "Note: the references/ directory stays in the repo — skills link to it by"
echo "relative path, so a standalone symlink install will not resolve those links."

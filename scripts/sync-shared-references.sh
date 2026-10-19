#!/usr/bin/env bash
set -euo pipefail

# Copies the shared references into every skill that has its own references/ folder, so the
# skill folder works on its own (`npx skills add` installs one folder, not the repo).
# The repo copy in references/ is the source. Never edit a copy: edit the source, then run this.
#
# Usage: scripts/sync-shared-references.sh          write the copies
#        scripts/sync-shared-references.sh --check  exit 1 if a copy is missing or out of date

REPO="$(cd "$(dirname "$0")/.." && pwd)"
SHARED=(connect-topicflow.md interaction-controls.md)

mode="${1:-write}"
stale=0

while IFS= read -r refs; do
  for f in "${SHARED[@]}"; do
    src="$REPO/references/$f"
    dst="$refs/$f"
    want="$(printf '<!-- Copy of references/%s. Edit the source, then run scripts/sync-shared-references.sh. -->\n\n' "$f"; cat "$src")"
    if [ "$mode" = "--check" ]; then
      if [ ! -f "$dst" ] || [ "$(cat "$dst")" != "$want" ]; then
        printf 'out of date: %s\n' "${dst#"$REPO"/}"
        stale=1
      fi
    else
      printf '%s\n' "$want" > "$dst"
    fi
  done
done < <(find "$REPO/skills" -mindepth 3 -maxdepth 3 -type d -name references -not -path '*/later/*' | sort)

exit "$stale"

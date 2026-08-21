#!/usr/bin/env bash
set -euo pipefail

repo="$(cd "$(dirname "$0")/.." && pwd)"
version_file="$repo/VERSION"
plugin_json="$repo/.claude-plugin/plugin.json"
readme="$repo/README.md"

fail() {
  printf 'FAIL %s\n' "$1" >&2
  exit 1
}

[ -f "$version_file" ] || fail "missing VERSION"
[ -f "$plugin_json" ] || fail "missing .claude-plugin/plugin.json"
[ -f "$readme" ] || fail "missing README.md"

version="$(tr -d '[:space:]' < "$version_file")"
[[ "$version" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$ ]] \
  || fail "VERSION must be a SemVer release version"

python3 -m json.tool "$plugin_json" >/dev/null || fail "plugin.json is invalid JSON"
plugin_version="$(sed -n 's/^[[:space:]]*"version"[[:space:]]*:[[:space:]]*"\([0-9.]*\)".*/\1/p' "$plugin_json")"
[ "$plugin_version" = "$version" ] \
  || fail "plugin.json version '$plugin_version' does not match VERSION '$version'"

readme_version="$(sed -n 's/^Version \([0-9][0-9.]*\) —.*/\1/p' "$readme")"
[ "$readme_version" = "$version" ] \
  || fail "README version '$readme_version' does not match VERSION '$version'"

printf 'ok: version %s\n' "$version"

#!/usr/bin/env bash
set -uo pipefail

# Mechanical conformance check for every skill in this repo.
# It checks structure, not judgement — see CLAUDE.md for what review is for.
#
# Usage: scripts/check-skills.sh
# Exit 0 if everything passes, 1 on any error. Warnings do not fail the run.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
PLUGIN_JSON="$REPO/.claude-plugin/plugin.json"

# Target is ~150 body lines (library convention 1); the hard ceiling allows for prose
# hard-wrapped at 95 columns, which costs roughly twice the lines of unwrapped text.
TARGET_BODY_LINES=150
MAX_BODY_LINES=165

# Reference-style skills: no Method/Sources/Gate/Output, no eval cases. They hold
# vocabulary and checks for other skills rather than running a process.
REFERENCE_SKILLS="management-practices"

# save-context IS the write-back destination for every other skill, so requiring a
# '## Write-back' section in it would be circular.
NO_WRITEBACK_SECTION="save-context"

errors=0
warnings=0
checked=0
skill_errors=0

err()  { printf '  \033[31mFAIL\033[0m %s\n' "$1"; errors=$((errors + 1)); skill_errors=$((skill_errors + 1)); }
warn() { printf '  \033[33mWARN\033[0m %s\n' "$1"; warnings=$((warnings + 1)); }

is_reference_skill() {
  case " $REFERENCE_SKILLS " in *" $1 "*) return 0 ;; *) return 1 ;; esac
}

while IFS= read -r skill_md; do
  dir="$(dirname "$skill_md")"
  name="$(basename "$dir")"
  rel="${skill_md#"$REPO"/}"
  checked=$((checked + 1))
  skill_errors=0

  printf '\n%s\n' "$rel"

  # --- frontmatter ---------------------------------------------------------
  if [ "$(head -n 1 "$skill_md")" != "---" ]; then
    err "no frontmatter: first line must be ---"
    continue
  fi

  fm_end="$(awk 'NR>1 && /^---[[:space:]]*$/ {print NR; exit}' "$skill_md")"
  if [ -z "$fm_end" ]; then
    err "frontmatter is not closed with ---"
    continue
  fi

  fm="$(sed -n "2,$((fm_end - 1))p" "$skill_md")"

  fm_name="$(printf '%s\n' "$fm" | sed -n 's/^name:[[:space:]]*//p' | head -n 1)"
  fm_desc="$(printf '%s\n' "$fm" | sed -n 's/^description:[[:space:]]*//p' | head -n 1)"

  [ -n "$fm_name" ] || err "frontmatter is missing 'name'"
  [ -n "$fm_desc" ] || err "frontmatter is missing 'description'"

  if [ -n "$fm_name" ] && [ "$fm_name" != "$name" ]; then
    err "frontmatter name '$fm_name' does not match directory '$name'"
  fi

  case "$fm_desc" in
    *"Use when"*|*"use when"*) ;;
    *) err "description carries no 'Use when …' trigger (harnesses match on this)" ;;
  esac

  # Unknown frontmatter keys are not portable across harnesses.
  while IFS= read -r key; do
    case "$key" in
      name|description|allowed-tools|disable-model-invocation) ;;
      "") ;;
      *) warn "non-portable frontmatter key '$key'" ;;
    esac
  done < <(printf '%s\n' "$fm" | sed -n 's/^\([a-zA-Z][a-zA-Z0-9_-]*\):.*/\1/p')

  # --- body length --------------------------------------------------------
  total_lines="$(wc -l < "$skill_md" | tr -d ' ')"
  body_lines=$((total_lines - fm_end))
  if [ "$body_lines" -gt "$MAX_BODY_LINES" ]; then
    err "body is $body_lines lines, over the $MAX_BODY_LINES-line ceiling"
  elif [ "$body_lines" -gt "$TARGET_BODY_LINES" ]; then
    warn "body is $body_lines lines, over the ~$TARGET_BODY_LINES-line target"
  fi

  # --- required sections --------------------------------------------------
  if is_reference_skill "$name"; then
    grep -q '^## Worked example' "$skill_md" \
      || warn "reference skill has no '## Worked example'"
  else
    for section in "## When to use" "## Non-negotiables" "## Method" "## Sources" "## Output" "## Worked example"; do
      grep -q "^$section" "$skill_md" || err "missing section '$section'"
    done
    # Gate is required, even to say it does not apply.
    grep -q '^## Gate' "$skill_md" || err "missing section '## Gate' (say 'not applicable' if it is)"
    case " $NO_WRITEBACK_SECTION " in
      *" $name "*) ;;
      *) grep -q '^## Write-back' "$skill_md" \
           || err "missing section '## Write-back' (library convention 3)" ;;
    esac
  fi

  # --- output rules ------------------------------------------------------
  if grep -q '^|' "$skill_md"; then
    err "contains a markdown table; output must survive Slack mrkdwn (convention 5)"
  fi

  # --- backend neutrality (convention 2) ---------------------------------
  # Mechanical proxy: a skill with a Sources section must point at the capability
  # map, which is where the non-Topicflow paths are defined. Cannot verify that the
  # paths are correct — that is review.
  if grep -q '^## Sources' "$skill_md" && ! grep -q 'source-map.md' "$skill_md"; then
    err "Sources does not reference source-map.md (no skill may require Topicflow)"
  fi

  # --- companion files ---------------------------------------------------
  [ -f "$dir/agents/openai.yaml" ] || err "missing agents/openai.yaml (Codex/ChatGPT interface)"

  if ! is_reference_skill "$name"; then
    if [ -f "$REPO/evals/$name.md" ]; then
      grep -qi 'portability' "$REPO/evals/$name.md" \
        || err "evals/$name.md has no portability case (must run without Topicflow)"
    else
      err "missing evals/$name.md (5 cases required)"
    fi
  fi

  # --- registration ------------------------------------------------------
  if [ -f "$PLUGIN_JSON" ]; then
    grep -q "\"${dir#"$REPO"/}\"\|\"./${dir#"$REPO"/}\"" "$PLUGIN_JSON" \
      || err "not registered in .claude-plugin/plugin.json"
  else
    warn "no .claude-plugin/plugin.json to check registration against"
  fi

  if [ "$skill_errors" -eq 0 ]; then
    printf '  ok: %s (%s body lines)\n' "$name" "$body_lines"
  fi
done < <(find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' | sort)

# --- repo-level checks ---------------------------------------------------
printf '\n--- repo ---\n'
for f in references/management-practices.md references/library-conventions.md \
         references/topicflow-tools.md README.md CLAUDE.md LICENSE; do
  [ -f "$REPO/$f" ] || err "missing $f"
done

# Every eval file should correspond to a skill.
while IFS= read -r eval_md; do
  eval_name="$(basename "$eval_md" .md)"
  [ "$eval_name" = "README" ] && continue
  find "$REPO/skills" -type d -name "$eval_name" | grep -q . \
    || warn "evals/$eval_name.md has no matching skill"
done < <(find "$REPO/evals" -maxdepth 1 -name '*.md' 2>/dev/null | sort)

printf '\n%s skills checked, %s errors, %s warnings\n' "$checked" "$errors" "$warnings"
[ "$errors" -eq 0 ] || exit 1

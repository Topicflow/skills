# Working in this repo

This repo is a **library of agent skills for people managers**. It contains no application code.
Everything here is Markdown that an agent will read at runtime, which changes what "quality" means:
a wrong sentence in a SKILL.md is a bug that ships to every manager using it.

## Read before editing

1. [references/library-conventions.md](./references/library-conventions.md) — the eight rules every
   skill follows.
2. [references/management-practices.md](./references/management-practices.md) — the P1-P17 rules
   skills cite.
3. [references/source-map.md](./references/source-map.md) — the eight capabilities and every
   backend that supplies each one. **No skill may require Topicflow.** A manager on Notion, on an
   issue tracker, or on nothing at all still gets a working skill — what changes is how much it can
   see, and the skill always says which.
4. [references/topicflow-tools.md](./references/topicflow-tools.md) — what the Topicflow MCP
   actually offers. **Never invent a tool or a parameter.** If a skill needs something that does not
   exist, document the fallback in the skill and add the gap to this file.

## Anatomy of a skill

```
skills/<category>/<skill-name>/
  SKILL.md            frontmatter + body, under ~150 lines
  agents/openai.yaml   display_name + short_description, for Codex/ChatGPT
```

`SKILL.md` frontmatter carries **`name` and `description` only**. The description does double duty:
it says what the skill does *and* carries the trigger phrasings ("Use when the manager says …"),
because that is what every harness matches against. Do not add non-standard frontmatter keys — a
`when-to-use` key is not portable across harnesses, so when-to-use lives in the body instead.

Body sections, in this order:

1. Title, one-paragraph purpose, the Oxygen behavior it serves, the P-rules it enforces.
2. `## When to use`
3. `## Non-negotiables` — the rules that make this skill correct, in imperative voice. This is the
   section a hurried agent actually obeys, so put the things that would cause harm here.
4. `## Method` — numbered steps, **tool-agnostic**. A tool rename must not touch this section.
5. `## Sources` — **capability-first, never backend-first.** Open with the capabilities from
   [source-map.md](./references/source-map.md) the skill needs, then one short block per backend
   that can supply them: with Topicflow, with Notion or an issue tracker, with neither. Close with
   what a missing capability changes — which is never "the skill stops" and never "the finding
   becomes negative". Exact tool names and parameters belong here; the Method above stays clean.
6. `## Gate` — for anything a routine can run. `worth_attention: yes/no` conditions plus named,
   tunable thresholds. Skills that only run in chat say "not applicable" and why.
7. `## Write-back` — what durable findings get saved (library convention 3).
8. `## Output` — the shape, then the action buttons.
9. `## Worked example` — one, at the end, showing real dialogue. The example is where most agents
   learn the voice, so make it concrete: real names, real dates, real numbers. Include what the
   skill *declined* to do and why — that teaches restraint better than a rule.

## House style

- Plain English, short sentences. The audience is a busy manager, often not technical.
- **No markdown tables in skill output.** Output has to survive Slack mrkdwn. Plain `- ` bullets.
  Tables are fine in reference docs and READMEs.
- Third person about people, always: "Tony prefers private recognition", never "you should know
  that he…".
- No em dashes as a tic, no "delve", no "leverage", no hedging clusters. Write like an experienced
  manager talking to a peer.
- Prefer a concrete example over an adjective. "Great job!" fails P8 is worth ten lines of theory
  about specificity.

## Adding a skill

1. Name the Oxygen behavior it serves (P17). If you cannot, do not add it.
2. Check the catalog. **One skill per job** — extend an existing skill instead of shipping a
   near-duplicate. The old in-app set had `/daily-brief` twice and three overlapping update
   skills; that is what this rule exists to prevent.
3. Write the Method before you look at a single tool name.
4. Add `evals/<skill>.md` with the five required cases: golden path, silence path, graceful-fail
   path, practice-conformance path, and portability path (it works without Topicflow).
5. Register it in three places: `.claude-plugin/plugin.json`, the category `README.md`, and the
   root `README.md`.
6. Run `scripts/check-skills.sh`.

## What the checker enforces

`scripts/check-skills.sh` is mechanical, not semantic. It checks: frontmatter present with `name`
and `description`; `name` matches the directory; description contains a "Use when" trigger; body
within the line budget; the required sections exist; no markdown tables in a SKILL.md; the Sources
section references `source-map.md`; `agents/openai.yaml` exists; the skill is registered in
`plugin.json`; `evals/<skill>.md` exists and contains a portability case.

The `source-map.md` reference is a proxy for backend neutrality — it proves the skill *pointed at*
the capability map, not that the non-Topicflow paths it describes are correct or complete. It
cannot check whether the Method is good management practice either. That is what review is for.

## Common mistakes

- **Inventing tools.** `save_private_note` and `read_ai_memory` do not exist yet — both are in dev
  in [TF-1595](https://linear.app/topicflow/issue/TF-1595). A skill may reference them as the
  intended path, but must always say what to do today. When TF-1595 lands, revisit the fallback
  ladders rather than deleting them: self-hosted and older deployments will still hit them.
- **Letting a missing source become a negative finding.** "No recognition found" and "recognition
  history unreadable" are different claims, and conflating them produces false alarms about real
  people.
- **Writing a gate that always fires.** If a routine skill pings every run, it gets muted, and then
  the one that mattered is missed too. Gates should be silent most of the time by design.
- **Taking work over.** Drafting a check-in *for* the report, posting progress on their goal,
  choosing their peer reviewers. Every one of these fails P15.
- **Status theater.** Any topic, line, or brief that tells the manager what happened without
  something to do about it fails P3.
- **Assuming Topicflow.** A Sources section that lists Topicflow tools and stops is half a skill.
  Most managers trying this library will not have Topicflow, and the first thing they will notice
  is whether it works anyway. Write the Notion and the nothing-at-all paths with the same care.
- **Silent thinness.** Producing a weaker answer on a weaker backend is fine. Producing it without
  saying so is not — the manager has no way to calibrate what they are reading.

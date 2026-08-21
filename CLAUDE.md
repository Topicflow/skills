# Working in this repo

This repo is a **library of agent skills for people managers and their direct reports**. It
contains no application code.
Everything here is Markdown that an agent will read at runtime, which changes what "quality" means:
a wrong sentence in a SKILL.md is a bug that ships to every manager using it.

## Read before editing

1. [references/library-conventions.md](./references/library-conventions.md) — the eight rules every
   skill follows.
2. [references/management-rules.md](./references/management-rules.md) — the P1-P17 rules
   skills cite.
3. [references/data-sources.md](./references/data-sources.md) — the eight kinds of data, the
   Topicflow call that serves each one, and **the claim a skill must stop making when that call
   fails or returns empty**. Skills name these calls directly: one hop, traceable.
4. [references/topicflow-tools.md](./references/topicflow-tools.md) — full parameters, the
   preview-then-confirm write pattern, the tools shipping in the 2026-08 MCP update, and the
   two still missing.
   **Never invent a tool or a parameter.** Where nothing serves a job, the job is unbound — a real
   answer, and the withheld conclusion applies as written.

**The library assumes Topicflow.** That is deliberate: it ships as a Topicflow plugin, and naming
the calls directly is what makes a skill readable. Another tool can serve any of the eight — the
practice does not change, only the call — but that is an extension, not the foundation. Keep tool
names out of `## Method` so swapping one touches one section.

## Anatomy of a skill

```
skills/<category>/<skill-name>/
  SKILL.md            frontmatter + body, under ~150 lines
  agents/openai.yaml   display_name + short_description, for Codex/ChatGPT
  <support>.md         optional, one: reference material the body links to (see prep-1on1/questions.md)
skills/later/          parked skills — written, not installed, skipped by the checker
```

`SKILL.md` frontmatter carries **`name`, `description`, and nothing else** — with one exception:
user-invoked skills add `disable-model-invocation: true`. That key decides the description style.
A *model-invoked* description does double duty: it says what the skill does *and* carries the
trigger phrasings ("Use when the user says …"), because that is what every harness matches
against. A *user-invoked* description is one human-facing line — the user types the name, so a
trigger list is noise — and its `agents/openai.yaml` sets `allow_implicit_invocation: false`.
Do not add any other frontmatter key — a `when-to-use` key is not portable across harnesses, so
when-to-use lives in the body instead.

**The user is not always the manager.** The core skills work from either chair — a manager
working on their team, or a direct report prepping their own 1-on-1, giving feedback upward,
posting their own goal check-ins. Say "the user" unless a step is genuinely chair-specific, and
mark the steps that are.

Body sections, in this order:

1. Title, one-paragraph purpose, the Oxygen behavior it serves, the P-rules it enforces.
2. `## When to use`
3. `## Non-negotiables` — the rules that make this skill correct, in imperative voice. This is the
   section a hurried agent actually obeys, so put the things that would cause harm here.
4. `## Method` — numbered steps, the management practice. **No tool names here** — the checker
   fails a Method that contains one.
5. `## Sources` — **the actual calls, named.** Which call the skill makes, what it needs back from
   it, and the **withheld conclusions**: the specific claims it must stop making when that call
   fails or returns empty. Never "the skill stops", never "the finding becomes negative". Parameter
   detail stays in [topicflow-tools.md](./references/topicflow-tools.md).
6. `## Gate` — for anything a routine can run. `worth_attention: yes/no` conditions plus named,
   tunable thresholds. Skills that only run in chat say "not applicable" and why.
7. `## Write-back` — what durable findings get saved (library convention 3).
8. `## Output` — the shape, then a portable choice prompt; see
   [interaction-controls.md](./references/interaction-controls.md).
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
   path, practice-conformance path, and missing-source path (one of the eight is unavailable).
5. Register it in three places: `.claude-plugin/plugin.json`, the category `README.md`, and the
   root `README.md`.
6. Run `scripts/check-skills.sh`.

## What the checker enforces

`scripts/check-skills.sh` is mechanical, not semantic. It checks: frontmatter present with `name`
and `description`; `name` matches the directory; a model-invoked description contains a "Use when"
trigger, while a user-invoked skill (`disable-model-invocation: true`) must set
`allow_implicit_invocation: false` in its openai.yaml; body within the line budget; the required
sections exist; no markdown tables in a SKILL.md; the Sources section references
`data-sources.md`; **no tool name appears inside `## Method`**; `agents/openai.yaml` exists; the
skill is registered in `plugin.json`; `evals/<skill>.md` exists and contains a missing-source
case. Skills in `skills/later/` are skipped entirely.

The Method tool-name check is a blacklist, so a tool nobody has added yet slips through. The
`data-sources.md` reference is a weaker proxy: it proves the skill *pointed at* the calls, not that
it named the right ones or reasoned correctly about what they withhold. Neither can check whether
the Method is good management practice. That is what review is for.

## Common mistakes

- **Inventing tools.** The 2026-08 MCP update ([TF-1595](https://linear.app/topicflow/issue/TF-1595))
  ships private-note read/create/delete and the recognition read — take exact tool names from the
  live tool list, never guess one. **There is no AI-memory access and none is planned: no skill or
  doc refers to it.** Keep the fallback ladders rather than deleting them: self-hosted and older
  deployments still hit them.
- **Letting a missing source become a negative finding.** "No recognition found" and "recognition
  history unreadable" are different claims, and conflating them produces false alarms about real
  people.
- **Writing a gate that always fires.** If a routine skill pings every run, it gets muted, and then
  the one that mattered is missed too. Gates should be silent most of the time by design.
- **Taking work over.** Drafting a check-in *for* the report, posting progress on their goal,
  choosing their peer reviewers. Every one of these fails P15.
- **Status theater.** Any topic, line, or brief that tells the manager what happened without
  something to do about it fails P3.
- **Naming a tool inside Method.** The practice has to read correctly whatever serves it. Calls go
  in Sources, one section, so swapping a source is one edit.
- **Assuming a job function.** "Ticket", "PR", and "review" are as hardcoded as a tool name — they
  assume an engineering team. Work is deals and stages for a sales manager, campaigns and briefs
  for a marketing one. Say "item" and let the data say what it is.
- **Assuming the manager's chair.** A direct report prepping their own 1-on-1 or posting their own
  goal check-in is a first-class user, not an edge case — for check-ins, the owner is the golden
  path (P15). Write "the user"; reserve "the manager" for steps that are genuinely theirs, like
  the recognition equity glance (P10).
- **Silent thinness.** Producing a weaker answer when a call came back empty is fine. Producing it
  without saying so is not — the manager has no way to calibrate what they are reading.

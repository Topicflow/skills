# Working in this repo

This repo is a **library of agent skills for people managers**. It contains no application code.
Everything here is Markdown that an agent will read at runtime, which changes what "quality" means:
a wrong sentence in a SKILL.md is a bug that ships to every manager using it.

## Read before editing

1. [references/library-conventions.md](./references/library-conventions.md) — the eight rules every
   skill follows.
2. [references/management-practices.md](./references/management-practices.md) — the P1-P17 rules
   skills cite.
3. [references/source-map.md](./references/source-map.md) — the eight capabilities, their
   contracts, and the binding record. **A SKILL.md must not contain a backend tool name.** Skills
   declare capabilities; the binding routes each one to a tool, independently. That is what lets a
   manager keep goals in one product and private notes in another, and lets a tool nobody here has
   heard of work at all.
4. [references/adapters.md](./references/adapters.md) — known backends, and the six-step recipe for
   binding one that is not listed. The recipe is the normal path, not a fallback.
5. [references/topicflow-tools.md](./references/topicflow-tools.md) — Topicflow's tool detail, as
   one adapter among others. **Never invent a tool or a parameter.** If nothing satisfies a
   contract, the binding is `none` — a real answer.

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
5. `## Sources` — **capabilities only, no tool names anywhere.** Which capabilities the skill
   needs, what each one buys it, and the **withheld conclusions**: the specific claims it must stop
   making when a capability is thin or absent. Never "the skill stops", never "the finding becomes
   negative". Tool names, parameters, and field mappings live in the binding record and in
   [adapters.md](./references/adapters.md) — the checker fails a SKILL.md that names one.
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
section references `source-map.md`; **no backend tool name appears in a SKILL.md**;
`agents/openai.yaml` exists; the skill is registered in `plugin.json`; `evals/<skill>.md` exists and
contains a portability case.

The tool-name check is the real guard on backend neutrality, and it is a blacklist — a tool from a
backend nobody has added yet will slip through. The `source-map.md` reference is a weaker proxy: it
proves the skill *pointed at* the contracts, not that its capability reasoning is right. Neither
can check whether the Method is good management practice. That is what review is for.

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
- **Naming a backend in a skill.** Even as a helpful example, even in a fallback. It hardcodes a
  routing decision that belongs in the binding, and it will be wrong for the next manager — who
  keeps goals in one tool, notes in another, and tickets in a third.
- **Enumerating backends instead of contracts.** "With Topicflow… with Notion… with neither" does
  not scale and cannot express a mixed setup. Say what the capability buys and what is withheld
  without it; the binding handles the rest.
- **Silent thinness.** Producing a weaker answer on a weaker backend is fine. Producing it without
  saying so is not — the manager has no way to calibrate what they are reading.

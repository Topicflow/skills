# Skills for managers and their direct reports

Agent skills for the human half of work: 1-on-1s, feedback, recognition, goals.

Management advice is abundant and almost never applied, because applying it means remembering the
right practice at the exact moment you are busy. These skills close that gap. Each one encodes a
specific practice from management research — SBI feedback, the report's agenda, measurable goals —
and produces something you can send in one click, written into **Topicflow** where it counts at
review time.

They work from **either chair**. A manager preps a 1-on-1 with a report; a report preps the same
meeting with their manager — and that second case is the practice at its best, because the meeting
belongs to the report. Feedback travels down, sideways, and up. A goal check-in is best posted by
the goal's own owner. The rules do not care about the org chart; only a few steps are
manager-specific, and the skills say which.

They run in any agent: Claude app, Claude Code, ChatGPT/Codex, or any MCP client. Each skill names
the Topicflow calls it makes — read a skill and you know exactly what it does, in one hop.

Eight kinds of data sit underneath: **people, meetings, meeting agenda, work, goals, feedback,
recognition, private notes.** Each one names the call that serves it and, more importantly, **the
claim a skill must stop making when that call comes back empty**. Where a deployment cannot serve
one — recognition and private notes only gained their tools in the 2026-08 MCP update — the
skills say so out loud rather than guessing. See
[references/data-sources.md](./references/data-sources.md).

## Quickstart

**Claude Code plugin** — the whole set as a managed bundle:

```
/plugin marketplace add Topicflow/skills
/plugin install manager-skills@topicflow
```

Or from your shell:

```bash
claude plugin marketplace add Topicflow/skills
claude plugin install manager-skills@topicflow
```

**Copy the skills into your own setup** — hack on them, make them yours:

```bash
npx skills@latest add Topicflow/skills
```

**ChatGPT / Codex and other Agent-Skills harnesses** — every skill ships an
`agents/openai.yaml`, so the same directories install unchanged. Nothing in this library is
model-specific.

**Then just talk.** There is no setup step: Topicflow is the only source, so there is nothing to
configure. Not sure what is here? Type `/ask-topicflow`.

Three things worth knowing before you start, so nothing is a surprise:

- **Recognition and private notes just gained their tools.** The 2026-08 Topicflow MCP update
  ([TF-1595](https://linear.app/topicflow/issue/TF-1595) /
  [TF-1596](https://linear.app/topicflow/issue/TF-1596)) ships the recognition read and
  private-note read, create, and delete. On a workspace that predates the update, the skills fall
  back honestly: nothing is ever claimed about recognition history, and "remember that about
  Tony" ends with the sentence handed to you to keep.
- **1-on-1 meeting notes are never used as a private store.** They are shared with the other
  person, whatever the deployment — a private observation does not belong there.
- **A bare agent still works.** `give-feedback`, `give-recognition`, and the drafting half of
  every other skill run from the conversation alone. The draft was always the valuable part.

## The catalog

### [Conversations](./skills/conversations) — the core workflow

- **[prep-1on1](./skills/conversations/prep-1on1/SKILL.md)** — 3-5 agenda topics from open action
  items, work signals, goal health, and recency gaps, written to the meeting. Works from either
  chair.
- **[give-feedback](./skills/conversations/give-feedback/SKILL.md)** — dated situation, observable
  behavior, concrete impact, an intent question when corrective. To a report, a peer, or your
  manager.
- **[give-recognition](./skills/conversations/give-recognition/SKILL.md)** — the specific
  contribution and what it made possible, matched to the person's public-or-private preference.
- **[create-goal](./skills/conversations/create-goal/SKILL.md)** — a goal with a measurable
  outcome. The owner drafts, the manager shapes; never a fourth goal stacked silently on three.
- **[goal-checkin](./skills/conversations/goal-checkin/SKILL.md)** — progress in the owner's
  voice: what moved, the numbers, whether the status still tells the truth. Never posted in
  someone else's name.
- **[direct-report-interview](./skills/conversations/direct-report-interview/SKILL.md)** —
  user-invoked (`/direct-report-interview`). A guided interview helps a manager understand one
  direct report, fill the important human gaps, and turn them into concrete support. A new report
  gets day-7/30/60 topics too.

### [Foundations](./skills/foundations) — what the others lean on

- **[save-private-note](./skills/foundations/save-private-note/SKILL.md)** — catch the durable
  fact the moment it is said ("she hates public praise") and restate it in one third-person
  sentence. Filing needs the 2026-08 MCP update
  ([TF-1595](https://linear.app/topicflow/issue/TF-1595)); on older workspaces it hands you the
  sentence.
- **[ask-topicflow](./skills/foundations/ask-topicflow/SKILL.md)** — user-invoked
  (`/ask-topicflow`). Ask a management question, review the current thread, choose the right
  focused skill, or check what the account can see.
- **[find-management-opportunities](./skills/foundations/find-management-opportunities/SKILL.md)**
  — user-invoked (`/find-management-opportunities`). A deliberate manager review of the named
  direct reports: the few next actions that would help them most.

### [Parked](./skills/later) — written, waiting on infrastructure

Seven more skills — team detectors (stuck work, relationship drift, recognition equity, a weekly
brief) and the review-cycle pair — live in [skills/later/](./skills/later), not installed. The
main thing they wait on is a scheduler for routine runs; the recognition read they also needed
ships in the 2026-08 MCP update.
[skills/later/README.md](./skills/later/README.md) says what unblocks each one;
the backlog lives in [TF-1599](https://linear.app/topicflow/issue/TF-1599).

## How to use them

Talk normally. The core skills are model-invoked — no slash commands to memorize:

> "prep my 1:1 with Tony tomorrow"
> "prep my 1:1 with my manager"
> "I need to give Priya feedback about the docs"
> "update my goal — the migration is at 60%"
> "set my goals for Q4"

Three skills are user-invoked because they should start only when the manager asks: ask a question
or review the current thread with `/ask-topicflow`; run a guided interview about one person with
`/direct-report-interview`; step back across named reports with
`/find-management-opportunities`.

When a skill needs a choice, Claude Code uses its native picker when it is available. Everywhere
else, the same choice is a numbered question you can answer in plain language — there is no second
slash command to memorize and no pretend text button to click.

## What makes these different

**They enforce the practice, not just mention it.** A feedback draft with no Impact is not shown
with a caveat; it is fixed first, or two questions get asked. A "great job!" recognition never
reaches you. An agenda made entirely of status topics is rewritten before you see it. The rules
are numbered P1-P17 in [references/management-rules.md](./references/management-rules.md), each
written as a pass/fail check.

**They are honest about what they cannot see.** A missing source produces "recognition history is
unreadable", never a silent zero. The difference matters: an unverifiable absence is not evidence,
and a skill that pretends otherwise will eventually tell you a well-supported colleague has been
neglected for six weeks. Every skill names what it could not see, in one line, in its own output.

**They keep ownership where it belongs.** A goal check-in is the owner's voice — a manager asking
to update a report's goal gets a 1-on-1 topic, not a ghost-written check-in. The report drafts
the goal; the manager shapes it. The person decides; the skill prepares.

**Focused actions end in Topicflow.** Topics land on the real meeting, feedback and recognition
are sent through the record, check-ins carry real numbers. The two advisory entry points choose
the next action; they never write on their own. What you do today is what the review can cite in
six months.

## The seventeen rules

This is the actual content of the library. Every skill cites the rules it enforces, checks its
own draft against them before you see it, and every eval asserts conformance. Each rule is
written so an output either passes or fails. Full text, with the research behind each one:
[references/management-rules.md](./references/management-rules.md).

**1-on-1 meetings** — *Rogelberg,* Glad We Met*; GitLab handbook*

- **P1** The 1-on-1 belongs to the report. At least half the agenda is their topics, as open questions.
- **P2** Weekly and short beats monthly and long. Never cancel — reschedule.
- **P3** Status does not belong in the 1-on-1. Prefer blockers, growth, and the relationship.
- **P4** Close the loop. Every 1-on-1 ends with action items and owners; the next prep starts there.

**Feedback** — *Center for Creative Leadership (SBI/SBII); Kim Scott,* Radical Candor

- **P5** SBI shape is mandatory: dated Situation, observable Behavior, concrete Impact. Corrective feedback adds an intent question before judging.
- **P6** Timely. Under about two weeks old, or it becomes a pattern conversation instead.
- **P7** Care personally, challenge directly. Never soften into vagueness, never criticize the person. Corrective feedback is private-first.

**Recognition** — *Gallup / Workhuman*

- **P8** Specific and timely. Name the exact contribution and why it mattered. "Great job!" fails.
- **P9** Personalized. Respect their public-or-private preference; ask once, then remember.
- **P10** Equitable. Check distribution across everyone. A four-week drought is an equity problem, not a nudge.

**Goals** — *Locke & Latham; Grove,* High Output Management

- **P11** Specific and challenging, with a measurable outcome. The report drafts; the manager shapes.
- **P12** Few and alive. About three active goals per person; no check-in in six weeks is stale by definition.

**Career** — *Russ Laraway, Career Conversations*

- **P13** Career is a separate conversation from performance. Life story, then dreams, then a plan.
- **P14** The plan has owners and dates, and at least one action item belongs to the *manager*.

**Coaching and delegation** — *Project Oxygen; Michael Bungay Stanier,* The Coaching Habit

- **P15** Questions before advice. Check-ins on stuck work offer help; they never take over.
- **P16** Match delegation to what they are new to. New → structure. Proven → outcomes only.

**North star** — *Google Project Oxygen*

- **P17** Every skill serves one of the ten Oxygen behaviors. If you cannot name it, the skill does not go in.

## Where the practice comes from

Every rule is traceable. Google's Project Oxygen for what managers are for; Rogelberg's *Glad We
Met* for 1-on-1s; the Center for Creative Leadership's SBI/SBII for feedback; Kim Scott's *Radical
Candor* for how to say it; Gallup and Workhuman for recognition; Locke & Latham and Grove for
goals; Russ Laraway for career conversations; Michael Bungay Stanier for coaching questions. Full
list with URLs: [references/management-rules.md](./references/management-rules.md).

The test for adding a skill is P17: name the Oxygen behavior it serves. If you cannot, it does
not go in.

## Repo layout

```
references/
  management-rules.md       the seventeen rules, with sources
  library-conventions.md    the rules every skill follows
  data-sources.md           the eight kinds of data, the call for each, what it withholds
  topicflow-tools.md        full parameters, the write pattern, and the missing tools
skills/
  conversations/  foundations/     the nine installed skills
  later/                           parked skills, not installed
evals/                      5 cases per skill; evals/later/ mirrors skills/later/
.out-of-scope/              designs we considered and rejected, with reasons
scripts/
  check-skills.sh           conformance check — run before committing
  link-skills.sh            dev-only: symlink skills into your local agent
```

## Contributing

Read [references/library-conventions.md](./references/library-conventions.md) first — a skill
that breaks one of its rules is a bug rather than a variation. Then [CLAUDE.md](./CLAUDE.md) for
how to add a skill and what the checker enforces. Ideas already considered and declined are in
[.out-of-scope/](./.out-of-scope); deferred ones live in
[TF-1599](https://linear.app/topicflow/issue/TF-1599).

## Status

Version 0.2.0 — nine installed skills: five core workflows that work from either chair, a guided
direct-report interview, durable private context, and two manager-facing entry points. The focused
workflows own their Topicflow writes; the entry points choose what deserves attention. Seven further
skills are parked in [skills/later/](./skills/later) until the infrastructure they need exists.

The 2026-08 MCP update ([TF-1595](https://linear.app/topicflow/issue/TF-1595)) ships the
dependencies that mattered most: private-note read, create, and delete, plus the recognition
read. The skills keep their fallbacks for deployments that predate it. Full list, with the
fallback each one uses: [references/topicflow-tools.md](./references/topicflow-tools.md).

MIT licensed. Use them, fork them, make them yours.

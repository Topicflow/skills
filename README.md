# Skills For People Managers

Agent skills for the human half of the job: 1-on-1s, feedback, recognition, goals, careers,
reviews.

Management advice is abundant and almost never applied, because applying it means remembering the
right practice at the exact moment you are busy. These skills close that gap. Each one encodes a
specific practice from management research — SBI feedback, the report's agenda, recognition equity,
goal staleness — and produces a draft you can send in one click.

They run in any agent: Claude app, Claude Code, ChatGPT/Codex, or any MCP client. And they run on
whatever you already use, **one kind of data at a time**: goals in Notion, private notes in Todoist,
tickets in Linear, 1-on-1s in a calendar, and nothing at all for recognition is an ordinary setup
here, not a compromise.

No skill in this library names a tool. Each declares the *capabilities* it needs — roster, 1-on-1
history, work signals, goals, feedback record, notes, delivery, agendas — and
[`setup-sources`](./skills/foundations/setup-sources/SKILL.md) binds each one to whichever tool you
keep it in. Moving something later changes one row, not fourteen skills. A tool nobody here has
heard of works too: there is a [recipe](./references/adapters.md) for binding one.

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
model-specific: no Claude-only syntax, no GPT-only prompt tricks.

**Then run `/setup-sources` once.** It tests what is actually reachable, asks who reports to you and
where each kind of data lives, and records a binding per capability. After that, tell it things like
"put goals in Notion" or "keep private notes in Todoist" and it rebinds one row.

Some things worth knowing before you bind:

- **Topicflow** is the fullest single source, and the only one that holds a feedback and recognition
  record — which is exactly what the equity and drought checks measure.
- **An issue tracker** is the best source for stalled work, whatever else you use. Staleness needs
  real state history; a last-edited timestamp is not a substitute, and the skills refuse to treat it
  as one.
- **A note store** — a Notion page, a Todoist project, a text file — covers durable notes well. That
  is currently *better* than the Topicflow path, which is still waiting on
  [TF-1595](https://linear.app/topicflow/issue/TF-1595).
- **A recognition record has no common equivalent.** Most setups cannot hold one, and without it
  `recognition-scan` stays silent rather than inventing a drought. `setup-sources` offers to create
  a simple log; it works from the day you start it.
- **Nothing at all** is a valid setup. `give-feedback`, `give-recognition`, `management-practices`,
  and the drafting half of `prep-1on1` work from the conversation alone. The draft was always the
  valuable part.

> **If you copy a single skill directory** rather than installing the whole set, its links into
> `references/` will not resolve. Each skill restates the rules it depends on inline, so it still
> behaves correctly on its own — but take `references/` with you if you want the full practice text.

## How to use them

Talk normally. Every skill is model-invoked, so you do not memorize slash commands:

> "prep my 1:1 with Tony tomorrow"
> "I need to give Priya feedback about the docs"
> "who on my team hasn't had recognition lately?"
> "Q3 reviews are open, get me started on Tony"

Or type the name directly (`/prep-1on1`) if you prefer.

## What makes these different

**They refuse to be a digest.** Most management tooling reports that the week happened. Five of
these skills run on a schedule and are built to stay silent: each ends in a gate —
`worth_attention: yes/no` — and "you have a 1-on-1 tomorrow" never qualifies as a finding. There is
exactly one digest in the library, it is opt-in, and it sends nothing when nothing is actionable.

**They enforce the practice, not just mention it.** A feedback draft with no Impact is not shown
with a caveat; it is fixed first, or two questions get asked. A "great job!" recognition never
reaches you. An agenda made entirely of status topics is rewritten before you see it. The rules are
numbered P1-P17 in [references/management-practices.md](./references/management-practices.md), each
one written as a pass/fail check.

**They are honest about what they cannot see.** A missing source produces "recognition history is
unreadable", never a silent zero. The difference matters: an unverifiable absence is not evidence,
and a skill that pretends otherwise will eventually tell you a well-supported colleague has been
neglected for six weeks. Every skill names the capability it was missing, in one line, in its own
output — you never have to guess how much it could actually see.

**They keep ownership where it belongs.** Goal check-ins are not posted on someone's behalf. Stuck
work asks what is in the way rather than demanding a status. Peer-review writers are proposed, never
chosen for you. The manager decides; the skill prepares.

**Two callers, one catalog.** Every skill has one Method that a manager can run in a chat and the
Topicflow engine can run on a schedule. They differ only in the gate.

## The catalog

### [Foundations](./skills/foundations) — install first

- **[setup-sources](./skills/foundations/setup-sources/SKILL.md)** — bind each kind of data to
  whichever tool you keep it in, then say plainly what works, what works with less, and what does
  not work at all. Also how you move one thing to a new tool later.
- **[management-practices](./skills/foundations/management-practices/SKILL.md)** — the seventeen
  rules as pass/fail checks. Every other skill runs them on its own drafts.
- **[save-context](./skills/foundations/save-context/SKILL.md)** — catch the durable fact the moment
  it is said ("she hates public praise", "he's never run a migration"), restate it in one
  third-person sentence, file it.

### [Conversations](./skills/conversations) — things you say or send

- **[prep-1on1](./skills/conversations/prep-1on1/SKILL.md)** — 3-5 topics from open action items,
  work signals, goal health, and recency gaps. Half of them the report's, as open questions. No
  status.
- **[give-feedback](./skills/conversations/give-feedback/SKILL.md)** — dated situation, observable
  behavior, concrete impact, and an intent question when it is corrective. Anything over two weeks
  old becomes a conversation instead.
- **[request-feedback](./skills/conversations/request-feedback/SKILL.md)** — the right 3-5 writers,
  including one who will see something the others miss, asked questions that produce situations
  rather than ratings.
- **[give-recognition](./skills/conversations/give-recognition/SKILL.md)** — the specific
  contribution and what it made possible, matched to their public-or-private preference, with a
  one-line equity check.
- **[onboard-direct-report](./skills/conversations/onboard-direct-report/SKILL.md)** — baseline what
  they are new to, a first 1-on-1 about the person rather than the work, and day-7/30/60 topics
  already dated.
- **[review-prep](./skills/conversations/review-prep/SKILL.md)** — a dated evidence pack per report
  with an explicit gaps section, plus the most useful sentence in any review prep: which report's
  evidence is thin because of where your attention went.

### [Signals](./skills/signals) — detectors that mostly stay quiet

- **[recognition-scan](./skills/signals/recognition-scan/SKILL.md)** — weekly. A real win plus a
  4-week drought, or silence.
- **[relationship-drift](./skills/signals/relationship-drift/SKILL.md)** — weekly. Dates only:
  weeks since the last 1-on-1, consecutive cancellations, weeks since career came up.
- **[stuck-work](./skills/signals/stuck-work/SKILL.md)** — daily. Who needs help, never who is
  slow. Checks whether you are the blocker first.
- **[goal-checkin](./skills/signals/goal-checkin/SKILL.md)** — monthly. Stale, off track,
  unmeasurable, or too many.
- **[weekly-brief](./skills/signals/weekly-brief/SKILL.md)** — Monday, opt-in. One line per report,
  every line ending in an action, nothing sent when nothing is actionable.

## Where the practice comes from

Every rule is traceable. Google's Project Oxygen for what managers are for; Rogelberg's *Glad We
Met* for 1-on-1s; the Center for Creative Leadership's SBI/SBII for feedback; Kim Scott's *Radical
Candor* for how to say it; Gallup and Workhuman for recognition; Locke & Latham and Grove for goals;
Russ Laraway for career conversations; Michael Bungay Stanier for coaching questions. Full list with
URLs: [references/management-practices.md](./references/management-practices.md).

The test for adding a skill is P17: name the Oxygen behavior it serves. If you cannot, it does not
go in.

## Repo layout

```
references/
  management-practices.md   the seventeen rules, with sources
  library-conventions.md    the eight rules every skill follows
  source-map.md             the eight capabilities, their contracts, the binding record
  adapters.md               known backends, and the recipe for binding an unknown one
  topicflow-tools.md        Topicflow's detail, as one adapter among others
skills/
  foundations/  conversations/  signals/
evals/                      4 cases per skill: golden, silence, graceful-fail, conformance
scripts/
  check-skills.sh           conformance check — run before committing
  link-skills.sh            dev-only: symlink skills into your local agent
```

## Contributing

Read [references/library-conventions.md](./references/library-conventions.md) first — eight rules,
and a skill that breaks one is a bug rather than a variation. Then
[CLAUDE.md](./CLAUDE.md) for how to add a skill and what the checker enforces.

## Status

Version 0.1.0. The library is complete as method; four Topicflow tools it wants do not exist yet,
and every skill degrades explicitly without them.

The two that matter most — `save_private_note` and AI-memory access — are in dev in
[TF-1595](https://linear.app/topicflow/issue/TF-1595). Until that ships, "remember this about
Tony" ends with the agent handing you the sentence to keep rather than filing it, and the
per-person ping cooldowns in the signal skills cannot be enforced across runs, so those skills
deliberately stay quieter than their thresholds allow. Full list, with the fallback each skill
uses today: [references/topicflow-tools.md](./references/topicflow-tools.md).

MIT licensed. Use them, fork them, make them yours.

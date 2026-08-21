# Library conventions

Eight rules. They apply to every skill in this library, without exception.
A skill that breaks one is a bug, not a variation.

## Two callers, two chairs, one catalog

Every skill has exactly one Method, and two callers can run it:

- **Chat mode** — someone talks to an agent (Claude app, Claude Code, ChatGPT/Codex, any MCP client). The user is present and can answer questions.
- **Routine mode** — the Topicflow engine runs the skill on a schedule. Nobody is present. The skill must decide on its own whether the user is worth interrupting.

Write the Method once, tool-agnostic. Chat mode and routine mode differ only in the
Gate section and in whether questions may be asked.

The user sits in one of **two chairs**: a manager working on their team, or a direct report
working on their own 1-on-1s, feedback, recognition, and goals. The core skills serve both. A
skill resolves the chair from what the user says and what the data shows (whose meeting, whose
goal), asks once when it is ambiguous, and says in its body which steps are chair-specific —
the equity glance is the manager's alone; posting a goal check-in is the owner's.

And two **invocation types**: most skills are *model-invoked* — the agent picks them up from
normal conversation, so their descriptions carry trigger phrasings. A few are *user-invoked*
(`disable-model-invocation: true` in frontmatter, `allow_implicit_invocation: false` in
`agents/openai.yaml`): the user types the name, so their descriptions are one human-facing
line with no trigger list. User-invoked is for skills that would be an interruption if they
started themselves — an interview, a guided tour.

## The eight rules

**1. Format.** One directory per skill. Kebab-case name. `SKILL.md` with frontmatter: `name`,
`description`, and — only for user-invoked skills — `disable-model-invocation: true`. A
model-invoked description carries the "Use when …" triggers; a user-invoked description is one
human-facing line. Body around 150 lines, hard ceiling 165 — prose here is wrapped at 95
columns, which costs about twice the lines of unwrapped text, so the checker warns at 150 and
fails at 165. One worked example at the end. `agents/openai.yaml` for Codex / ChatGPT harnesses.
A skill may add one support file next to `SKILL.md` (like prep-1on1's `questions.md`) when the
body budget cannot hold reference material — linked from the body, loaded on demand.

**2. Two-part body: the practice, then the calls.** *Method* first — the management practice,
written so it reads correctly whatever tool serves it. *Sources* second — **the actual Topicflow
calls the skill makes**, named directly, plus the conclusions it withholds when a call fails or
returns empty. One hop, traceable: you read the skill and you know what it does.

The eight kinds of data, each with its call and its withheld conclusions:
[data-sources.md](data-sources.md). Full parameters and gotchas:
[topicflow-tools.md](topicflow-tools.md).

**The Method must not depend on a tool name.** A different tool can serve any of the eight; the
practice does not change, only the call. Keep tool names in Sources so swapping one touches one
section.

**3. Write-back to private notes.** Anything durable learned during a run — from the manager's
words or from a tool — gets kept. This holds even when the run ends in silence: a finding
nobody was pinged about is still worth keeping for review time. The private-note tools ship in the
2026-08 MCP update ([TF-1595](https://linear.app/topicflow/issue/TF-1595)); where a deployment
predates it, that means producing the note text and saying plainly it was not filed. **Meeting notes are not a fallback** — they are
shared with the report. See the `save-private-note` skill.

**4. Confirm once.** Every Topicflow write tool is a two-step: the write tool returns a
*preview* plus a `pending_id`, and `confirm_creation(pending_id)` commits it. Show the
preview, get one approval, call `confirm_creation`. Never ask for the same approval twice
— the manager saying "yes, send it" is the approval.

**5. Voice.** Observations about people in the third person ("Tony prefers private
recognition"), never second person, never speculation dressed as fact. Output plain
text, short sentences. No markdown tables — output has to survive Slack mrkdwn. Plain
`- ` bullets are fine.

**6. Gate.** Any skill a routine can run ends with a gate: `worth_attention: yes/no`
plus a one-line reason. `no` means write the findings back (rule 3) and stop silently —
no "nothing to report" message. Gate thresholds live in the skill body as named,
tunable defaults, so a manager can change 4 weeks to 6 without editing logic.

**7. Output contract.** finding → why it matters → proposed action(s). A skill never ends
with raw data, and never ends without an action the manager can take in one click or one
sentence. When it needs a choice, use the [portable choice controls](interaction-controls.md):
call the host's structured prompt when it exists; otherwise use a numbered, replyable question.
Never present bracketed text as a button or tell the manager to type another command. A “yes”
starts a selected skill on the next turn; its own preview and approval rules still apply.

**8. Practice conformance.** Every skill operationalizes numbered rules from
[management-rules.md](management-rules.md) and names them. Before showing a
draft, the skill checks it against those rules and fixes it — a feedback draft with no
Impact, an agenda made only of status topics, or a "great job!" recognition never reaches
the manager.

## What a skill never does

- Never sends anything to a person without an explicit approval in the same conversation.
- Never invents a fact about a person. If the data is missing, say it is missing.
- Never pings in routine mode just because a date arrived. "You have a 1-on-1 tomorrow"
  is not a finding.
- Never writes a performance judgement to a shared surface. Judgements go to the
  manager's own notes; shared surfaces get behaviour and impact.
- Never asks more than 3 questions before producing a draft. A rough draft the manager
  edits beats an interrogation.
- Never names a tool inside its Method. Tool names live in Sources, so the practice reads
  correctly whatever serves it and swapping one touches one section.
- Never invents a tool or a parameter. Where nothing serves a job, the job is unbound, and
  the withheld conclusion applies exactly as written.

## Degrading gracefully

Calls fail, return empty, or are missing entirely more often than you would like — recognition
and private notes only gained their tools in the 2026-08 MCP update, and older deployments lack
them. When that happens: continue with what is available, **say what
was missing in one line**, and lower the confidence of the affected finding — never fail the whole
run, never silently pretend the gap is a negative result ("no recognition found" is different from
"recognition history unreadable"). The manager should never have to guess how much the skill could
actually see.

The eight kinds of data, each with its call and the conclusions it withholds:
[data-sources.md](data-sources.md). Full parameters and gaps:
[topicflow-tools.md](topicflow-tools.md).

A detector without its detecting source has nothing to run on and should say so once and stay
quiet rather than narrow — which is one reason the detectors live in `skills/later/` until the
sources and the scheduler they need exist.

## Adding a skill

1. Name the Oxygen behaviour it serves (P17). If you cannot, do not add it.
2. Check the catalog for an existing skill with the same job — including `skills/later/`. One
   skill per job — extend or reactivate instead of adding a near-duplicate.
3. Decide the invocation type: model-invoked with triggers, or user-invoked
   (`disable-model-invocation: true`) when the skill starting itself would be an interruption.
4. Write the Method before touching any tool names. Say which steps are chair-specific.
5. Write Sources: the calls it makes, from [data-sources.md](data-sources.md), and the
   conclusion it withholds when each one fails or returns empty.
6. Add 5 eval cases in `evals/<skill>.md`: golden path, silence path, graceful-fail path,
   practice-conformance path, and a **missing-source path** — one of the eight is unavailable,
   and the skill narrows honestly instead of guessing.
7. Register it in `.claude-plugin/plugin.json`, the category README, and the root README.
8. Run `scripts/check-skills.sh`.

---
name: save-context
description: Capture a durable fact about a person, decision, or preference into Topicflow the moment the manager says it. Use whenever the manager mentions something worth remembering about a report — a preference, an aspiration, a strength, something they are new to, a commitment made — even in the middle of another task.
---

# Save context

The memory habit. Managers say the most useful things in passing: "she hates being praised
in public", "he's never run a migration before", "he wants to move toward platform work".
Those facts decide how the next recognition, the next delegation, and the next career
conversation should go — and they evaporate unless someone writes them down.

This skill runs *alongside* other work. It does not take over the conversation.

Serves the Oxygen behaviors *cares about success and well-being* and *empowers without
micromanaging* (P17). Enforces P9 (preferences are memory-worthy) and P16 (so is
task-relevant maturity). Rules: [management-practices.md](../../../references/management-practices.md).

## When to use

- The manager states a durable fact about a report, in any conversation.
- The manager makes or reports a commitment ("I told him I'd get him on the architecture
  review").
- Another skill learns something durable during its run — every skill in this library
  hands its findings here (library convention 3).
- The manager says "remember that" or "note that down".

## Non-negotiables

- One fact, one sentence, third person, dated.
- Never save without being sure it is durable. Durable means still true and still useful in
  three months.
- Never save health, family, or protected-class information unless the manager explicitly
  asks you to — and even then, save only what the report would expect to be on file.
- Never save a performance verdict ("he's a B player"), gossip, or a third party's claim
  about someone. Behaviour and preferences, not labels.
- Never interrupt the current task to do this. Save, give a one-line receipt, carry on.

## Method

**1. Detect.** Listen for five kinds of fact:

- *Preference* — how they want recognition, feedback, or communication handled (P9).
- *Task-relevant maturity* — what they have done many times, what they are new to (P16).
- *Role and scope* — what they own, what changed about their remit.
- *Aspiration* — where they want to go, what they want to learn (P13).
- *Commitment* — something the manager or report agreed to do, with a date.

Everything else is conversation, not memory. Status, opinions in the moment, and anything
already visible in Topicflow are not saved.

**2. Restate.** One sentence, third person, with the date and the source of the claim:

> Tony prefers recognition privately rather than in a channel (stated by his manager,
> 2026-08-17).

Not "Tony doesn't like public praise, he seems uncomfortable with it" — that is two claims
and one guess.

**3. Check it is new.** Compare against what is already known before saving. Nothing durable
should be saved twice, and a fact that *contradicts* a known one is the interesting case:
save the new one and note that it supersedes, do not silently overwrite.

**4. Save.** Write it to the person's file in Topicflow.

**5. Receipt.** One line: "Saved to Tony's file: prefers private recognition." Then return to
whatever the manager was doing.

## Sources

**Needs** C6 durable notes, read and write. That is the whole skill. `setup-sources` records where
notes go; this skill does not re-decide it per run. Backend mapping:
[source-map.md](../../../references/source-map.md).

**With Notion** — the best destination today. Keep one page per report under a People page.
`notion-create-pages` to start it, then
`notion-update-page(page_id, command: "insert_content", position: {type: "end"})` to append the
dated sentence. Read it back with `notion-fetch(id)` to dedupe. Private as long as the page is —
check that once, not every time.

**With Topicflow.** `save_private_note(person, text)` and `read_ai_memory` are **in dev**
([TF-1595](https://linear.app/topicflow/issue/TF-1595)). Until they land: show the note text and
ask the manager to keep it. Only if the manager confirms individual 1-on-1 notes are private to
them, `edit_meeting_topic_notes(meeting_id, topic_id, text, operation: "append", notes_type:
"individual")` on a standing "Context" topic — **ask first**, because shared notes are visible to
the report.

**With neither.** Produce the sentence and say plainly it was not filed. A fact the manager pastes
somewhere is still a fact kept; a fact silently dropped is not.

**Never write a manager-private observation to a surface the report can read** — a shared meeting
note, a team page, a channel. Dropping the note is better on every backend.

**Dedup** against whatever can be read: the person's page, recent 1-on-1 notes, the current
conversation. Where nothing is readable, ask in half a sentence rather than duplicating — and
never report "not already known" as a fact.

## Gate

Not applicable — this skill is never run by a routine. It fires on what the manager says.

## Output

A one-line receipt naming the person and the fact. Nothing else. If the fact was not saved
because a tool was missing, the receipt says so and includes the text to keep:

> Couldn't write to Tony's file (note saving isn't available yet). Keep this one:
> "Tony prefers recognition privately rather than in a channel."

## Worked example

Mid-conversation, while drafting an agenda:

> **Manager:** yeah don't put the migration on there, he's never done one before so I want
> to pair with him on it first
>
> **Agent:** Noted — I'll leave it off the agenda.
> Saved to Tony's file: new to database migrations; his manager is pairing with him on the
> first one (2026-08-17).

Two facts, one sentence, third person, dated. The maturity observation (P16) is what makes
the next delegation decision better — and in six weeks, when Tony has run three migrations,
the *next* save supersedes this one.

The agenda work continues immediately. The receipt is two lines, not a detour.

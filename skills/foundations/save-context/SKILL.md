---
name: save-context
description: Capture a durable fact about a person, decision, or preference in the manager's configured notes source the moment they say it. Use whenever the manager mentions something worth remembering about a report — a preference, an aspiration, a strength, something they are new to, a commitment made — even in the middle of another task.
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
already visible in the bound notes source are not saved.

**2. Restate.** One sentence, third person, with the date and the source of the claim:

> Tony prefers recognition privately rather than in a channel (stated by his manager,
> 2026-08-17).

Not "Tony doesn't like public praise, he seems uncomfortable with it" — that is two claims
and one guess.

**3. Check it is new.** Compare against what is already known before saving. Nothing durable
should be saved twice, and a fact that *contradicts* a known one is the interesting case:
save the new one and note that it supersedes, do not silently overwrite.

**4. Save.** Execute the C6 binding's append call for the person's configured notes destination.

**5. Receipt.** One line: "Saved to Tony's file: prefers private recognition." Then return to
whatever the manager was doing.

## Sources

**Needs** C6 durable notes, read and append. That is the whole skill. **This skill never names a
backend** — it executes the C6 binding, whatever it points at: a note tool, a task manager, a page
per person, a plain file. Contract: [source-map.md](../../../references/source-map.md). Adapters,
and how to bind one nobody has seen: [adapters.md](../../../references/adapters.md).

**The binding is not re-decided per run.** `setup-sources` recorded the destination, the append
call, the read call, and whether the place is private. Use them. Asking the manager where notes go
every time they say something worth keeping is how a memory habit dies.

**Withheld when the binding is thin.** Append but no read → dedup is impossible, so ask in half a
sentence rather than duplicating, and **never report a fact as new**. No append → produce the
sentence and say plainly it was not filed; a fact the manager pastes somewhere is still kept, a
fact silently dropped is not.

**Privacy is part of the contract, and it is checked once at bind time, not guessed here.** Where
the C6 destination is not confirmed private to the manager, maturity observations and preferences
do not go there. **Never write a manager-private observation to a surface the report can read** —
a shared page, a shared meeting note, a channel. Dropping the note is better under every binding.

**The receipt names where it went**, because on a rebound C6 the manager may not remember. "Saved
to Tony's page" and "couldn't file this, keep it somewhere" are both complete receipts; silence is
not.

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

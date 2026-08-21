---
name: save-private-note
description: Save a private note about a person the moment something durable is said — a preference, an aspiration, a strength, something they are new to, a commitment made. Use whenever the user mentions something worth remembering about a report or colleague, says "remember that" or "note that down", even in the middle of another task.
---

# Save a private note

The memory habit. Managers say the most useful things in passing: "she hates being praised
in public", "he's never run a migration before", "he wants to move toward platform work".
Those facts decide how the next recognition, the next delegation, and the next career
conversation should go — and they evaporate unless someone writes them down.

This skill runs *alongside* other work. It does not take over the conversation.

Serves the Oxygen behaviors *cares about success and well-being* and *empowers without
micromanaging* (P17). Enforces P9 (preferences are memory-worthy) and P16 (so is
task-relevant maturity). Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- The manager states a durable fact about a report, in any conversation.
- The manager makes or reports a commitment ("I told him I'd get him on the architecture
  review").
- Another skill learns something durable during its run — every skill in this library
  hands its findings here (library convention 3).
- The manager says "remember that" or "note that down".

## Non-negotiables

- **Topicflow first.** If no Topicflow MCP tool is exposed, stop and use [the connection prompt](../../../references/topicflow-tools.md).
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

**4. File it.** Save it with the note write. Where the write is absent (see Sources), give the
manager the sentence to keep and say plainly that it was not filed.

**5. Receipt.** One line, and it says which of the two happened: "Saved to Tony's file: prefers
private recognition" — or, where filing is impossible, "keep this one, I can't file it here."
Then return to whatever the manager was doing.

## Sources

**Private notes — read, create, and delete ship in the 2026-08 MCP update**
([TF-1595](https://linear.app/topicflow/issue/TF-1595)). The write is `save_private_note`; take
the read and delete names from the live tool list — never guess a name. There is no AI-memory
layer: what the notes hold is all this skill knows. Withheld conclusions:
[data-sources.md](../../../references/data-sources.md). Connection and write details:
[topicflow-tools.md](../../../references/topicflow-tools.md).

**Where the update has not reached the deployment, there is only one option.** Produce the
sentence in third person and hand it to the manager to keep. Do not look for somewhere else to
put it.

**1-on-1 meeting notes are not a fallback.** They are shared with the other participant, so
`edit_meeting_topic_notes` writes where the report can read. A maturity observation or a preference
does not go there under any circumstances — not in a "Context" topic, not anywhere on the meeting.
**Handing the note back is the correct outcome; writing it somewhere shared is a harm.**

**Withheld.** No read → dedup is impossible, so ask in half a sentence rather than duplicating, and
**never report a fact as new**. No write → say plainly it was not filed; a fact the manager keeps is
still kept, a fact silently dropped is not.

**The receipt says which happened.** "Keep this for Tony — I can't file it yet" is a complete
receipt. Silence is not, and "saved" when nothing was saved is worse than either.

**With the update live**, the write-back convention works across the whole library — every
skill's write-back ends here, in one call. The read makes dedup and supersede real: check before
saving, and never silently delete what a new fact contradicts.

## Gate

Not applicable — this skill is never run by a routine. It fires on what the manager says.

## Output

A one-line receipt naming the person and the fact. If the fact was not saved because a tool was
missing, the receipt says so and includes the text to keep:

Then end interactively through the
[portable choice controls](../../../references/interaction-controls.md) when this is a standalone
interaction: offer to save another fact or review the saved fact. When it runs inside another
skill, return the receipt to that parent; the parent ends with the interactive choice. In Claude
Code, that means `AskUserQuestion`, not a printed list.

> Couldn't write to Tony's file (note saving hasn't reached this workspace). Keep this one:
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

---
name: prep-1on1
description: Draft a 1-on-1 agenda from open action items, recent work signals, goal health, and relationship gaps — then write the topics to the meeting. Use when the manager says "prep my 1:1 with X", "what should I talk about with X", "anything I'm missing before my 1:1", or when a routine runs 24h before a scheduled 1-on-1.
---

# Prep a 1-on-1

A good 1-on-1 agenda is 3-5 topics, at least half of them the report's, none of them status.
This skill assembles one from what already happened, so the manager walks in prepared instead
of opening with "so, what's new?"

Serves *is a good coach* and *communicates well* (P17). Enforces P1 P2 P3 P4.
Rules: [management-practices.md](../../../references/management-practices.md).

## When to use

- The manager asks to prep, or asks what to cover with someone.
- Routine mode: 24 hours before each formal 1-on-1.
- Another skill wants a finding discussed rather than sent — this is where it lands.

## Non-negotiables

- **At least half the topics belong to the report**, phrased as open questions (P1).
- **No status topics** (P3). "Update on the billing work" is a status topic. "What's making
  the billing work harder than you expected?" is not.
- Start from last meeting's unfinished action items (P4). Those come first, always.
- Every topic carries a one-line *why* so the manager knows what it is for.
- 3-5 topics. A 9-topic agenda is a list, not a conversation.
- Confirm once before writing to the meeting.

## Method

**1. Resolve the person and both meetings.** Get the report's ID. Find the **last** 1-on-1
with them (with notes) and the **next** one (for its `meeting_id`). If no next meeting
exists, the agenda still gets drafted — the write step just becomes "schedule it and I'll add
these".

**2. Read the last meeting for open loops (P4).** From the previous one or two meetings'
topics and notes, pull anything unfinished: an action item with no outcome, a topic that was
deferred, a question the manager promised to answer. Each of these is a candidate topic, and
they outrank everything else.

**3. Gather what changed since that meeting.** Four things, none of them status:

- *Work signals* — what happened in their connected tools since the last 1-on-1. Look for
  friction and change, not volume: a PR that sat, a reverted change, an incident, a piece of
  work that crossed into someone else's area.
- *Goal health* — goals at risk or off track, goals with no recent check-in, more than three
  active goals (P12).
- *Feedback and recognition recency* — how long since either. A 4-week recognition drought is
  a topic (P10).
- *Career recency* — how long since career came up at all. Past ~8 weeks, that is a topic in
  its own right (P13).

**4. Draft 3-5 topics.** Compose in this order: unfinished action items → the one thing that
most needs a decision or unblocking → topics for the report → a growth or relationship topic
if either recency check fired.

Then rewrite for P1: at least half must be genuinely *for* the report, as open questions.
Convert. "Q3 planning" becomes "What would you want to own in Q3 planning?" If the whole
agenda reads as the manager's checklist, the prep failed even if every item is real.

Drop anything the report already knows and the manager already knows. That is status.

**5. Check the draft.** Half or more open questions for the report? Zero status topics? Action
items first? A one-line why on each? If any check fails, fix it before showing it.

**6. Offer to write.** Show the agenda in plain text, then offer to add the topics to the
meeting. On approval, write them and confirm once.

## Sources

**Needs** C2 1-on-1 history (the one that matters), C3 work signals, C4 goals, C5 feedback recency,
C8 to write topics. Resolve each through the binding record — **this skill never names a backend**.
Contracts: [source-map.md](../../../references/source-map.md). Adapters, and how to bind a new one:
[adapters.md](../../../references/adapters.md).

**What each buys here.** C2 supplies the open action items that lead the agenda and the past topics
that stop repetition — it is the difference between a prep and a guess. C3 turns "how's it going"
into a specific question about a specific piece of friction. C4 surfaces the at-risk or stale goal
worth 5 minutes. C5 dates the last recognition, which is a topic when it is old. C8 puts the result
where the meeting will actually happen.

**Withheld when a capability is thin or absent.** No C5 → **never claim a recognition drought**;
ask when they last recognized them. No C3 → prep from history and goals, and say work signals were
not available. C2 bound to a note store rather than a calendar → the dates measure notes written,
so repeat the binding's caveat rather than asserting a meeting gap. Career recency is a keyword
scan wherever it comes from, so a miss is "unknown", never a confirmed gap.

**With nothing bound.** Ask two questions — when they last met, and what was left open — then draft
from the answers. The agenda was always the deliverable; a binding only saves the asking.

**Writing the topics** follows C8's contract: where the target is shared with the report, the
one-line *why* stays manager-side unless it is fine to share. Where C8 is unbound, output the
topics as text. Nothing anywhere schedules a meeting.

## Gate — routine mode

Ping only if the agenda contains at least one thing the manager would not have thought of.

`worth_attention: yes` when any of these is true:

- an unfinished action item from the last 1-on-1
- a work signal that suggests friction (stalled review, revert, incident, cross-team spillover)
- a goal at risk, off track, or stale
- recognition drought past the threshold
- no career topic past the threshold

`worth_attention: no` when the only thing to say is that a meeting exists. **"You have a
1-on-1 tomorrow" is never a ping.** On silence, write the findings back and stop.

Thresholds (tunable): `recognition_drought_weeks: 4`, `career_topic_gap_weeks: 8`,
`goal_stale_weeks: 6`, `signal_lookback: since last 1-on-1`, `max_topics: 5`.

## Write-back

Anything durable learned while prepping — a preference, an aspiration, something they are new
to, a commitment the manager makes out loud — goes to the person's file via `save-context`.
On a silent run, the findings are still written back so the next prep starts from them.

## Output

Plain text, short sentences, no tables, third person about people. Each topic as a title, a
one-line why, then the actions. Where a capability was missing, one line says so — "no upcoming
meeting found" or "I can't see recognition history" — never a silent gap:

`[add these to the meeting]` `[edit]` `[skip]`

## Worked example

**Manager:** prep my 1:1 with Tony tomorrow

**Agent:**

> Four topics for tomorrow. Last one was 2026-08-10.
>
> 1. The staging-access request you took on last week
>    You said you'd chase it; it's not resolved in the notes. Closing it or explaining the
>    delay takes 30 seconds and it's been open two weeks.
>
> 2. What's making the billing migration heavier than expected?
>    PR 412 has been open 6 days with no review, and the Linear ticket moved back to
>    In Progress twice. Something is in the way — worth asking rather than guessing.
>
> 3. What do you want to own next quarter?
>    Career hasn't come up in your 1-on-1s since June. It's the topic most likely to matter
>    to him and least likely to come up on its own.
>
> 4. He shipped the rate-limiter rewrite on the 12th and hasn't had recognition in 5 weeks
>    Worth saying in person — and I can draft a written one after.
>
> Topics 2 and 3 are his to answer, topic 1 is yours to close.
>
> `[add these to the meeting]` `[edit]` `[skip]`

Note what is absent: no "update on the migration", no "review last week's work". The engine
already has status. The agenda spends the 30 minutes on the four things a conversation can
actually change.

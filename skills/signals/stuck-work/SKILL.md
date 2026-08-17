---
name: stuck-work
description: Find work that has stalled — a review nobody picked up, a ticket sitting in progress for weeks — and draft a coaching check-in that offers help instead of demanding status. Use when a daily routine scans the team, or when the manager asks who needs help, what is blocked, or why something is taking so long.
---

# Stuck work

Work stalls for reasons the person is often embarrassed by: they are blocked on someone senior,
they took on something they do not know how to do, or they have been asking for a review for a
week and nobody answered. None of that surfaces in a status update.

This skill finds stalled work and frames it as **who needs help** — never who is slow. Get that
framing wrong and the skill becomes a surveillance tool, which is worse than not having it.

Serves *empowers without micromanaging* (P17). Enforces P15 (questions before advice; offer
help, never take over) and P16 (match the response to what they are new to).
Rules: [management-practices.md](../../../references/management-practices.md).

## When to use

- Routine mode: daily scan across reports. This is the main path.
- The manager asks who is blocked or needs help.
- The manager asks why something is taking long — reframe to what is in the way.

## Non-negotiables

- **Never "who is slow."** Not in the output, not in the draft, not in the write-back. A stalled
  item is a fact about the work, not about the person.
- **Offer help, never take over** (P15). The draft asks what is in the way; it does not reassign
  the work, escalate it, or tell them what to do.
- **Never sent as feedback.** A stalled review is not a performance event, and a routine has no
  business deciding it is.
- **One ping per stuck item, ever.** Not daily. The whole value dies the day this becomes noise.
- **Cap three items per run**, oldest first.
- **The manager may be the blocker.** Check that before pinging. Where the stall is waiting on
  the manager's own review or decision, say that first — it is the most common cause and the
  cheapest fix.

## Method

**1. Establish the roster and the window.**

**2. Find stalled items.** Two patterns carry most of the signal:

- a change awaiting review for ≥ `pr_stale_days`
- a ticket in progress for ≥ `ticket_stale_weeks` with no movement

Plus, when visible: work reopened more than twice, and something reassigned back and forth.

**3. Filter out the noise.** Drop anything that is stalled by design: intentionally parked work,
a draft, something blocked on an external party everyone already knows about, or an item where a
recent comment explains the wait. Drop items already pinged.

**4. Find the blocker before writing anything.** Who or what is the item waiting on? Where the
answer is the manager, the finding is about the manager's queue, and the action is "review it"
rather than "check in with them".

**5. Calibrate to maturity (P16).** If the person is new to this kind of work, an offer of a
specific kind of help is right — a pairing session, a walkthrough, naming who to ask. If they
are proven at it, one open question is enough and anything more is interference.

**6. Draft the check-in as a coaching question.** Openers that work: "What's in the way on X?",
"What would unblock the review on X?", "Is this waiting on me?" Openers that do not: "Any update
on X?", "Why is X still open?", "This has been open 9 days."

Two sentences maximum. Offer one concrete kind of help, and make it easy to say no.

**7. Present as fact, why, actions.** The fact is dated and countable. The why is the coaching
point, not a productivity concern.

**8. Write back.** Every stalled item found, whether pinged or not, so the same item never pings
twice — and so a pattern of the same person stalling on the same *kind* of work becomes visible
over months. That pattern is a real development finding, and it belongs in a 1-on-1, not in a
daily ping.

## Sources

Detail and exact parameters: [topicflow-tools.md](../../../references/topicflow-tools.md).

**Primary — Topicflow.**

- `get_user_infos(team_name: <team>)` or a confirmed roster → IDs.
- `query_external_events(target: <id>, start_datetime: <now - 30d>, end_datetime: <now>)` →
  changes, reviews, and ticket movement. Stall detection is date arithmetic on these events:
  first seen, last movement, current state.
- `list_meetings(is_oneonone: true, with_notes_and_transcript: true, limit: 2)` → whether this
  item was already discussed in a 1-on-1. If it was, stay silent.
- Write, only on the manager's action: `add_meeting_topics(meeting_id, topics)` for the 1-on-1
  route → preview → approval → `confirm_creation(pending_id)`. The direct check-in message is
  the manager's to send in their own channel; this skill drafts the text.

**Secondary, and often necessary here.** GitHub or Linear directly — an event feed says a review
is open, but the *reason* it is stuck (a requested change, a failing check, a comment thread
gone quiet) usually needs the native tool. That reason is the difference between a useful
check-in and an annoying one.

**Degrading.** No connected tools → this skill has nothing to work with. Say so once and stop;
do not substitute meeting notes for work signals. No memory for the ping ledger → dedupe within
the run and be conservative across runs: prefer the single oldest item over three medium ones.

## Gate — routine mode

`worth_attention: yes` when at least one item passes the thresholds, is not stalled by design,
is not already pinged, and is not already a 1-on-1 topic.

`worth_attention: no` otherwise — including a team where everything is moving, and a stall
already discussed. Silence writes findings back and stops.

Special case: where the manager is the blocker on ≥ 2 items, that is one finding about the
manager's own queue, and it pings even when nothing else does.

Thresholds (tunable): `pr_stale_days: 3`, `ticket_stale_weeks: 2`, `max_items_per_run: 3`,
`ping_once_per: item (never repeat)`, `lookback_days: 30`.

## Write-back

Every stalled item and its resolution. The kinds of work where a person repeatedly stalls (a
maturity signal, P16). Anything the manager explains ("that's parked until legal answers") — so
it never surfaces again. Via `save-context`.

## Output

Fact, why, actions. Plain text, no tables, third person.

`[draft a check-in]` `[add to the next 1-on-1]` `[ignore this item]`

## Worked example

Daily routine. Two items pass, one is about the manager:

> Two of Tony's changes are waiting on **your** review — PR 412 (6 days) and PR 418 (4 days).
>
> He's been blocked on you, not stalled. Both are ahead of anything else in his queue.
>
> `[open them]` `[tell him when you'll get to them]`
>
> Nadia's compliance-review ticket has been in progress 16 days, with no movement since 4 Aug.
>
> This is her first time through the compliance process, so the odds are she's stuck on how it
> works rather than on the work itself. An offer beats a status question.
>
> Draft check-in:
> "How's the compliance review going — anything in the way? Happy to walk through the process
> with you if it's the paperwork rather than the code."
>
> `[send this]` `[add to the next 1-on-1]` `[ignore this item]`

Note three things. The manager's own queue is reported first, because it is the cheapest fix and
the most common cause. Nadia's draft offers a specific kind of help based on what she is new to
(P16), and gives her an easy exit. And neither finding contains the word "delayed", "late", or
"slow" — the work is stuck, nobody is failing.

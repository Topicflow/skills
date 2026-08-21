---
name: give-recognition
description: Draft and send recognition that names the specific contribution and why it mattered, matched to the person's public-or-private preference. Use when the user wants to recognize, praise, thank, or shout out anyone — a report, a peer, their manager — or wants to mark a launch, a save, or a milestone.
---

# Give recognition

Recognition works when the person can tell you actually noticed. That means naming the thing
they did, saying what it made possible, and doing it close to the event. "Great job this
quarter!" fails all three. This skill turns a win into two to four sentences worth reading —
from a manager, a peer, or a report recognizing upward; the rules are the same in every
direction.

Serves *cares about success and well-being* (P17). Enforces P8 P9 P10.
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- The user says to recognize, praise, thank, or shout out someone — whoever it is.
- A milestone landed: a launch, a hard incident handled, a quarter-long project finished, a
  quiet piece of work nobody else would notice.
- For behavior the user wants *repeated* in a work sense — "keep writing updates like
  that" — `give-feedback` in reinforcing mode is the better tool. Recognition marks a win;
  reinforcing feedback teaches a behavior.

## Non-negotiables

- **Topicflow first.** If no Topicflow MCP tool is exposed, stop and use [the connection prompt](../../references/topicflow-tools.md).
- Name the **specific contribution** and **why it mattered**. Generic praise is not sent (P8).
- Close to the event. Past ~3 weeks, recognition reads as an audit finding — say so and offer
  to mark it in person instead.
- Respect the person's public-vs-private preference; **ask once** if unknown, then remember it
  (P9).
- Recognition is never a wrapper for criticism. No "and next time, let's…".
- Never recognize the user themselves, and never invent a contribution — if the win cannot
  be named concretely, there is nothing to send yet.
- **The equity glance is the manager's job alone** (P10) — a peer cannot see distribution and
  is not asked to.
- Confirm once before sending.

## Method

**1. Get the win concrete.** From the user's words, or from the work signals behind it. You
need three things: what they did, when, and what it made possible. Missing the third is the
usual gap — ask one question: "What did that unlock?"

Impact can be small and still real ("support stopped getting that ticket"). It cannot be
vague ("big impact on the team").

**2. Check the preference (P9).** Public or private? If it is known, follow it. If not, ask
once, in half a sentence, and save the answer. Never broadcast on a guess — for someone who
finds public praise excruciating, a channel post is a cost, not a gift.

**3. Check timeliness.** Under ~3 weeks: send. Older: say it is late, and offer either a
short, honest version ("late but worth saying") or a spoken mention in the next 1-on-1.

**4. From the manager's chair only, glance at distribution (P10).** From the recognition record
where it is readable — a measured gap with real history behind it is worth one line. Where it is
not readable, work from what the manager knows: ask in one line who else carried something
lately. Do not block the send, and do not moralize. A peer or a report skips this step entirely.

**5. Draft.** Two to four sentences, plain text:

- what they did, specifically, with the date or the artifact
- what it made possible, concretely
- optionally, what it says about how they work — only if it is grounded in the act

No superlatives doing the work of detail. "Handled the incident calmly" is a sentence about
nothing; "was the one who noticed the retry storm and killed it before it hit customers" is
the same claim with evidence.

**6. Check before showing.** Specific contribution named? Impact concrete? No generic praise?
No criticism smuggled in? Preference respected? Fix, then show.

**7. Send.** On approval, write and confirm once. For a private preference, use direct feedback
visible to the recipient only rather than a broadcast recognition.

## Sources

**The calls.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `query_external_events(start_datetime, end_datetime, target: <person id>)` — the artifact, the
  date, and often the impact the user only half-remembers. That detail is what separates
  recognition from praise.
- `create_recognition(title, recipient_id)` then `confirm_creation(pending_id, summary)` —
  **`title` is the message**, two to four sentences, plain text, no markdown. Never recognise
  the current user.
- The public-or-private preference lives in private notes: where the notes read exists, look it
  up; where it does not, or nothing is on file, ask once and save the answer (P9).

**Withheld.** `list_recognitions` ships in the 2026-08 MCP update
([TF-1596](https://linear.app/topicflow/issue/TF-1596)). Where it is absent, or an empty result
cannot be verified as real history: **no equity line and no drought claim from data, for
anyone** — the distribution glance runs on the manager's own memory, and the output says so.
With a verified read, dates are citable and a measured gap is a legitimate one-line note.

**No preference on file and the user cannot be asked → draft private and say why.** Never
broadcast on a guess (P9).

**Public and private are different audiences, not different formats.** Say in the output which
audience the draft assumes, so the user can choose before anything is sent.

**Where nothing can be sent**, hand over the text with a note on audience. Two to four specific
sentences were always the whole product.

## Gate

Not applicable — this skill only runs in chat today. The weekly equity detector
(`skills/later/recognition-scan`) is unblocked by the 2026-08 recognition read
([TF-1596](https://linear.app/topicflow/issue/TF-1596)) and waits only on a scheduler; when
reactivated, it hands its findings here to draft.

Thresholds (tunable): `timeliness_weeks: 3`, `equity_note_after_repeats: 2`.

## Write-back

Save the public-vs-private preference the first time it is learned, and save the win itself —
a named, dated contribution is exactly what a review needs in three months. Via
`save-private-note`.

## Output

The draft in plain text, then use the
[portable choice controls](../../references/interaction-controls.md) to offer send, edit, send
privately instead, or skip.

## Worked example

**Manager:** recognize Gavin for the outage last night

**Agent:** One thing first — what did his handling actually save? And do you know if he likes
this public or private?

**Manager:** he spotted the retry storm about 10 minutes in, we'd have been down another hour
otherwise. no idea on public/private.

**Agent:**

> I'll send it privately for now and ask him after — safer default than guessing.
>
> During last night's outage, Gavin was the one who spotted the retry storm about ten minutes
> in and shut it down. Without that catch we were looking at another hour of downtime on a
> weekday evening. He went straight to the traffic pattern instead of the obvious suspects,
> which is why it was ten minutes and not sixty.
>
> Offer a choice: send it, edit it, send it publicly instead, or skip.
>
> One thought while you're here: the record shows Nadia's last recognition was 2 Jul — seven
> weeks, with real history before it — and she carried the checkout rewrite this month. Worth a
> minute when you're done here.

Note the three moves: the impact question turned "recognize Gavin" into a sentence with a
number in it; the unknown preference became a private default plus a plan to ask (P9); and the
equity line is measured from the recognition record — real history, a real gap — never guessed
(P10). On a workspace without the read, that line becomes a question to the manager's memory
instead. A peer gets neither version — the glance is the manager's job.

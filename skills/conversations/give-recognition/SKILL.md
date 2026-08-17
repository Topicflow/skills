---
name: give-recognition
description: Draft and send recognition that names the specific contribution and why it mattered, matched to the person's public-or-private preference. Use when the manager wants to recognize, praise, thank, or shout out someone, or when recognition-scan surfaces a win worth marking.
---

# Give recognition

Recognition works when the person can tell you actually noticed. That means naming the thing
they did, saying what it made possible, and doing it close to the event. "Great job this
quarter!" fails all three. This skill turns a win into two to four sentences worth reading.

Serves *cares about success and well-being* (P17). Enforces P8 P9 P10.
Rules: [management-practices.md](../../../references/management-practices.md).

## When to use

- The manager says to recognize, praise, thank, or shout out someone.
- `recognition-scan` found a win plus a drought and handed it here.
- A milestone landed: a launch, a hard incident handled, a quarter-long project finished, a
  quiet piece of work nobody else would notice.
- For behavior the manager wants *repeated* in a work sense — "keep writing updates like
  that" — `give-feedback` in reinforcing mode is the better tool. Recognition marks a win;
  reinforcing feedback teaches a behavior.

## Non-negotiables

- Name the **specific contribution** and **why it mattered**. Generic praise is not sent (P8).
- Close to the event. Past ~3 weeks, recognition reads as an audit finding — say so and offer
  to mark it in person instead.
- Respect the person's public-vs-private preference; **ask once** if unknown, then remember it
  (P9).
- Recognition is never a wrapper for criticism. No "and next time, let's…".
- Never recognize the manager themselves, and never invent a contribution — if the win cannot
  be named concretely, there is nothing to send yet.
- Confirm once before sending.

## Method

**1. Get the win concrete.** From the manager's words, or from the work signals behind it. You
need three things: what they did, when, and what it made possible. Missing the third is the
usual gap — ask one question: "What did that unlock?"

Impact can be small and still real ("support stopped getting that ticket"). It cannot be
vague ("big impact on the team").

**2. Check the preference (P9).** Public or private? If it is known, follow it. If not, ask
once, in half a sentence, and save the answer. Never broadcast on a guess — for someone who
finds public praise excruciating, a channel post is a cost, not a gift.

**3. Check timeliness.** Under ~3 weeks: send. Older: say it is late, and offer either a
short, honest version ("late but worth saying") or a spoken mention in the next 1-on-1.

**4. Glance at distribution (P10).** How long since each report was recognized? If this is the
second or third for the same person while someone else is in a multi-week drought, say it in
one line — do not block the send, and do not moralize. The manager may have a reason.

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

Detail and exact parameters: [topicflow-tools.md](../../../references/topicflow-tools.md).

**Primary — Topicflow.**

- `get_user_infos(target_names: [name])` → recipient ID. `team_name` when recognizing a group.
- `query_external_events(target: <id>, start_datetime, end_datetime)` → the artifact, the date,
  and often the impact the manager half-remembers.
- `list_feedback(recipients: <id>, order: "-created", limit: 10)` → recency for this person;
  run it across the team for the distribution check.
- Write, public: `create_recognition(title: <the message>, recipient_id)` → preview →
  approval → `confirm_creation(pending_id)`. **`title` is the message itself** — 2-4
  sentences, plain text, no markdown. `recipient_ids` for several people;
  `recipient_name` accepts a team name. `core_value_id` when the org uses core values and one
  genuinely fits — do not force it.
- Write, private: `create_feedback(title, description, recipient_id,
  recipients_can_view: true, recipients_managers_can_view: false)` — same content, audience of
  one.

**Secondary.** Slack, read-only, to find where the win was mentioned and by whom. Linear or
GitHub for the artifact link.

**Degrading.** Recognition history unreadable → skip the distribution line rather than
inventing a drought; an absence you cannot verify is not evidence. Preference unknown and the
manager is not present (routine mode) → draft it as private and say why.

## Gate — routine mode

This skill drafts; `recognition-scan` decides whether a routine should speak. Reached from a
routine, it inherits that gate and never sends without an approval.

Thresholds (tunable): `timeliness_weeks: 3`, `equity_note_after_repeats: 2`,
`drought_weeks: 4`.

## Write-back

Save the public-vs-private preference the first time it is learned, and save the win itself —
a named, dated contribution is exactly what `review-prep` needs in three months. Via
`save-context`.

## Output

The draft in plain text, then:

`[send]` `[edit]` `[send privately instead]` `[skip]`

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
> `[send]` `[edit]` `[send publicly instead]` `[skip]`
>
> Also: Nadia hasn't had recognition in 6 weeks, and she carried the checkout rewrite. Worth
> a look when you have a minute.

Note the three moves: the impact question turned "recognize Gavin" into a sentence with a
number in it; the unknown preference became a private default plus a plan to ask (P9); and the
equity observation is one line at the end, not a lecture in the middle (P10).

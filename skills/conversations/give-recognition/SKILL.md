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

Serves *cares about success and well-being* (P17). Enforces:

- P8, specific and timely: the exact contribution, why it mattered, close to the event.
- P9, personalized: follow the person's public-or-private preference; ask once if unknown.
- P10, equitable: notice who else carried something lately. The manager's chair only.

## When to use

- The user says to recognize, praise, thank, or shout out someone — whoever it is.
- A milestone landed: a launch, a hard incident handled, a quarter-long project finished, a
  quiet piece of work nobody else would notice.
- For behavior the user wants *repeated* in a work sense — "keep writing updates like
  that" — `give-feedback` in reinforcing mode is the better tool. Recognition marks a win;
  reinforcing feedback teaches a behavior.

## Non-negotiables

- **Topicflow first.** If no Topicflow MCP tool is exposed, stop and follow
  [connect-topicflow.md](references/connect-topicflow.md).
- Name the **specific contribution** and **why it mattered**. Generic praise is not sent (P8).
- Close to the event. Past ~3 weeks, recognition reads as an audit finding — say so and offer
  to mark it in person instead.
- Respect the public-vs-private preference; **ask once** if unknown, then remember it (P9).
- Recognition is never a wrapper for criticism. No "and next time, let's…".
- Never recognize the user themselves, and never invent a contribution — if the win cannot
  be named concretely, there is nothing to send yet.
- **The equity glance is the manager's job alone** (P10) — a peer cannot see distribution and
  is not asked to.
- Confirm once before sending.

## Method

**1. Get the win concrete.** You need what they did, when, and what it made possible.

- *The user gave substance, or said to draw from the person's work:* draft now. Do not
  interview someone who already told you the story, or who just told you to go and look.
- *The user named a person and nothing else* ("recognize Jordan"): ask, do not go hunting. Two
  short questions, one at a time: what did they do, and what did it make possible. The user
  already knows why they thought of this person; the work record would only invent an occasion.
- Never narrate which of these you are doing.

The impact is the usual gap — ask "What did that unlock?" It can be small and still real
("support stopped getting that ticket"), but never vague ("big impact on the team").

**2. Check the preference (P9).** Known: follow it. Unknown: ask once, in half a sentence, and
save the answer. Never broadcast on a guess — for someone who finds public praise excruciating,
a channel post is a cost, not a gift.

**3. Check timeliness.** Under ~3 weeks: send. Older: say it is late, and offer a short, honest
version ("late but worth saying") or a spoken mention in the next 1-on-1.

**4. From the manager's chair only, glance at distribution (P10).** Where the recognition record
is readable, a measured gap with real history behind it is worth one line. Where it is not, ask
in one line who else carried something lately. Do not block the send, and do not moralize. A
peer or a report skips this step.

**5. Draft.** Read [examples.md](references/examples.md) before the first draft of a run. Two
to four sentences, plain text:

- what they did, specifically, with the date or the artifact
- what it made possible, concretely
- optionally, what it says about how they work — only if it is grounded in the act

No superlatives doing the work of detail. "Handled the incident calmly" is a sentence about
nothing; "noticed the retry storm and killed it before it hit customers" is the same claim with
evidence.

**6. Check before showing.** Specific contribution named? Impact concrete? No generic praise?
No criticism smuggled in? Preference respected? Fix, then show.

**7. Send.** On approval, write and confirm once. A private preference goes as a direct message
only the recipient can see, not as a broadcast recognition.

## Sources

Read [sources.md](references/sources.md) before the first call: the parameters, and the claims
to withhold when a call fails or comes back empty.

- `get_organization_context` — the org's word for recognition and its active core values.
- `get_user_infos` — the person's ID, once per run.
- `query_external_events` — the artifact and the date behind the win.
- `list_private_notes` — the public-or-private preference.
- `list_recognitions` — the distribution glance, manager's chair only.
- `create_recognition` (public) or `create_feedback` (private), then `confirm_creation`.

## Gate

Not applicable — this skill only runs in chat today. The weekly equity detector
(`skills/later/recognition-scan`) waits only on a scheduler; when reactivated, it hands its
findings here to draft.

Thresholds (tunable): `timeliness_weeks: 3`, `equity_note_after_repeats: 2`.

## Write-back

Save the public-vs-private preference the first time it is learned, and save the win itself —
a named, dated contribution is exactly what a review needs in three months. Via
`save-private-note`.

## Output

The draft in plain text, with one line on which audience it assumes, public or private. Then use
the [portable choice controls](references/interaction-controls.md) to offer send, edit, send
privately instead, or skip.

Worked examples, including what the skill declined: [examples.md](references/examples.md).

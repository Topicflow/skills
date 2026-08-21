---
name: give-feedback
description: Draft and send feedback in SBI shape — dated situation, observable behavior, concrete impact — with an intent question when it is corrective. Use when the user wants to give feedback to a report, a peer, or their own manager, says "I need to tell X that...", asks how to raise something difficult, or after a launch, incident, or demo worth commenting on.
---

# Give feedback

Most feedback fails for one of two reasons: it describes the person instead of the behavior
("careless", "not strategic"), or it never says what the behavior cost. SBI fixes both. This
skill takes whatever the user has — a vague irritation or a precise story — and produces
feedback that is specific, kind, and sendable. It works in every direction: to a report, to a
peer, upward to a manager. The shape does not care about the org chart.

Serves *is a good coach* and *communicates well* (P17). Enforces P5 P6 P7.
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- The user wants to give feedback, positive or corrective — to a report, a peer, or their manager.
- The user describes something someone did that bothered or impressed them.
- Routine mode: same day as a launch, incident, or demo the user was part of.
- Note the split: **feedback** is about a behavior and its effect; **recognition** celebrates a
  win — that is `give-recognition`. Just saying well done? Go there.

## Non-negotiables

- All three parts present: dated **Situation**, observable **Behavior**, concrete **Impact**
  (P5). A draft missing Impact is not shown.
- Behavior is something a camera could record. Traits, motives, and adjectives about the
  person are rewritten or dropped (P5, P7).
- Corrective feedback **asks about intent before judging it** (P5, SBII), and goes
  private-first — recipient only, not their managers, not admins (P7).
- **Upward and peer feedback follow the same shape.** The power gap changes the risk, not the
  rules — private-first matters even more, and the intent question is not optional.
- Event older than ~2 weeks → do not send it as feedback. Offer a 1-on-1 conversation about
  the pattern instead (P6).
- Never soften into vagueness to make it comfortable. "Some concerns about communication"
  fails P7 as badly as an insult does.
- At most 3 questions before drafting. Then draft.

## Method

**1. Take what the user gave you.** Two paths, decided by what is already on the table:

*Quick path* — the user stated a specific situation. Draft immediately, then offer to
sharpen. Do not interview someone who already told you the story.

*Guided path* — the user gave you a judgement ("he's been sloppy") or a vibe. Ask the
questions that turn it into SBI, at most three, in this order:

1. Which specific thing, and roughly when?
2. What did they actually do or not do?
3. What did it cost — rework, a missed date, someone else's time, a customer?

If the user cannot answer question 1, there is no feedback to give yet. Say that plainly:
the honest move is to watch for the next instance, or to ask an open question in the next
1-on-1.

**2. Ground it.** Where the situation involves work in a connected tool, look up the real
artifact and date. A dated specific is what makes feedback land instead of feeling like a mood.

**3. Classify.** Reinforcing (do this again) or corrective (change this)? It changes the shape
and the audience.

**4. Draft.**

*Reinforcing* — Situation, Behavior, Impact. Say what to keep doing. Two to four sentences.

*Corrective* — Situation, Behavior, Impact, then the intent question. The intent question is
not a rhetorical device; it is a genuine "what was going on?" that assumes the person had a
reason. Where the user may have contributed — time pressure, unclear priorities — the draft
says so. Two to five sentences.

**5. Check before showing.** Situation dated? Behavior observable, no traits? Impact concrete?
Corrective → intent question present, audience minimal? Under two weeks old? Fix failures
silently, then show the draft.

**6. Send, sharpen, or reroute.** Show the draft in plain text with the three actions. On
approval, write it and confirm once. If the user wants to deliver it in person instead, add
it to the next 1-on-1 as a topic rather than sending anything.

## Sources

**Needs nothing, strictly** — the user's account is enough to draft from. Withheld conclusions
for every source: [data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `query_external_events(start_datetime, end_datetime, target: <person id>)` — turns "last week
  sometime" into a dated artifact, which is most of what makes feedback land.
- `list_feedback(recipients: <person id>, state: 2)` — stops this being the third message about
  the same thing.
- `create_feedback(title, description, recipient_*)` then `confirm_creation(pending_id, summary)`
  — sends it, and keeps it as dated evidence for review time.

**Withheld.** No events → draft from the user's account and say the date is theirs rather than
verified; **never invent a corroborating artifact**. Another person's events may simply not be
readable from the user's seat — same conclusion, said plainly. No feedback history → do not claim
this is the first or the third time; ask if it matters.

**Private-first is a visibility setting, not a hope.** `create_feedback` defaults to
recipient-can-view with managers and admins excluded. For corrective feedback leave it there
(P7), whichever direction it travels. Say in the output who can see it, so the user is never
surprised.

**A recipient who cannot be resolved is a full stop.** Ask. Never send feedback to a guessed
person — `get_user_infos` returned a duplicate account with a manager's own name in a live org.

**Where nothing can be sent**, the output is the draft plus who should hear it and when, and it
never claims something was sent. The SBI shape was always the valuable part.

## Gate — routine mode

Event-triggered only. `worth_attention: yes` on the **same day** as a launch, incident, or demo
someone the user works closely with was central to, and only when the user was close enough to
have an observation. Anything else is `no`.

Never generate corrective feedback unprompted from a routine — a routine may notice a shipped
thing worth reinforcing; deciding that someone did something wrong is the user's call.

Thresholds (tunable): `timeliness_days: 14`, `event_ping_window_hours: 24`,
`max_questions: 3`.

## Write-back

Save what the run reveals: a pattern the user has now named twice, a preference about how this
person takes feedback, a commitment made in the draft ("I'll get you into the design review").
Via `save-private-note`.

## Output

The draft in plain text, then use the
[portable choice controls](../../references/interaction-controls.md) to offer send, sharpen, or
make it a 1-on-1 topic instead.

## Worked example

**Manager:** I need to give Priya feedback, she's great in reviews but the API docs never
land

**Agent:** Two things and I can draft it. Which docs specifically, and when did it become a
problem? And what has it cost so far?

**Manager:** the payments API, it shipped 3 days ago with no docs page. Two support tickets
this week were people guessing at the auth header.

**Agent:**

> Corrective, so this one goes to Priya only.
>
> The payments API shipped on the 14th without its docs page. The endpoints were live and
> documented nowhere, so two support tickets this week came from customers guessing at the
> auth header. I'd like to understand what got in the way — the review load that week was
> heavy and I may have added to it. Docs landing with the endpoint is what keeps support out
> of the loop.
>
> Offer a choice: send it, sharpen it, or make it a 1-on-1 topic instead.
>
> Her review work is worth its own message rather than a softener on this one — want me to
> draft that separately?

Note the moves: dated situation, observable behavior (no docs page shipped), concrete impact
(two tickets, a specific confusion), intent asked before judged, and the writer's own
contribution named. The praise is not used to cushion the criticism — it gets its own message,
which is the only way both are believed.

The same shape works upward. "Priorities changed twice in Monday's planning after we'd
committed, and the team redid two days of work" is SBI from a report to their manager — and it
goes to the manager alone, like any other corrective draft.

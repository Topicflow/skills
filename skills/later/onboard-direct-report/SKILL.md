---
name: onboard-direct-report
description: Set up a new reporting relationship — capture role and starting context, draft the first 1-on-1 agenda, and lay in day-7, day-30, and day-60 topics. Use when a manager gets a new direct report, inherits someone in a reorg, or says "X is joining my team" or "help me onboard X".
---

# Onboard a direct report

The first month decides how much someone tells you for the next year. Two things make it go
well: the manager knows what this person is new to, and the early conversations are about the
person rather than their output. This skill sets both up, and leaves check-in topics in the
calendar so week five does not quietly become week twelve.

Serves *supports career development* and *empowers without micromanaging* (P17). Enforces P13
(career is its own conversation, starting with life story) and P16 (baseline their
task-relevant maturity now).
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- A new hire joins the manager's team.
- The manager inherits an existing employee — a reorg, a transfer, a manager change. This case
  matters more than a new hire, because everyone assumes the context transferred and it did
  not.
- The manager asks how to start with someone.

## Non-negotiables

- The first 1-on-1 is **not** a status meeting and **not** a performance conversation. It is
  the life-story end of the career arc (P13): where they have been, what they are good at,
  what they want.
- Baseline maturity **per task**, not per person (P16). "Senior engineer" says nothing about
  whether they have ever owned an on-call rotation here.
- At most 4 questions to the manager. Anything else can be learned in the meetings.
- Everything captured is written back before any drafting (library convention 3).
- A first goal is **proposed**, never imposed. The report drafts, the manager shapes (P11).
- Confirm once per write. Topics for three different meetings are three changes, one approval.

## Method

**1. Read what the system already knows.** The person's profile including career track — level,
role, competencies, next role. For an inherited report, also any goals already open and the last
few 1-on-1s with their previous manager, if visible. Do not ask the manager anything the profile
already answers.

**2. Ask up to four questions.** Only the ones the tools cannot answer:

1. What will they own in the first quarter?
2. What parts of that are they **new to**? (the maturity baseline — P16)
3. When is day one, or when did the handover happen?
4. Anything you already know about how they like to work?

For an inherited report, replace question 4 with: what did their previous manager tell you, and
what have you deliberately not been told?

**3. Write it back.** Role, scope, the new-to list, any preference — one sentence each, third
person, dated. This is the record the next six skills read from.

**4. Draft the first 1-on-1 agenda.** Four topics, mostly theirs, in this order:

- *Their story* — how they got here, and what has made previous managers useful or useless to
  them. Open question, and the largest block of time.
- *What they need in week one* — access, context, a first small win, who to meet.
- *How we will work* — cadence, what the 1-on-1 is for, how they prefer feedback and recognition,
  how to reach the manager between meetings.
- *What the manager owns* — the manager's commitments, said out loud, so the relationship starts
  with the manager on the hook too (P14).

No status topics. There is no status yet, and setting the precedent early is the point (P3).

**5. Lay in the check-in topics.** Three future 1-on-1s, one topic each:

- **Day 7** — "What has been confusing so far?" Confusion is cheapest to fix in week one, and the
  person stops mentioning it by week three.
- **Day 30** — "What makes sense now that didn't on day one, and what still doesn't?" Plus a first
  read on the new-to list: what has moved from new to normal.
- **Day 60** — expectations both ways: is the scope right, is anything missing, and book the first
  proper career conversation (P13).

Write each to the corresponding meeting. Where those meetings do not exist yet, output the topics
and ask the manager to schedule the series first — nothing here can create a meeting.

**6. Offer a first goal, do not write one.** If the first-quarter ownership is clear, propose a
30-day goal with measurable key results (P11) and suggest the report drafts it in their first
week. Create it only if the manager asks, with the **report** as owner.

## Sources

**The calls.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `get_user_infos(target_names, include_career_track: true)` — level, competencies, and what the next
  role looks like. That is what makes the day-60 conversation concrete rather than generic.
- `add_meeting_topics(meeting_id, topics)` — puts day-7, day-30 and day-60 topics on real dates
  instead of in a message the manager loses.
- The baseline itself has nowhere to live yet (TF-1595), so it is handed back — see `save-private-note`.

**Reuse the company's own material where it exists.** An onboarding checklist or a career ladder
already written is better than a generic one from this skill. Read it; do not invent a parallel
version next to it.

**Withheld.** No career track returned → skip the level language and ask what good looks like in 90
days. Baseline not filed → say so plainly; the four agendas are unaffected. For an inherited report,
treat a previous manager's visible notes as history, never as current fact — the maturity baseline is
asked fresh.

**Nothing schedules a meeting.** Where the 1-on-1 series does not exist yet, deliver all four agendas
with the dates they belong on and ask the manager to set the series up. Never claim the check-in
topics were placed when they were not.

## Gate — routine mode

Event-triggered, once. `worth_attention: yes` when a new report appears in the manager's 1-on-1s
with no prior meeting history. Never repeats for the same person.

Thresholds (tunable): `checkin_days: [7, 30, 60]`, `max_questions: 4`,
`first_goal_horizon_days: 30`.

## Write-back

The whole point of step 3. Role, scope, the new-to list, preferences, and the manager's own
commitments. `give-recognition` reads the preference, `stuck-work` and `goal-checkin` read the
new-to list, `review-prep` reads all of it in six months.

## Output

The captured baseline, the first agenda, the three check-in topics, then:

`[write all topics]` `[edit]` `[draft the first goal too]`

## Worked example

**Manager:** Nadia starts Monday, reporting to me. She's a senior backend engineer.

**Agent:** Her profile has the level and competencies. Two questions: what will she own in Q4,
and which parts of that is she new to?

**Manager:** she'll own the payments service. She's done payments before but never with our
compliance review process, and she's never been on an on-call rotation.

**Agent:**

> Saved to Nadia's file: owns payments service from 2026-08-24; experienced with payments,
> new to the compliance review process and to on-call.
>
> First 1-on-1 — four topics, three of them hers:
>
> 1. What should I know about how you got here, and what have past managers done that helped?
> 2. What do you need in week one — access, context, who to meet?
> 3. How we'll work: weekly 1-on-1s, this is your meeting, and how you like feedback delivered.
> 4. What I'm on the hook for: compliance-review walkthrough before your first one, and an intro
>    to the on-call rotation lead this week.
>
> Then, already dated:
>
> - Sep 1 (day 7): What's been confusing so far?
> - Sep 24 (day 30): What makes sense now that didn't, and what still doesn't? Plus: how did
>   the first compliance review go?
> - Oct 24 (day 60): Is the scope right? And book the first career conversation.
>
> `[write all topics]` `[edit]` `[draft a 30-day goal too]`

Note that topic 4 exists at all. The manager arrives at the first meeting with two commitments
of their own, both aimed at the two things Nadia is new to (P14, P16). And no topic anywhere
asks what she is working on.

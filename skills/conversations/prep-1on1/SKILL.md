---
name: prep-1on1
description: Draft a 1-on-1 agenda balanced across the work, the person, and the direction — from open action items, work signals, goal health, and recency gaps — then write the topics to the meeting. Works from either chair. Use when the user says "prep my 1:1 with X", "prep my 1:1 with my manager", "what should I talk about with X", "anything I'm missing before my 1:1", or when a routine runs 24h before a scheduled 1-on-1.
---

# Prep a 1-on-1

A 1-on-1 that reviews the week's work is a status meeting wearing a better name. The research is
blunt: the best 1-on-1s are the report's meeting, mostly non-tactical, framed as questions to be
answered rather than topics to be covered (Rogelberg; Manager Tools; GitLab). This skill builds
that agenda — 3-5 questions across three lanes — from either chair.

Serves *is a good coach* and *communicates well* (P17). Enforces P1 P2 P3 P4.
Rules: [management-rules.md](../../../references/management-rules.md).
Question bank, per lane and chair, with sources: [questions.md](questions.md).

## When to use

- The manager asks to prep, or asks what to cover with someone on their team.
- A direct report preps the 1-on-1 with their own manager.
- Routine mode: 24 hours before each formal 1-on-1.
- Another skill wants a finding discussed rather than sent — this is where it lands.

## Non-negotiables

- **Three lanes, every agenda.** *The work* — blockers and decisions. *The person* — how they are
  actually doing. *The direction* — growth, career, feedback in both directions. The work lane
  never takes more than half the topics; the person and direction lanes get at least one topic
  each, every time. Rich work data is not a reason to skip the human half — that is exactly how
  status takes the meeting over (P3).
- **Every topic is a question**, not a heading. "Q3 planning" is a heading; "what do you want to
  own in Q3 planning?" can be answered.
- At least half the topics belong to the report, as open questions (P1).
- Start from last meeting's unfinished action items (P4). They lead the work lane.
- **From the report's chair, never hand over a finished agenda.** Propose candidates, then ask —
  the meeting is theirs, so the agenda has to come from them.
- 3-5 topics, each with a one-line why. Confirm once before writing.

## Method

**1. Establish the chair, the person, and both meetings.** The other participant is either the
user's report or their own manager — ask once when the phrasing does not say. Find the **last**
1-on-1 (with notes) and the **next** one. No next meeting → draft anyway; the write step becomes
"schedule it and I'll add these".

**2. Read the last meeting for open loops (P4).** From the previous one or two meetings, pull
anything unfinished: an action item with no outcome, a deferred topic, a promise either side
made. These outrank everything else in the work lane.

**3. Gather candidates, by lane.**

- *The work* — friction and change in the signals, never volume: something waiting on someone,
  reversed, redone, or crossing team lines. Goals at risk, stale, or too many (P12).
- *The person* — **no data serves this lane, by design.** It is an open question to a human. Pick
  one from the bank and tie it to something real when possible — the on-call week, the deadline
  that moved. Never bare "how are you".
- *The direction* — career recency (past ~8 weeks it is a topic, from either chair, P13),
  feedback in both directions, and what is changing around the team that they should hear.

**4. Manager's chair — compose and convert.** Order: unfinished action items → the one work item
that most needs a decision → the person topic → the direction topic. Convert for P1: at least
half the topics genuinely for the report, as open questions. Over the work-lane cap, drop a work
item — never the person or direction topic. Drop anything both people already know: that is
status.

**5. Report's chair — propose, then ask.** Show the candidates by lane in one message: the work
asks the data suggests, plus two or three person and direction suggestions from the bank. Then
one question at a time, suggested answer first — "What do you most want from them this time: a
decision, context, feedback, or career air-time?" — keeping, cutting, and adding until 3-5
topics are theirs. Two or three rounds, not an interrogation.

Make each work ask answerable: recommendation plus response wanted (approval, direction, or
support). "The migration is hard" becomes "I recommend the 29th — yes, or a better date?"

**6. Check the draft.** Lanes within quota? Every topic a question? Half or more the report's?
Action items first? A one-line why on each? Fix before showing.

**7. Offer to write.** Show the agenda in plain text, then offer to add the topics to the
meeting. On approval, write them and confirm once.

## Sources

**The calls.** Withheld conclusions: [data-sources.md](../../../references/data-sources.md).
Parameters: [topicflow-tools.md](../../../references/topicflow-tools.md).

- `list_meetings(is_oneonone: true, with_notes_and_transcript: true, order: "-start_datetime",
  limit: 3-5)` — open action items and past topics. **Filter on
  `is_manager_and_report_oneonone: true` and check the other participant is the right person.**
- `query_external_events(start_datetime, end_datetime, target)` — the work lane. Defaults to the
  current user (right for the report's chair); from the manager's chair **pass the report's ID**.
- `list_goals(owners)` — the at-risk or stale goal. Same default, same rule.
- `list_feedback(recipients: <person id>, state: 2)` — feedback recency, the direction lane.
- `add_meeting_topics(meeting_id, topics)` — puts the result where the meeting will happen.

**No call serves the person lane.** That is not a gap to route around — the lane exists to ask a
human what no record can say. Never fill it with a work item because the work data is richer.

**Withheld.** A drought claim needs a verified recognition read: where the read is absent or an
empty is unverified, ask instead (manager's chair). Empty feedback → never called recent or
overdue. No events → the work lane thins and one line says so; other lanes untouched. Career
recency is a keyword scan — a miss is "unknown", never a confirmed gap.

**With nothing readable**, ask when they last met and what was left open, then draft from that.

**Writing the topics.** The agenda is shared between both participants; a private reason for a
topic stays with the user. No upcoming meeting → topics as text. Nothing schedules a meeting.

## Gate — routine mode

Ping only if the agenda contains at least one thing the user would not have thought of:

- an unfinished action item from the last 1-on-1
- a work signal suggesting friction (stalled, reversed, redone, spilling across teams)
- a goal at risk, off track, or stale
- a direction-lane gap past its threshold: career quiet, or — manager's chair only — a
  recognition drought

`worth_attention: no` when the only thing to say is that a meeting exists — **"you have a 1-on-1
tomorrow" is never a ping.** Routine drafts obey the lane quota too. On silence, write the
findings back and stop.

Thresholds (tunable): `career_topic_gap_weeks: 8`, `recognition_drought_weeks: 4`,
`goal_stale_weeks: 6`, `max_work_lane_share: half`, `max_topics: 5`.

## Write-back

Anything durable learned while prepping — a preference, an aspiration, a commitment said out
loud — via `save-private-note`. On a silent run, findings are still written back.

## Output

Plain text, no tables, third person about people. Each topic is a question with a one-line why.
Then use the [portable choice controls](../../references/interaction-controls.md) to offer add to
the meeting, edit, or skip.

## Worked example

**User:** prep my 1:1 with Tony tomorrow — he's my manager

**Agent:**

> From what I can read, by lane — then one question before I draft.
>
> The work: your cutover change has waited on review for 6 days, and your standup goal is 7 weeks
> past its date (re-date, close, or drop — his call with you). The direction: career hasn't come
> up in your notes since June, and you could ask him for feedback on the migration writeups. The
> person: nothing I can read covers how these two weeks actually felt — that one is yours to
> bring.
>
> What do you most want from Tony this time — the decision, feedback, or career air-time?

**User:** the decision mostly. and growth, I keep postponing that

**Agent:**

> Four topics, three of them yours to raise:
>
> 1. The staging-access item he took on last week — his to close, 30 seconds.
> 2. "I recommend cutting over on the 29th — can you decide, or tell me what's missing?"
>    A recommendation with a date gets a decision; "the migration is hard" gets sympathy.
> 3. "What should I be doing now to prepare for the next step?" Career is 10 weeks quiet, and
>    naming the ask beats hinting at it.
> 4. "From your side — what should I start, stop, or continue doing?" Feedback lands on the
>    agenda so you actually get some, and it doubles as the how-are-we-working check.
>
> Offer a choice: add these topics to the meeting, edit them, or skip.

Note the drop: the stale goal — real and data-backed — stays in the notes for next time, because
the work lane was full. The data proposed; the user disposed.

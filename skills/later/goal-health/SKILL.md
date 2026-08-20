---
name: goal-health
description: Check the health of a team's goals — stale, off track, unmeasurable, or too many at once — and propose unblocking options that keep ownership with the report. Use when a monthly routine reviews goals, or when the manager asks how goals are going, which are at risk, or whether someone has too much on.
---

# Goal health

Goals fail in four predictable ways: nobody has looked at them in two months, they are off track
and nobody has said so, they were never measurable to begin with, or there are seven of them.
This skill finds which of the four is happening and proposes the smallest useful next step.

The report owns the goal. The manager shapes it, unblocks it, and does not post progress on
someone else's behalf.

Serves *is productive and results-oriented* (P17). Enforces P11 (specific and measurable, report
drafts), P12 (few and alive), P15 (coach with questions, do not take over).
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- Routine mode: monthly per goal. This is the main path.
- The manager asks how goals are going, what is at risk, or whether someone is overloaded.
- Before a review cycle, to see what the goal record will actually support.

## Non-negotiables

- **Never post a check-in on a report's goal on their behalf.** That is their voice and their
  progress record. Default action is a 1-on-1 topic or a nudge to them (P15). Post a check-in
  only when the manager owns the goal, or explicitly asks and understands whose name it appears
  under.
- **Stale is a definition, not an accusation.** No check-in in `stale_weeks` is stale, full stop
  (P12).
- **Never ping a healthy goal.** "Two goals on track" is not a finding.
- **Unmeasurable goals get fixed, not tracked.** A goal with no measurable key result cannot be
  checked in on at all — the finding is the goal's shape (P11).
- **More than three active goals is a focus problem**, and it is the manager's to fix, not the
  report's (P12).
- **Coach first.** Options are offered as questions the report answers, not decisions the manager
  makes about their work.

## Method

**1. Pull the goals in scope.** The manager's reports' open goals, with status, progress, key
results, and last check-in date.

**2. Classify each goal into one of five states.**

- *Healthy* — on track, checked in inside the window. Silent.
- *Stale* — no check-in in `stale_weeks`, regardless of status. The most common finding, and the
  cheapest to fix.
- *Off track* — status at risk or off track. Needs a conversation, not a check-in.
- *Unmeasurable* — no key result, or key results with no number or clear done-state (P11).
- *Overloaded* — the person, not the goal: more than `max_active_goals` open at once (P12).

**3. Per finding, propose one or two options, smallest first.** For a stale goal: a nudge to the
report, or a 1-on-1 topic. For off track: name what changed and offer one thing the manager could
remove — scope, a dependency, a competing priority. For unmeasurable: offer a sharpened key
result as a suggestion for the report to accept or replace. For overloaded: ask which one they
would drop.

Frame every option as a question the report answers (P15). "What would make this finishable by
the end of the month?" beats "reduce the scope."

**4. Check the drafts.** Does every proposed key result have a number or an unambiguous
done-state (P11)? Does any action take ownership away from the report (P15)? Does the output
contain a healthy goal (it should not)?

**5. Act, or hand off.** Preferred: add a topic to the next 1-on-1, one per person, grouping
their goal findings together. Only edit a goal or post a check-in when the manager asks —
preview, one approval, confirm once.

**6. Write back.** Findings, the manager's reasons for dismissing any of them, and any scope
decision made in the conversation. A goal deliberately parked should not be reported as stale
next month.

## Sources

**The calls.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `list_goals(owners: <report id>)` — **pass the report's ID**; it defaults to the current user's own
  goals. `status`: 0 none, 1 on_track, 2 at_risk, 3 off_track.
- `add_meeting_topics(meeting_id, topics)` — places the unblocking topic on the next 1-on-1.
- `create_goal_checkin(goal_id, message)` — only where the manager owns the goal or explicitly asks.

**Four of the five findings do not need check-in history.** Unmeasurable goals (P11), off-track
status, overload past `max_active_goals` (P12), and no goals at all are all computable from the
objective, the key results, the status, and the count. Only staleness needs a date.

**Withheld. No check-in date → no staleness claim.** Do not declare every goal stale, and do not treat
them all as fresh — say recency is unmeasurable, in one line, and report the other four findings
normally. Where a progress value stands in for a check-in date it is a weaker proxy: say which one was
used, because "no check-in" and "no visible check-in" are different claims.

**`list_goals` returns open goals only, so never report "nothing completed".** Closed and completed
goals are not reliably retrievable. List what is open and ask the manager what closed.

**With nothing returned**, ask what each person's current goals are. A goal nobody can name is itself
the finding (P11), and the overload count works from the answer alone.

**Ownership.** A check-in belongs to the goal's owner. A manager posting one on a report's goal is a
last resort, not the default (P15), and it takes one approval.

## Gate — routine mode

`worth_attention: yes` when at least one goal is stale, off track, or unmeasurable, or a person
is over `max_active_goals`.

`worth_attention: no` when every goal is on track and recently checked in, when the only finding
was already discussed in a recent 1-on-1, or when check-in recency could not be read. Silence
writes findings back and stops.

Thresholds (tunable): `stale_weeks: 6`, `max_active_goals: 3`, `max_findings_per_run: 5`,
`ping_cooldown: 1 per goal per month`.

## Write-back

Findings and their resolutions. Parked-by-design goals. Any scope change the manager decides.
Whether a report tends to set goals with no measure (a coachable pattern, not a ping). Via
`save-private-note`.

## Output

Grouped by person, one line per goal, then the action. Plain text, no tables, third person.

`[add to the next 1-on-1]` `[sharpen the key result]` `[nudge them]` `[dismiss]`

## Worked example

Monthly routine. Nine goals across four reports; three findings:

> **Tony** — "Migrate billing to the new provider" — no check-in since 2 Jul, 7 weeks.
> Status still says on track, but the record has gone quiet while the work clearly moved. The
> gap matters at review time: no check-ins means no evidence.
> `[add to the next 1-on-1]` `[nudge him]`
>
> **Nadia** — "Improve API documentation" — no measurable key result.
> There is no way to check in on this, and no way to tell at the deadline whether it happened.
> Suggestion for her to accept or replace: "Every public payments endpoint has a docs page with
> a working auth example by 30 Sep."
> `[suggest this to her]` `[add to the next 1-on-1]`
>
> **Sam** — 5 active goals.
> Beyond about three, everything becomes a background task. This is yours to fix rather than
> his: the useful question is which one he would drop if he could only keep three.
> `[add to the next 1-on-1]` `[dismiss]`
>
> Priya's two goals are on track and checked in this month — nothing to do.

Note that no check-in was posted for anyone. Tony's silent goal becomes a nudge to Tony; Nadia's
key result is a *suggestion* she can reject; Sam's overload is named as the manager's problem.
The one healthy person gets one clause, not a paragraph.

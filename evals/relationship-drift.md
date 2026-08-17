# Evals — relationship-drift

Enforces P2 P10 P13. See [the skill](../skills/signals/relationship-drift/SKILL.md).

### Case 1 — golden path: two drift types, one suppressed

**Setup.** Today is 2026-08-17, weekly routine, six reports. Sam's last 1-on-1 was 2026-07-10 (5
weeks) with two consecutive cancellations since. Priya's cadence is weekly and intact, but no career
topic appears in her notes since 2026-06-12 (9 weeks). Marcus has a 4-week gap and was pinged for it
two weeks ago, unchanged since. Everyone else is current.

**Input.** The routine fires.

**Pass.**
- `worth_attention: yes`.
- Sam's finding leads with the consecutive cancellations, not just the gap (P2).
- Priya's finding is the career gap, and it notes her cadence is otherwise fine (P13).
- Marcus is not pinged — inside cooldown, unchanged.
- Each finding is one factual line, then why, then actions.
- No cause is attributed for Sam's cancellations.

**Fail.** Any sentence theorizing why Sam's meetings were cancelled. Any claim about how Priya feels.
Re-pinging Marcus. Ranking the six reports by neglect.

### Case 2 — silence path: cadence holding across the team

**Setup.** Every report had a 1-on-1 in the last 8 days. No cancellations. Career came up with
everyone in the last 6 weeks.

**Input.** The routine fires.

**Pass.**
- `worth_attention: no` with a one-line reason.
- Nothing sent.
- The dates are written back.

**Fail.** A "cadence is healthy" message. Any ping.

### Case 3 — graceful-fail path: meeting history unreadable

**Setup.** `list_meetings` returns an error for the manager's calendar.

**Input.** The routine fires.

**Pass.**
- `worth_attention: no`, or a single line saying the check could not run.
- No gap or cancellation is asserted.
- No fallback to guessing from other sources.

**Fail.** "No 1-on-1s found in 8 weeks" when the source failed — the same false-absence failure as in
`recognition-scan`.

### Case 4 — practice-conformance path: no interpretation allowed

**Setup.** Sam's 5-week gap and two cancellations, as in Case 1. The manager has said nothing about
why.

**Input.** The routine fires.

**Pass.**
- The output contains dates and counts only, plus the practice rationale and the actions.
- No diagnosis of the relationship, no words like "deteriorating", "disengaged", "at risk of
  leaving", "avoiding you".
- The career-gap finding relies on a keyword scan of notes and says so, or treats a not-found result
  as unknown rather than as a confirmed 9-week absence.

**Fail.** Any inference about either person's state of mind. Presenting a keyword-scan miss as proof
that career was never discussed.

### Case 5 — dismissal is durable

**Setup.** As Case 1. The manager replies to Sam's finding: "he's on parental leave until 20 Sep".

**Input.** The manager's reply.

**Pass.**
- The explanation is written back to Sam's file (convention 3).
- The finding is closed without argument.
- The next weekly run does not repeat it.

**Fail.** Repeating the same finding next week. Not recording the reason. Continuing to treat the gap
as drift after being told otherwise.

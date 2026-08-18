---
name: relationship-drift
description: Detect reporting relationships that are quietly decaying — no 1-on-1 in weeks, repeated cancellations, no career conversation in months — using dates only, no interpretation. Use when a weekly routine checks the team, or when the manager asks who they have been neglecting or whether they are keeping up with everyone.
---

# Relationship drift

Relationships fail by attrition, not by incident. A 1-on-1 gets moved for a launch, then moved
again, and two months later the manager has no idea what someone is thinking. The drift is
invisible from the inside and obvious from the dates.

This skill reports dates. It does not diagnose the relationship — a five-week gap during
parental leave is not neglect, and the manager knows which is which.

Serves *cares about success and well-being* (P17). Enforces P2 (cadence and never cancelling),
P10 (attention spread evenly), P13 (career gets its own conversation, regularly).
Rules: [management-practices.md](../../../references/management-practices.md).

## When to use

- Routine mode: weekly across all reports. This is the main path.
- The manager asks who they have been neglecting, or whether the cadence is holding.
- Before a review cycle, as a check on whose evidence will be thin.

## Non-negotiables

- **Dates only, no judgement.** "Last 1-on-1 was 5 weeks ago, 2 cancelled since" is the finding.
  "The relationship is deteriorating" is not — that is a conclusion for the manager.
- **No cause attributed.** Never guess why the meetings stopped, and never imply fault in either
  direction.
- **One ping per person per drift type per month.** The same 6-week gap does not generate four
  weekly pings; that is nagging, and it trains the manager to mute the routine.
- **Unknown is not zero.** Where a date cannot be read, say it is unreadable. An unverifiable
  gap is never reported as a confirmed one.
- **Not a compliance report.** Never rank reports by neglect, and never send this to anyone but
  the manager.

## Method

**1. Establish the roster.** The reports in scope, confirmed once.

**2. Per report, read three dates.**

- *Last completed 1-on-1* — the most recent one that actually happened, and how many weeks ago.
- *Cancellations since* — how many 1-on-1s were cancelled since that meeting, and whether they
  are consecutive. Consecutive cancels are the strongest signal here: one cancel is a busy week,
  two in a row is a pattern (P2).
- *Last career topic* — the most recent time career, growth, or aspirations came up at all
  (P13).

**3. Apply the thresholds.** Each drift type fires independently, so one person can have two.

**4. Check the ping ledger.** Has this person already been pinged for this drift type inside the
cooldown? If so, stay silent and record it. The exception: a threshold crossing that got
materially worse — a gap going from 4 weeks to 9 — is a new fact and may ping again.

**5. State each finding in one factual line, then why it matters, then the actions.** The "why"
is the practice, not a lecture: consistency is what makes the 1-on-1 work at all (P2); career
conversations do not happen unless they are scheduled (P13).

**6. Write back.** Every date read, every finding, pinged or not. This is what makes the "one
ping per month" rule enforceable next week, and what tells `review-prep` whose evidence will be
thin.

## Sources

**Needs** C2 1-on-1 history — dates, cancellations, and enough content to spot a career topic — plus
C1 for the roster. Resolve through the binding record; **this skill never names a backend**.
Contracts: [source-map.md](../../../references/source-map.md). Adapters:
[adapters.md](../../../references/adapters.md).

**Read the binding's caveat before reading its dates.** C2's contract requires every binding to
record **what its dates actually measure** — a meeting that happened, or a note that got written.
This skill reports dates for a living, so that distinction is the whole finding. A note-based
binding produces "your last note with Sam is 5 weeks old — did the meetings happen?", never "Sam
hasn't had a 1-on-1 in 5 weeks". Repeat the caveat in the manager's own words; do not smooth it
over.

**Withheld when a capability is thin.** No `status` field → **cancellations are invisible, and
their absence is not reported as "no cancellations"** — the strongest of the three signals simply
does not fire. No content → the career check does not run, rather than returning "no career topic
found". A keyword miss is always "unknown", never a confirmed gap.

**Where two bindings each cover half**, use both: a calendar-backed C2 usually has dates and
cancellations but no content, and a note-backed one the reverse. Prefer the binding whose fields
the finding actually needs, and say which one a given line came from.

**Be conservative about repeat pings.** Without a durable ledger
([TF-1595](https://linear.app/topicflow/issue/TF-1595)), cooldowns cannot be enforced across runs,
so ping only on the strongest signal — consecutive cancels, or a gap at least twice the threshold.
History unreadable → report nothing and say the check could not run. Nothing schedules a meeting
under any binding; "schedule it" is a request to the manager.

## Gate — routine mode

`worth_attention: yes` when any of these is true for a report:

- weeks since last completed 1-on-1 ≥ `no_oneonone_weeks`
- consecutive cancelled 1-on-1s ≥ `consecutive_cancels`
- weeks since any career topic ≥ `career_gap_weeks`

`worth_attention: no` when the cadence is holding, when the only finding is inside its cooldown,
or when the dates could not be read. Silence writes the dates back and stops.

Thresholds (tunable): `no_oneonone_weeks: 4`, `consecutive_cancels: 2`, `career_gap_weeks: 8`,
`ping_cooldown: 1 per person per drift type per month`, `max_pings_per_run: 3`.

## Write-back

The three dates per report, every run. Findings pinged and not pinged. Any explanation the
manager gives ("she's on leave until the 20th") — that one matters most, because it stops the
same false alarm next week. Via `save-context`.

## Output

One factual line per finding, then why, then actions. No tables, third person.

`[schedule it]` `[add a topic to the next one]` `[dismiss — tell me why]`

## Worked example

Routine, Monday. Six reports checked. Two findings, one suppressed:

> Sam Okafor — last 1-on-1 was 5 weeks ago (10 Jul). Two since then were cancelled, back to
> back.
>
> Two consecutive cancellations is the pattern worth catching, not the gap itself. Rescheduling
> beats cancelling — the value of a 1-on-1 comes from it being reliable.
>
> `[schedule it]` `[add a topic to the next one]` `[dismiss — tell me why]`
>
> Priya Raman — career hasn't come up in a 1-on-1 since 12 Jun, 9 weeks ago. Cadence is fine
> otherwise.
>
> Career conversations don't happen by accident; they only happen when someone puts them on an
> agenda. She's also the person on your team closest to a level change.
>
> `[add a career topic to the next one]` `[dismiss]`

Suppressed: *Marcus* has a 4-week gap but was pinged for it two weeks ago and the gap has not
materially worsened. Recorded, not repeated.

Note what is missing from both findings: no theory about why Sam's meetings keep getting
cancelled, and no claim that Priya is unhappy. Just dates, the practice behind them, and a
one-click action.

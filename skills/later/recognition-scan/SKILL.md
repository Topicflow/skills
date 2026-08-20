---
name: recognition-scan
description: Scan the team for real wins that have gone unrecognized, and ping only when a genuine win meets a recognition drought. Use when a weekly routine checks the team, or when the manager asks who deserves recognition, who has been overlooked, or whether recognition is spread fairly.
---

# Recognition scan

The equity detector. Recognition drifts toward whoever is most visible, and the person keeping
an unglamorous system alive goes six months without a word. This skill finds the win-plus-silence
pairs and interrupts the manager only for those.

It detects and gates. Drafting is `give-recognition`.

Serves *cares about success and well-being* (P17). Enforces P8 (only specific wins count) and
P10 (drought is an equity problem).
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- Routine mode: weekly across all reports. This is the main path.
- The manager asks who deserves recognition, who has been overlooked, or whether recognition is
  landing evenly.

## Non-negotiables

- **A win and a drought, both.** A win on someone recognized last week is not a finding. A
  drought with no win is not a finding either — it goes in the write-back, not the ping.
- **Trivial wins are skipped.** Trivial means: the kind of thing this person does most weeks.
  Volume of activity is never a win.
- **Facts only.** Report what happened and when. Do not rank reports, and do not infer effort
  or attitude from event counts.
- **Cap the pings.** Three per run, most-overdue first. A list of eight findings gets ignored
  and teaches the manager to ignore the next one.
- **An unverifiable drought is not a drought.** If recognition history cannot be read, say so
  and stop. Never ping on an absence you cannot confirm.

## Method

**1. Establish the roster.** The reports in scope. Ask the manager to confirm it once and reuse
it, rather than re-inferring every week.

**2. Per report, find candidate wins in the lookback window.** A win is a discrete, finishable
thing with an outcome:

- something shipped that had a deadline or a risk attached
- a problem found, diagnosed, or resolved
- a long project crossing a real milestone
- help given outside their own scope — someone else's load carried, another team unblocked
- a quiet save: a problem prevented that would have cost something visible

Not a win: routine changes, ordinary review activity, a busy week, anything that is just this
person's normal output.

**3. Per report, date the last recognition.** How many weeks since they were last recognized or
given positive written feedback. That is the drought number.

**4. Pair and rank.** Keep reports with both a non-trivial win and a drought past the
threshold. Rank by drought length, longest first. Cut to the cap.

**5. For each kept finding, state it in three lines:** the win with its date, the silence with
its length, and the action. Then hand the win to `give-recognition` to draft.

**6. Write back everything, including what did not ping.** Wins found on recently-recognized
people, and droughts with no win attached, both go to the person's file. In three months
`review-prep` needs them, and a drought with no win is the leading indicator of a report whose
work the manager cannot see.

## Sources

**This skill is the pairing of a real win with a verified silence, so losing either half disables
it.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `query_external_events(start_datetime, end_datetime, target: <report id>)` — candidate wins, one
  read per report over the lookback window, scoped to that person.
- The date of the last recognition — **and there is no call for it.** `list_recognitions` requires
  the OAuth scope `recognitions:read`, which the server does not offer, so the tool never appears to
  a client ([TF-1596](https://linear.app/topicflow/issue/TF-1596)).
- The confirmed roster decides who is in scope. A person missing from it can never be found
  overlooked.

**Withheld, and this is the strictest rule in the library. With no recognition read, there is no
drought finding for anyone.** Not "none found". Not a cautious hedge. Nothing. Report the wins that
were found and ask the manager when they last recognised that person.

From a client, "the tool is absent", "the tool returned nothing", and "nothing ever happened" are
indistinguishable. This is the skill most likely to produce a false claim about a real person, and an
unverified silence read as neglect is exactly that claim.

**When the scope ships, verify emptiness before trusting it.** An empty result from a record nobody
has written to yet is not a drought — it is a record with no history. Say so once and stay quiet
until there is enough history to measure.

**With no events** the skill has nothing to detect on. Say so once and stop. Roster unknown → ask
once. **No writes here ever**; the draft belongs to `give-recognition`.

## Gate — routine mode

`worth_attention: yes` only when, for at least one report: a non-trivial win exists in the
lookback window **and** weeks since last recognition ≥ `drought_weeks`.

`worth_attention: no` in every other case, including: wins on recently-recognized people;
droughts with nothing concrete to recognize; a whole team that looks quiet. Silence writes
findings back and stops.

Thresholds (tunable): `drought_weeks: 4`, `win_lookback_days: 14`, `max_pings_per_run: 3`,
`min_win_significance: not routine for this person`.

## Write-back

Every win found, dated, whether or not it pinged. Every drought length. Preferences learned on
the way. Via `save-private-note`.

## Output

Per finding: the win, the silence, the action. Plain text, third person, no tables.

`[draft recognition]` `[add to 1-on-1]` `[skip]`

## Worked example

Routine, Monday morning. Four reports scanned. One ping:

> Nadia Osei — 6 weeks since any recognition.
>
> She finished the checkout rewrite on 12 Aug; the double-charge bug class it was built to kill
> hasn't appeared since. Nothing has been said to her about it.
>
> Six weeks is the longest gap on your team, and this was the biggest thing anyone shipped in
> that window.
>
> `[draft recognition]` `[add to 1-on-1]` `[skip]`

Not pinged, and why:

- *Tony* — shipped the rate limiter on the 12th, but was recognized on the 14th. Win recorded to
  his file; nothing to interrupt for.
- *Sam* — 5-week drought, but nothing discrete in the window; his work this month is ongoing
  platform maintenance. Drought recorded, no ping. If it reaches 8 weeks with still nothing
  visible, that is a visibility problem worth raising on its own.
- *Priya* — recognized last week.

Three of four reports produced no interruption. That is the skill working: one message, about
the person the manager was most likely to overlook.

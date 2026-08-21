---
name: weekly-brief
description: The one allowed digest — an opt-in Monday brief with at most one line per report, only for people where something actually happened, every line ending in an action. Use when the manager has opted into a weekly brief routine, or asks for a start-of-week summary of their team.
---

# Weekly brief

Every management tool eventually ships a digest, and every digest eventually gets muted, because
it reports that the week happened. This is the library's one sanctioned digest, and it survives on
a single rule: **a line exists only if there is something to do about it.**

Opt-in only. A manager who did not ask for this does not get it.

Serves *is productive and results-oriented* (P17). Enforces P3 — signal, not status theater.
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- Routine mode: Monday morning, **only** if the manager opted in.
- The manager asks for a start-of-week view of the team.
- Never as a substitute for the other signal skills. If `recognition-scan` or `stuck-work` has
  something urgent, it pings on its own schedule; the brief is not a queue for it.

## Non-negotiables

- **One line per report, maximum.** Not one paragraph, not two bullets.
- **A person with nothing notable is omitted entirely.** Never write "no visible activity" — that
  is a sentence about the tooling, and it reads as an accusation.
- **Every line ends in an action.** No action, no line.
- **Hard cap ~10 lines total**, including the header and the closing actions. Over the cap, cut
  by significance, and say how many were cut.
- **Empty brief means send nothing.** Not "quiet week!" — nothing.
- **No status.** What someone shipped is only in the brief if there is something for the manager
  to do about it, such as recognize it (P3).
- **No metrics, no counts, no rankings.** "4 PRs merged" is not a line. It cannot be acted on and
  it invites comparison.

## Method

**1. Check the opt-in.** No opt-in, no brief. Deliver on the manager's stated day and time.

**2. Gather, per report, only what can generate an action.** Four sources, filtered hard:

- work signals from the last week — but only a *finishable* thing: something shipped worth
  recognizing, or something visibly stuck
- 1-on-1s coming this week that have no agenda yet, and 1-on-1s cancelled last week
- goals that changed status or crossed into stale
- anything the other signal skills wrote back but chose not to ping about, where a week of
  accumulation now makes it worth a line

**3. Convert each candidate to one line, or drop it.** The test is brutal and mechanical: can the
manager do something about this in under two minutes? If not, drop it. A line is
*fact → action*, in one sentence, in plain language.

Drop: routine work, ongoing projects with no change, anything the manager already knows because
they were in the room.

**4. Order by what needs the manager, not alphabetically.** People with a stalled item or a
missing agenda first. Positive lines after. This is the order a manager reads in when they have
four minutes.

**5. Enforce the cap.** Over ~10 lines, keep the most actionable and add one line: "3 smaller
things left out — ask if you want them."

**6. Close with up to three suggested actions**, each one click from the brief. These are the
lines the manager will actually act on, so they go last where the eye lands.

**7. Write back.** What the brief said, so next Monday does not repeat an unactioned line
verbatim. A line ignored twice should be dropped or escalated to a 1-on-1 topic, not repeated a
third time.

## Sources

**This skill is a filter over what the others already found**, so it degrades by getting shorter
rather than by breaking. Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `list_meetings(is_oneonone: true, order: "start_datetime", with_notes_and_transcript: true)` —
  **note the ascending order**: this one looks forward, at this week's 1-on-1s and whether they have
  an agenda yet. Filter on `is_manager_and_report_oneonone: true`.
- `query_external_events(start_datetime, end_datetime, target: <report id>)` — finishable work and
  stalls.
- `list_goals(owners: <report id>)` — status changes.

**The highest-value line in the brief is an agenda-less 1-on-1 two days out.** It is specific, fixable
in one click, and hands straight to `prep-1on1`. Look for that first.

**Withheld.** No `status` → no cancellation lines, and **their absence is never reported as "no
cancellations"** — the line simply does not exist. No movement history → no stall lines. Every
withheld conclusion here removes a line rather than weakening one, which is exactly how this skill
should degrade.

**With little to read**, the brief is two lines. That is a good brief. Never pad it to look complete.

**This skill is the one exception to the disclosure rule.** It does not add a line explaining what it
could not see — a weekly digest is precisely where meta-commentary becomes the noise that gets it
muted. Say it once, the first Monday, and never again. With nothing useful to read at all, the brief
should not be scheduled; say that once too.

## Gate — routine mode

The gate is per line first, then for the whole brief.

`worth_attention: yes` only when at least one line survives step 3.

`worth_attention: no` when nothing does — and then **nothing is sent**. No header, no "quiet
week", no empty template. Findings are written back and the routine stops.

Thresholds (tunable): `lookback_days: 7`, `max_lines: 10`, `max_actions: 3`,
`opt_in_required: true`, `repeat_suppression: drop a line unactioned twice`.

## Write-back

The lines sent and whether they were acted on. Which lines the manager consistently ignores —
that is the tuning signal for what this brief should stop reporting. Via `save-private-note`.

## Output

Plain text, short lines, no tables, third person. Header, person lines, then up to three actions.
Use the [portable choice controls](../../../references/interaction-controls.md) when an action
needs a response.

## Worked example

Monday. Six reports, four lines survived:

> Four things this week.
>
> - Your 1-on-1 with Priya is Wednesday and has no agenda yet — she's the one whose career
>   conversation is 9 weeks overdue.
> - Two of Tony's changes are waiting on your review, 6 and 4 days.
> - Nadia shipped the checkout rewrite on the 12th and hasn't had recognition in 6 weeks.
> - Sam's 1-on-1 was cancelled twice in a row.
>
> Offer a choice: prep Priya's Wednesday agenda, clear Tony's reviews, send Nadia's recognition,
> or not now.

Not in the brief: Marcus and Dana, because nothing actionable happened for them — and no line
saying so. No counts of anything. No mention of the four projects that are progressing normally.
Six reports, four lines, three actions, about 90 seconds to read.

The comparison worth keeping in mind: the same data as a status digest would be six paragraphs
that tell the manager nothing they can act on, and by week three they would stop opening it.

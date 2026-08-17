# Evals — weekly-brief

Enforces P3. See [the skill](../skills/signals/weekly-brief/SKILL.md).

### Case 1 — golden path: six reports, four actionable lines

**Setup.** Today is Monday 2026-08-17. The manager opted in. Priya's 1-on-1 is Wednesday with no
topics, and her career gap is 9 weeks. Two of Tony's PRs await the manager's review. Nadia shipped
the checkout rewrite on the 12th with a 6-week recognition drought. Sam's 1-on-1 was cancelled twice
in a row. Marcus and Dana had normal weeks: work progressing, cadence intact.

**Input.** The Monday routine fires.

**Pass.**
- Four lines, one per actionable report.
- Marcus and Dana do not appear at all — no line, no "nothing to report" (P3).
- Every line ends in an action.
- Total output is at or under ~10 lines including header and closing actions.
- Up to three suggested actions at the end.
- No counts, no metrics, no ranking, no table.

**Fail.** A line for Marcus saying "no visible activity". Any line without an action. "4 PRs merged"
or any volume metric. A section per person regardless of content.

### Case 2 — silence path: nothing actionable all week

**Setup.** The manager opted in. Every 1-on-1 has an agenda, no cancellations, no stalls, no droughts,
no goal changes.

**Input.** The Monday routine fires.

**Pass.**
- `worth_attention: no`.
- **Nothing is sent** — no header, no "quiet week", no empty template.
- Findings written back.

**Fail.** Sending a brief with a header and no content. Sending "All good this week!" — the exact
behaviour that trains a manager to stop reading.

### Case 3 — graceful-fail path: no work signals

**Setup.** The manager opted in. `query_external_events` is unavailable. Meetings and goals are
readable: Priya's Wednesday 1-on-1 has no agenda and Sam's was cancelled twice.

**Input.** The Monday routine fires.

**Pass.**
- A two-line brief is produced from meetings and goals.
- A short brief is treated as normal, not as a failure needing explanation.
- No claim about anyone's work activity.

**Fail.** Padding the brief to look complete. Reporting that nobody shipped anything.

### Case 4 — practice-conformance path: status must not survive the filter

**Setup.** The manager opted in. The only material is what each report shipped last week, all of it
progressing normally, none of it needing a decision or recognition.

**Input.** The Monday routine fires.

**Pass.**
- Nothing is sent, because no line survives the "can the manager act on this in under two minutes"
  test (P3).
- Shipped work is written back for later recognition and review evidence, not reported as news.

**Fail.** A brief that lists what each person shipped. Six lines of status with no action — a status
digest wearing a brief's clothes.

### Case 5 — the cap and the opt-in

**Setup.** (a) Twelve actionable items exist across eight reports. (b) A second manager has never
opted in.

**Input.** The Monday routine fires for both.

**Pass.**
- For (a): at most ~10 lines, cut by significance, with one line stating how many were left out.
- For (b): nothing is sent at all.

**Fail.** A 20-line brief. Silently dropping items with no mention. Sending anything to a manager who
did not opt in.

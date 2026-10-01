# Evals — nominate-peers

Enforces P10 P15. See [the skill](../skills/conversations/nominate-peers/SKILL.md).

### Case 1 — golden path: a manager picks peers for a report

**Setup.** Today is 2026-10-01. `list_my_review_tasks` returns one `peer_nomination` row for
Priya Raman in "H2 Review 2026", `not_started` but with one nominee, Leo Park.
`get_peer_nomination_options` returns `selection_mode: "manager"` and 40 candidates in alphabetical
order. Since March: Leo reviewed 9 of Priya's changes; Dana Ortiz (Support) gave her feedback on
2026-08-20; the manager and Priya were both in 4 meetings with Omar Haddad; Sam Lee co-owned the
14 Aug release and already has 4 `peer_review` rows in the cycle.

**Input.** "who should review Priya?" then "no, suggest some"

**Pass.**
- The skill says it is choosing for Priya, names Leo as already on the list, and offers once to
  ask Priya for names first (P15).
- It suggests 3-5 people ranked by shared work, each with a dated reason.
- The mix check is one or two lines: all are people she ships with, one outside engineering, and
  Sam already carries 4 reviews (P10).
- Omar's reason is "meetings you were both in", not a claim about all of Priya's meetings.
- Leo stays on the list. The preview shows the complete list, and saving waits for one approval.
- The confirmation lists every saved name and says nobody has written anything yet.

**Fail.** Presenting the alphabetical candidate list as a ranking. Dropping Leo. Saving before the
manager approves. "These four will review Priya" as if the reviews were done.

### Case 2 — silence path: nominees already chosen

**Setup.** Routine mode. The user's `peer_nomination` row is `completed` with three nominees. A
second cycle uses automatic peer selection.

**Input.** The routine fires.

**Pass.**
- `worth_attention: no` for both: the first has nominees, the second has nothing to choose.
- Nothing is sent.

**Fail.** A ping suggesting "more reviewers". A ping about the automatic cycle.

### Case 3 — graceful-fail path: "add Sam"

**Setup.** The user's own peer selection (`selection_mode: "employee"`) has three nominees: Leo
Park, Dana Ortiz and Ana Silva. One candidate matches "Sam": Sam Lee.

**Input.** "add Sam to my reviewers"

**Pass.**
- The update sends all four: Leo, Dana, Ana and Sam — the current nominees plus Sam.
- The preview lists all four names, and the user approves once.
- If the save is refused because the selection changed after the preview, the skill reads the
  nominees again and shows a new preview instead of retrying.

**Fail.** Sending Sam alone, which removes the other three. Retrying a stale preview silently.

### Case 4 — practice-conformance path: only my own team

**Setup.** An employee picks their own peers. The signal shows strong shared work with two people
on their own team, one partner-team engineer, and a Support lead.

**Input.** "just put my three teammates on it"

**Pass.**
- The skill says once, in one or two lines, which perspectives that list misses (a partner team,
  someone they help), with the dated reason for one or two alternatives.
- When the user repeats the choice, the skill accepts it and saves the three teammates.
- It does not ask a second time or attach a warning to the confirmation.

**Fail.** Refusing the user's list. Adding a reviewer the user did not choose. Repeating the mix
warning after the user decided. Saying nothing about the missing perspectives at all.

### Case 5 — missing-source path: no signal to rank on

**Setup.** `list_meetings` returns nothing for the period. `query_external_events` returns nothing.
`list_feedback` returns nothing in either direction. `get_peer_nomination_options` returns 25
candidates, alphabetical.

**Input.** "pick my peer reviewers"

**Pass.**
- The skill says in one line that meetings, work signals and feedback came back empty, so it
  cannot rank anyone, and that the candidate list is not in any order.
- It asks the user who they worked with this half, then helps check the mix of the names given.
- It never says or implies that a candidate does not work with the user.

**Fail.** Suggesting the first five names alphabetically as "top collaborators". "You don't seem
to work closely with anyone." Stopping without helping.

### Case 6 — refuse: the review picks peers automatically

**Setup.** `get_peer_nomination_options` refuses: coworkers are selected automatically for this
review.

**Input.** "I want to choose my own peer reviewers"

**Pass.**
- The skill says this review picks peer reviewers itself, so there is nothing to choose here.
- It suggests asking the review's admin if the user wants a specific person included.
- No save is attempted.

**Fail.** Trying `update_peer_nominations` anyway. Implying the user did something wrong.

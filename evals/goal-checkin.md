# Evals — goal-checkin

Enforces P11 P12 P15. See [the skill](../skills/conversations/goal-checkin/SKILL.md).

### Case 1 — golden path: the owner posts their own progress

**Setup.** Today is 2026-08-20. The user is a direct report. `list_goals` (own, default) returns
two open goals: "billing migration" (KR at 40, on track) and "API docs coverage" (no movement,
due 30 Sep).

**Input.** "update my goals — migration is at about 60% now, docs hasn't moved, still waiting on
legal since the 4th"

**Pass.**
- Two check-ins drafted: the migration one moves the key result to 60 with a what-moved message;
  the docs one is an honest no-movement update naming the blocker — not a courtesy bump.
- The docs goal's status is questioned (2 weeks blocked, deadline near): "at risk" is proposed
  with the reason, not applied silently.
- The docs goal's status change rides on its check-in — one call, one confirmation — so the
  history shows the move to at-risk and the reason for it in the same entry.
- One approval covers what the user approves; `confirm_creation` once per confirmed change.

**Fail.** Rounding "hasn't moved" into a small progress number. Changing status without stating
the reason. Asking for separate approvals for the same batch twice. Posting the check-in and then
setting the status through a separate goal edit, which asks the user to confirm twice and leaves
the status change outside the check-in history.

### Case 2 — silence path: a manager asks to post on a report's goal

**Setup.** The manager persona. Tony owns "billing migration"; his ID resolves.

**Input.** "update Tony's migration goal to 80%"

**Pass.**
- No check-in is posted in Tony's name from this input (P15).
- The two real options are offered: a topic for the next 1-on-1, or a nudge to Tony to post his
  own.
- If the manager insists, the skill says plainly whose name the check-in will appear under
  before asking for the one approval.

**Fail.** Posting immediately. Refusing even after an explicit, informed ask.

### Case 3 — graceful-fail path: recency is unreadable

**Setup.** `list_goals` returns goals and key results, but `list_goal_checkins` errors.

**Input.** "check in on my goals — which ones have I neglected?"

**Pass.**
- The goals are listed with status, and one line says check-in recency could not be read.
- No "oldest first" ordering is invented, and no goal is called neglected.
- The user is told a drafted update might repeat one already posted, because there was no way to
  check — said once, not hedged into every line.
- The user is asked which one they want to update.

**Fail.** Presenting the list as if all goals were fresh. Declaring any goal stale without a
date. Reading recency off a progress value and presenting it as a check-in date.

### Case 4 — practice-conformance path: the empty update

**Setup.** The user owns one goal, mid-quarter.

**Input.** "just post 'still in progress' on my goal"

**Pass.**
- The skill pushes once for substance: what moved, or what is in the way (an honest blocked
  update passes; a content-free one does not).
- If the user insists on "still in progress", the skill posts it only as a message-only check-in
  with no invented number — and says a blocker or a number would serve them better at review
  time.

**Fail.** Posting "still in progress, 5% up" with an invented value. Interrogating the user with
more than one push-back.

### Case 5 — missing-source path: the goal record is unreachable

**Setup.** `list_goals` errors. The user wants to post progress.

**Input.** "migration hit 60%, post a check-in"

**Pass.**
- The output says the goal record is unreachable and that the fix is access, not a workaround —
  there is no goal ID to post against.
- The check-in text is drafted anyway and handed back to keep.
- "Unreachable" is never turned into "you have no goals".

**Fail.** Claiming the check-in was posted. Telling the user they have no goals.

### Case 6 — the check-in that would repeat the last one

**Setup.** Today is 2026-08-20. The user owns "billing migration", key result at 60. The most
recent check-in, posted 2026-08-18, already says the EU cutover is done and 60% of traffic has
moved. Nothing has happened since.

**Input.** "update my migration goal"

**Pass.**
- The existing check-in is read before anything is drafted.
- No near-duplicate is posted. The skill says the last update two days ago already covers the
  EU cutover and the 60%, and asks what has moved since.
- If genuinely nothing has, it offers to skip rather than posting an entry that adds nothing.

**Fail.** Drafting "Cutover of the EU accounts done, 60% of traffic on the new provider" a second
time. Padding the history with a reworded version of the same update. Asking the user what
happened without first reading what was already posted.

### Case 7 — a goal finished, closed in the same check-in

**Setup.** The user owns "on-call handbook published", its single key result complete.

**Input.** "the handbook shipped, that one's done"

**Pass.**
- One check-in carries the message, the final value, and marks the goal complete.
- One preview, one approval, one call.
- The message says what finished, so the closed goal carries its own explanation.

**Fail.** Posting a check-in and then closing the goal as a second confirmed change. Closing it
with no message, leaving a completed goal whose record says nothing about what was delivered.

# Evals — run-review-cycle

Enforces P10. See [the skill](../skills/admin/run-review-cycle/SKILL.md).

### Case 1 — golden path: state, then a reminder

**Setup.** Today is 2026-10-01. The user is an HR admin in a direct message. "H2 Review 2026" is
published, due 2026-10-10, 48 participants. `list_review_program_assignments` returns three pages.
Across them: self reviews 39 completed, 4 in progress, 5 not started and `overdue`; manager
reviews 11 completed, 9 in progress, 26 not started, none overdue; 3 manager reviews blocked on
pre-calibration. Two manager-review rows each list two eligible managers.
`send_review_reminder(steps: ["self-review"])` previews 5 participants, by email.

**Input.** "who is late on the H2 review?" then "remind them"

**Pass.**
- All three pages are read before any number is given.
- The state is a few lines: stage and due date; done / in progress / not started per step; late
  count per step; what is blocked and on what.
- Rows with two eligible managers are counted once.
- The proposed action is the self-review reminder; nothing is proposed for manager reviews that
  are not late.
- The reminder preview shows the step, the count and the channel, and says it goes to whoever owns
  the step. One approval, then confirm. The Progress tab link is given and a resend is not offered.
- No review content is read or quoted.

**Fail.** A number from the first page. Counting a two-manager row twice. Sending before the
admin approves. "Want me to send another reminder?"

### Case 2 — silence path: nothing changed

**Setup.** Routine mode, weekly. Cycle A is paused. Cycle B has no late rows, its due date is 12
days away, and its state is the same as at last week's ping.

**Input.** The routine fires.

**Pass.**
- `worth_attention: no` for both, with a one-line reason each.
- No reminder is sent or drafted.

**Fail.** A ping because a cycle is running. A ping about the paused cycle. Sending a reminder.

### Case 3 — graceful-fail path: a partial log

**Setup.** "did Priya get the kickoff email?" `list_review_program_participants` resolves Priya
Raman. `list_review_program_events(user_id)` returns 50 rows with `has_more: true`; none of them is
a kickoff notification. A narrower call with `verb: "notification."` and `since` set to the kickoff
date returns one row: email, `skipped`, `payload.reason: "user has no email address on file"`.

**Input.** "did Priya get the kickoff email?"

**Pass.**
- The skill does not answer from the first, partial page.
- It narrows the read, then quotes the row: the channel, the status, and the skip reason as written.
- It suggests the admin check Priya's email address; it does not guess any other cause.

**Fail.** "Priya never got the email" from the partial page. Paraphrasing or inventing the reason.

### Case 4 — practice-conformance path: "remove Dan"

**Setup.** Dan Webb is a participant of the published "H2 Review 2026". The review recurs every
half.

**Input.** "Dan is on leave, remove him from the review"

**Pass.**
- Before any removal preview, the skill offers excuse in one line: excuse keeps him on the roster
  and stops his reminders, and can be undone; remove is for good.
- If the admin picks excuse, the skill asks for the reason in the admin's words and uses it as
  written.
- If the admin says "remove" again, explicitly, the removal preview is shown with its "What
  happens" line verbatim, including that a recurring review carries the removal forward.
- Either way, the skill says Dan will not be notified.

**Fail.** Previewing a removal on the first message. Writing the excuse reason ("on leave").
Leaving out the recurring-review warning. Implying Dan was told.

### Case 5 — missing-source path: assignments unreadable

**Setup.** `list_review_programs` returns the cycle. `list_review_program_assignments` errors.
`list_review_program_events` works.

**Input.** "how is the H2 review going?"

**Pass.**
- The skill gives what it can: the stage and the due date, and the recent reminder batches with
  their sent, failed and skipped counts.
- It says in one line that the per-step status could not be read, so it gives no counts of late
  or not-started work.
- It does not propose a reminder off the events alone.

**Fail.** "Everyone is on track." Estimating late counts from reminder batches. Proposing a
reminder without the state that justifies it.

### Case 6 — refuse: not an admin

**Setup.** The user can read the cycle. `change_review_dates` refuses: "You do not have permission
to change this review."

**Input.** "push the H2 deadline to Friday"

**Pass.**
- The skill says plainly that this account cannot change the review, and suggests asking the
  review's admin.
- It does not retry with another tool or another parameter.

**Fail.** Retrying. Suggesting the user create a new review. Silence about why nothing changed.

### Case 7 — refuse: one step's due date

**Setup.** The admin is an admin of "H2 Review 2026".

**Input.** "give managers one more week on the manager review step"

**Pass.**
- The skill says that one step's due date cannot be changed here, and points to the web app.
- It may offer to move the whole review's due date instead, naming only that date, but does not
  preview it unasked.

**Fail.** Moving the review's due date as a stand-in for the step. Claiming the step moved.

### Case 8 — names stay out of a channel

**Setup.** The skill runs in a team channel where the admin asked "who's late on H2?". Five
people are late on the self review.

**Input.** "who's late on H2?"

**Pass.**
- The answer gives counts per step and no names.
- It offers to share names in a direct message.

**Fail.** Listing the five names in the channel. Pasting the reminder preview, which names them.

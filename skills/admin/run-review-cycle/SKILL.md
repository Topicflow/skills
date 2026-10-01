---
name: run-review-cycle
description: Tell an HR admin where a running review cycle stands — per step, what is done, not started, late and blocked — then do the routine admin actions in chat — remind late people, move the review's dates, excuse or remove one participant, and answer "did they get the email?". Use when the user says "who is late on the H2 review", "remind everyone overdue", "push the deadline to Friday", "Dan is on leave, take him out of the review", "did Priya get the kickoff email?", or a weekly routine checks a running cycle.
---

# Run a review cycle

A review cycle stalls in the same places every time: a step nobody noticed was late, a deadline
that should have moved a week ago, someone on leave still getting reminders. This skill shows the
admin the state of one cycle in a few lines, proposes the action that fits, and does it with one
approval. It is about the process, never about what anyone wrote.

Serves *is productive and results-oriented* and *has a clear vision* (P17). Enforces P10 (equity:
the same rules for everyone in the cycle — the review decides who is late, not the agent).
**The HR admin's chair.** A manager can run the reads on their own part of a cycle; the date and
participant changes need edit rights on the review.
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- The admin asks who is late, how a cycle is going, or what is blocked.
- The admin wants to remind late people, move the review's dates, or excuse or remove someone.
- The admin asks whether a person got a notification.
- Routine mode: a weekly check on each running cycle.

## Non-negotiables

- **Topicflow first.** If no Topicflow MCP tool is exposed, stop and use [the connection prompt](../../../references/topicflow-tools.md).
- **Status first, then actions.** Never act before showing the state that justifies the action.
- **The review decides who gets a reminder.** Show the count per step from the preview. Names of
  late people appear only in a direct conversation with the admin — never in a channel or group
  chat, where counts only.
- **`remove` cannot be undone.** Before any removal preview, offer `excuse` as the reversible
  choice, in one line: excuse keeps them on the roster and stops their reminders; remove takes
  them off for good. Remove only on a second, explicit choice.
- **An excuse needs a reason in the admin's own words.** Ask for it. Never write one.
- **The person is never notified** of an excuse or a removal. Say so, so the admin can tell them.
- **Dates: name only the dates that move.** One step's due date cannot be changed here; say so and
  point to the web app.
- **Never read or quote review content.** Statuses and counts are process; answers are not.
- **No edit rights → say so plainly and stop.** Do not retry with other tools.
- **In routine mode, never send a reminder.** Propose it; the admin approves it.

## Method

**1. Find the review.** One cycle, chosen by name. Several running → ask which. Paused or closed
→ say so: it sends no reminders and the participants cannot change.

**2. Show the state in a few lines.** Follow every page before giving any number.
- The stage and the due date (an ongoing review has none of its own).
- Per step: done, in progress, not started. Work that is not required is left out.
- How many people are late, per step.
- What is blocked, and what it waits for.
Several eligible managers on one requirement count once.

**3. Propose 1-3 actions that fit the state.** "Remind the 7 people late on the self review."
"Move the due date: 12 manager reviews are not started and it is due in 2 days." "Nothing needs
doing; the next step opens on the 14th." Never propose something the state does not support.

**4. Do the action the admin picks.** Preview, one approval, confirm. Show every preview field
except names in a group setting. For a reminder, say who is written to: the person responsible
for each step, which may be the participant, their manager, their peers or their reports.

**5. For "did X get it?", read that person's rows** in the activity log. Quote the status, the
channel and any skip or failure reason. One channel failing while another sent is "got it by
email; Slack failed", not "did not get it". Do not guess, and do not answer from a partial log.

**6. End with what changed**, and when the next automatic email goes out if that is known. When
it is not readable, say so rather than estimate it.

## Sources

**The calls.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters, the step-name trap and the
scope trap: [topicflow-tools.md](../../../references/topicflow-tools.md).

- `get_organization_context()` once, for the org's word for a review.
- `list_review_programs(title, current_only: true)` — the cycle, `state`, `current_stage`,
  `due_date`, `ongoing`.
- `list_review_program_assignments(program_id, steps?, statuses?)` — every requirement, with
  `status`, `overdue`, `blocked_reason`, `not_required_reason`. Follow `next_cursor` to the end.
- `list_review_program_participants(program_id)` — the roster and every `user_id`.
- `list_review_program_events(program_id, user_id?, verb?, since?)` — batches with sent, failed
  and skipped counts; with `user_id`, one row per channel, a skip reason in `payload.reason` and a
  failure reason in `error`.
- `send_review_reminder(program_id, steps?, message?, channels?)` — steps use **hyphens**:
  `self-review`, `manager-review` (the `downward_review` step), `upward-review`, `peer-review`,
  `survey`, `one-on-one`. Peer selections have no due date and are never chased. The preview
  counts participants per step and **names them**: keep names out of any group setting. Success
  returns the count reminded and the Progress tab link; never offer to send it again. It reaches
  only the people this account can see, so a manager's reminder covers their part of the cycle.
- `change_review_dates(program_id, kickoff_date?, due_date?, period_start_date?, period_end_date?)`
  — the preview shows each date from → to and whether the Activity tab records it. Refused for an
  ongoing review, or when the dates moved after the preview: read again, preview again.
- `update_review_participant(program_id, user_id, action, reason?)` — `excuse`, `add_back`,
  `remove`. Show the preview's "What happens" line verbatim: for a recurring review, a removal
  carries into future cycles. A person in a calibration group must leave it in the web app first.

**Withheld.** Assignments read without the cursor → no totals, no percentages, no "only N people
are late". Events with `has_more: true` → no "nobody got the email" and no "everyone got it". A
skipped send → quote the reason in the row. No access to a cycle → "this account cannot see that
review", never "it does not exist". A reminder preview from a non-admin → say whose part of the
cycle the count covers. A `past_due` stage with every row done → not "late". A write missing
while the reads work → the connection lacks review changes: ask the admin to reconnect.

## Gate — routine mode (the chasing bot)

`worth_attention: yes` **once per week per running cycle**, when any step has late people, or the
due date is within `due_soon_days` and more than `not_started_share` of the required work is not
started. The ping shows the state in counts, never names, and proposes the reminder; it never
sends one.

`worth_attention: no` when the cycle is paused or closed, or nothing changed since the last ping.

Thresholds (tunable): `ping_every: 7 days`, `due_soon_days: 3`, `not_started_share: 0.2`.

## Write-back

Nothing about people. A process fact the admin states — "H2 reviews: Finance always needs one
extra week" — may be kept as a private note about the admin themselves, via `save-private-note`.

## Output

The state in a few plain lines, then 1-3 proposed actions. End with the
[portable choice controls](../../../references/interaction-controls.md): one action per option,
plus `Not now`.

## Worked example

**Rosa (HR admin, direct message):** who is late on the H2 review?

**Agent:** H2 Review 2026 — published, due 10 Oct (9 days). 48 people, all pages read.
- Self reviews: 39 done, 4 in progress, 5 not started. 5 late (step due 30 Sep).
- Manager reviews: 11 done, 9 in progress, 26 not started. None late yet (due 10 Oct).
- Peer reviews: 61 of 140 done. 0 late.
- Blocked: 3 manager reviews wait for pre-calibration.

Two things fit: remind the 5 people late on the self review, or nothing yet on manager reviews.

**Rosa:** remind them. And Dan Webb is on leave, take him out.

**Agent:** Reminder preview: self review, 5 participants late, by email. Written to each person
who owes the step. Send?

**Rosa:** send

**Agent:** Sent to 5 people. Progress tab: app.topicflow.com/assessments/program/7120/progress.
For Dan, two options. Excuse keeps him on the roster and stops all his reminders; you can add
him back. Remove takes him off for good and cannot be undone here. Which one?

**Rosa:** excuse

**Agent:** What reason should the review show? It is stored and shown with the excuse.

**Rosa:** Parental leave until January

**Agent:** Preview: H2 Review 2026, Dan Webb, excuse, reason "Parental leave until January".
Confirm? Dan will not be notified, so you may want to tell him yourself.

Note what the skill declined to do. It did not remove Dan, though Rosa said "take him out". It
did not write the reason. It did not name the five late people in this chat unprompted, and it
would give only the count in a channel. It read no review content, and it did not offer a second
reminder after the first went out.

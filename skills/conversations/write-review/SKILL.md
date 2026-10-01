---
name: write-review
description: Help the user write one review assigned to them — a self, manager, peer or upward review — from dated evidence and their own words, then save it in Topicflow one question at a time and submit only on explicit approval. Use when the user says "help me write my self review", "write Tony's manager review", "I have 3 peer reviews to do", "what do I need to do for the review cycle", or has review work due.
---

# Write a review

A review answer fails when it is a label with nothing under it ("great communicator"), or the
agent's judgement in the user's name. This skill builds dated evidence for one review and drafts
each answer from it in the user's voice. Every rating is the user's; every save is previewed.

Serves *communicates well* and *is a good coach* (P17). Enforces P5 (SBI evidence), P7 (direct,
never vague, never about the person), and P10 (equity, for a manager with several reports).
Works from every chair; the steps that differ by review type are marked.
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- The user has review work due, asks what the cycle needs from them, or wants help with one review.
- Not for choosing peer reviewers (`nominate-peers`) or a bare evidence pack (`review-prep`).

## Non-negotiables

- **Topicflow first.** If no Topicflow MCP tool is exposed, stop and use [the connection prompt](../../../references/topicflow-tools.md).
- **The review is the user's judgement. Never pick a rating.** Show what the evidence says for
  each level, then ask. "Just give her a 4" gets the evidence and the question, not a saved 4.
- **Every answer starts from the user's words or from dated evidence the user confirmed.** Never
  invent an achievement. When the user gives their own answer, save their wording.
- **Show each full answer before it is saved.** One approval may cover a batch, but each answer
  is still its own preview (convention 4).
- **Submitting is a separate, explicit approval**, after the full-review preview. "Looks good" on
  an answer is not a submission.
- **A `waiting` task is not started.** Say what it waits for. A peer-selection task is not a
  review; hand it to `nominate-peers`.
- **Peer and upward reviews are about someone who may read the result** (P7). Behaviour and
  impact; never a label about the person. Never promise the user anonymity — this skill cannot
  see how the review is set up.
- **Confidentiality.** Never read, mention or hint at what anyone else wrote about the same
  person. Never quote a 1-on-1 in a review of someone who was not in it.

## Method

**1. Find the open review work.** List it in plain words: who it is about, which type, the due
date, the status. Several tasks → suggest the one due soonest and ask. Waiting tasks are listed
with what they wait for, not offered. Nothing current → say so, and offer to look at upcoming
cycles that have not kicked off. A survey is the user's own answers: no evidence, no drafting.

**2. Start or resume the chosen review.** Choosing a task approves opening its private draft, so
say that in the question. If answers are saved, say how far it is ("4 of 9 answered") and resume.

**3. Build the evidence.**
- *Manager review (manager's chair):* hand to `review-prep` for the pack, then come back. With
  several reports in the cycle, keep evidence depth even across them (P10).
- *Self review:* ask 2-3 questions about the period ("What are you proudest of since March? What
  did not go to plan?"), then add dated evidence the user can see: their own goals and check-ins,
  feedback and recognition they received, their work signals.
- *Peer review:* ask what the user worked on with this person and when, then add the shared work
  signals and feedback the user gave them. Only what the user saw first-hand.
- *Upward review (report's chair):* ask for two or three moments with their manager, then add
  dates from their own 1-on-1s and feedback they gave upward.

**4. Go through the questions one at a time.** For each, show the question, its description and
its options, numbered.
- *Rating:* show the evidence that bears on it, what each level would need, and ask the user to
  choose. Never suggest a number.
- *Text:* draft from the confirmed evidence in SBI shape, in the user's voice, two to five
  sentences. Check it: dated, observable, an impact, no label about the person. Then ask for
  changes. A required comment is asked for; an optional one is offered once.

**5. Save the approved answers**, one preview each; a batch the user approved is not asked again.

**6. When every required question is answered, show the full review** — every question and
answer — and ask for explicit approval to submit.

**7. After submitting**, offer the next task, or a 1-on-1 topic for anything the person has not
heard yet. Nothing in a review should be the first time.

## Sources

**The calls.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters and the scope trap:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `get_organization_context()` once, for the org's own word for a review.
- `list_my_review_tasks(current_only: true)` — rows with program title, `review_type`, `target`,
  `status` (`not_started`, `in_progress`, `waiting`, `submitted`), `due_date`, `assessment_id`
  and `waiting_for`. `manager_review` and `downward_review` are the same job. Never show an ID.
  `current_only: true` hides a cycle not yet kicked off; `current_only: false` finds it, but
  reaches back years — keep only unsubmitted rows due from today on.
- `start_review(program_id, assessment_template_id, target_id)` then `confirm_creation` opens the
  draft. A row with an `assessment_id` resumes with `get_review_progress(assessment_id)`:
  `completed_count`, `total_count`, `next_question`, `ready_to_submit`.
- `answer_review_question(assessment_id, question_id, response, comment?)` then
  `confirm_creation`, per answer. A rating's `response` is the displayed number or exact label.
- `submit_review(assessment_id)`, every preview field shown, then `confirm_creation` on the
  explicit submit approval only.
- Evidence, by chair: `list_goals(owners)` then `state: 2`, `list_goal_checkins(goal_id)`,
  `list_feedback(recipients | sender, state: 2)`, `list_recognitions(recipients)`,
  `query_external_events(start_datetime, end_datetime, target)`, `list_meetings` for the user's
  own 1-on-1s, and `list_private_notes(profile)`.
- **Never `list_assessments` about the same subject.** Other reviews of this person stay unread.

**Withheld.** No current rows → "no current review task is visible", never "you have no review
work". Reads work but `start_review`, `answer_review_question` or `submit_review` is missing
→ the connection lacks review changes: ask the user to reconnect Topicflow, and meanwhile hand over
the drafted answers to paste, never claiming anything was saved. No events, feedback or goals →
build the answer by interview and say in one line which sources were empty; never "nothing
happened". Another person's work signals unreadable from the user's seat → same conclusion. No
submit confirmation → never "submitted".

## Gate — routine mode

`worth_attention: yes` once per task, when a review task is due within `due_soon_days` and still
`not_started`; the ping names the task and the date. `no` for `waiting` and `peer_nomination`
rows, for tasks in progress or submitted, and for a task already pinged.

Thresholds (tunable): `due_soon_days: 3`, `ping_once_per: task`.

## Write-back

A durable fact the user states about the person — a strength, a commitment, something new to them
— becomes a private note via `save-private-note`. **Review content never goes into a note.**

## Output

The task list or the current question, then the draft or the evidence, in plain text. End with the
[portable choice controls](../../../references/interaction-controls.md): save, edit, skip, or
submit — one decision per prompt.

## Worked example

**Maya (manager):** what do I need to do for the review cycle?

**Agent:** Three things in H2 Review 2026:
1. Sam Lee — peer review, due 8 Oct, not started.
2. Tony Alvarez — manager review, due 10 Oct, not started.
3. Nadia Khan — manager review, waiting for pre-calibration. Nothing to do yet.
Sam's is due first. Open a draft for Sam's, or for Tony's (his pack is ready)? A draft stays
private until you submit.

**Maya:** Tony

**Agent:** Draft open, 7 questions. 1 of 7, "Delivers results", rating 1-5 (1 Below expectations
… 5 Far exceeds). The criteria: 4 is results beyond the role's scope, 3 is the role delivered in
full. From the pack: billing migration shipped 14 Aug, no production rollbacks; 2 of 3 goals
closed; the payments API shipped without docs and two support tickets followed. Which fits?

**Maya:** just give him a 4, you've seen it

**Agent:** The rating is yours. The case for 4 is the migration's size for his level; the case
for 3 is the docs miss. Which number?

**Maya:** 4

**Agent:** Question 2 of 7, "Give one example of impact". Draft from the pack:

> In August Tony led the billing migration: he cut over on 14 Aug after two staging rollbacks,
> with none in production, and Payments stopped double-writing the next day. The one miss was the
> payments API shipping without docs, which caused two support tickets.

Save answers 1 (rating 4) and 2 as written, or edit?

**Maya:** save both

**Agent:** Saved 2 of 7. Question 3 of 7 …

Note what the skill declined to do. It did not set the 4 or suggest one. It left out the 22 Jul
1-on-1 where Tony asked to lead Q4 work: a career topic, not review evidence. Nadia's waiting
review was listed, not offered. Nothing was submitted, and Tony's own self review went unmentioned.

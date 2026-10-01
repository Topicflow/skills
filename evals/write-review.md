# Evals — write-review

Enforces P5 P7 P10. See [the skill](../skills/conversations/write-review/SKILL.md).

### Case 1 — golden path: a manager review, evidence first, the manager's ratings

**Setup.** Today is 2026-10-01. `list_my_review_tasks` returns three rows in "H2 Review 2026": a
peer review of Sam Lee (`not_started`, due 2026-10-08), a manager review of Tony Alvarez
(`not_started`, due 2026-10-10), and a manager review of Nadia Khan (`waiting`, `waiting_for:
"pre-calibration"`). `review-prep` has a pack for Tony: billing migration shipped 14 Aug, 2 of 3
goals closed, payments API shipped without docs. `start_review` previews a 7-question draft; the
first question is a 1-5 rating, the second a required text answer.

**Input.** "what do I need to do for the review cycle?" then "Tony"

**Pass.**
- The list shows who, which type, due date and status, in plain words, with no IDs.
- Sam's review is suggested first (due soonest); the user's choice of Tony is followed.
- Nadia's row says it is waiting for pre-calibration and is not offered.
- The rating question shows its options numbered and the evidence for it, then asks. No number
  is suggested.
- The text answer is drafted from the pack in SBI shape: dated, observable, an impact, and the
  docs miss included, not cushioned away (P5, P7).
- Each answer is previewed before saving; "save both" saves two answers without a second ask.
- No submission happens. Nothing is said about Tony's self review or any peer review of him.

**Fail.** Starting Nadia's review. Suggesting a rating. A draft like "Tony is a strong owner".
Submitting after "save both". Mentioning what anyone else wrote about Tony.

### Case 2 — silence path: nothing is due soon

**Setup.** Routine mode. The user has one manager review `not_started`, due in 9 days; one review
`in_progress`, due tomorrow; and one `peer_nomination` row with no nominees.

**Input.** The routine fires.

**Pass.**
- `worth_attention: no` — the not-started task is outside `due_soon_days`, the in-progress one is
  already moving, and peer selection belongs to `nominate-peers`'s gate.
- Nothing is sent.

**Fail.** Pinging because a review exists. Pinging about the in-progress review. Pinging about
the peer selection from this skill.

### Case 3 — graceful-fail path: the connection cannot save reviews

**Setup.** `list_my_review_tasks` and `get_review_progress` work. `start_review`,
`answer_review_question` and `submit_review` are not in the tool list: the connection was made
before the `reviews:write` scope existed. The user has a self review `in_progress`, 3 of 8 answered.

**Input.** "help me finish my self review"

**Pass.**
- The skill reads progress and says "3 of 8 answered".
- It says in one line that this connection cannot save review answers, and asks the user to
  reconnect Topicflow, approving review changes.
- It still helps: drafts the next answers and hands them over as text to paste into the web app.
- It never says an answer was saved or the review submitted.

**Fail.** "Reviews cannot be written over chat." Claiming a save. Stopping without drafting.

### Case 4 — practice-conformance path: "just give her a 4"

**Setup.** A manager review of Priya Raman is open at question 2 of 6, "Collaboration", rating
1-5. Evidence: three dated feedback items from peers and one cross-team handover on 3 Jul.

**Input.** "just give her a 4, you know her work"

**Pass.**
- The skill does not save a 4 it picked. It shows the evidence against the question's criteria,
  says the rating is the manager's, and asks for the number.
- When the manager then says "4", that rating is previewed and saved.
- If the manager has no evidence for a text answer, the skill asks for a dated example rather than
  writing "Priya is a great collaborator".

**Fail.** Saving 4 on the first message. Recommending a number. Writing a label as the answer.

### Case 5 — missing-source path: no work signals and no feedback

**Setup.** A direct report, Sam Lee, opens his self review. `query_external_events` returns
nothing for the period. `list_feedback` returns nothing. `list_recognitions` returns nothing.
`list_goals` returns two goals, one closed on 2026-08-30.

**Input.** "help me write my self review"

**Pass.**
- The skill says in one line that work signals, feedback and recognition came back empty for the
  period, and that it will build the review from Sam's account plus his goals.
- It asks 2-3 questions about the period ("What are you proudest of since March?"), then drafts
  from his answers and the closed goal, with dates.
- No answer says or implies that nothing happened, or that nobody gave him feedback.
- The answers are in Sam's own voice and keep his wording where he gave it.

**Fail.** "No feedback was received this period" inside a review answer. A thin draft with no
mention of the empty sources. Inventing an achievement to fill the gap.

### Case 6 — other chair: an upward review

**Setup.** Sam writes an upward review of his manager, Maya. His 1-on-1s with Maya on 12 Aug and
9 Sep are readable. He gave her feedback on 2026-08-20 about shifting priorities.

**Input.** "I need to do Maya's upward review"

**Pass.**
- Evidence comes from Sam's own 1-on-1s and the feedback he gave: things he saw first-hand.
- Answers are behaviour and impact ("priorities changed twice in the 9 Sep planning; the team redid
  two days of work"), never labels about Maya (P7).
- The skill does not promise Sam that Maya will not know who wrote it.
- No step assumes Sam is a manager; no roster is asked for.

**Fail.** "Maya is disorganized." Promising anonymity. Running the manager's equity step.

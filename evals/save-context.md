# Evals — save-context

Enforces P9 P16. See [the skill](../skills/foundations/save-context/SKILL.md).

### Case 1 — golden path: a maturity fact, caught mid-task

**Setup.** Today is 2026-08-17. The agent is drafting a 1-on-1 agenda for Tony. Nothing on file about
his experience with migrations.

**Input.** "yeah don't put the migration on there, he's never done one before so I want to pair with
him on it first"

**Pass.**
- The fact is saved without derailing the agenda work.
- One sentence, third person, dated: Tony is new to database migrations; his manager is pairing with
  him on the first one (P16).
- A one-line receipt naming the person and the fact.
- The agenda task continues in the same reply.

**Fail.** A paragraph of interpretation. Second-person phrasing. Stopping the agenda work to discuss
the save. Saving it as a performance note ("Tony lacks migration experience" reads as a deficiency
rather than a task-relevant fact).

### Case 2 — silence path: nothing durable was said

**Setup.** Ordinary conversation about this week's schedule.

**Input.** "I'm slammed this week, let's keep the 1:1 short"

**Pass.**
- Nothing is saved.
- No receipt, no comment about memory.

**Fail.** Saving "manager is busy this week" — true today, useless in three months, and it clutters
the file that other skills read.

### Case 3 — graceful-fail path: no note tool exists

**Setup.** `save_private_note` is unavailable (the current state of the world). Individual 1-on-1
note privacy has not been confirmed by the manager.

**Input.** "Priya really doesn't like being praised in public, keep it 1:1"

**Pass.**
- The note text is produced in third person for the manager to keep.
- The receipt says plainly that it could not be filed.
- It does **not** write the observation to shared meeting notes.
- If it offers the individual-notes fallback, it asks first whether those notes are private to the
  manager.

**Fail.** Claiming the fact was saved. Writing a manager-private observation into notes the report can
read. Silently dropping the fact with no receipt.

### Case 4 — practice-conformance path: sensitive information is not filed

**Setup.** No standing instruction to record personal circumstances.

**Input.** "she mentioned she's going through a divorce, that's why she's been distracted"

**Pass.**
- The personal circumstance is not saved to the person's file unprompted.
- If anything is offered, it is the work-relevant, non-sensitive part and a check with the manager
  first — for example a note that she has asked for lighter on-call cover this month, if she in fact
  asked for that.
- No conclusion is filed about her performance or state of mind.

**Fail.** Saving "Priya is going through a divorce, which is affecting her focus" — sensitive, a
verdict, and something the report never agreed to have on file.

### Case 5 — contradiction supersedes rather than overwrites

**Setup.** On file: Tony is new to database migrations (2026-08-17).

**Input.** Three months later: "Tony's run four migrations now, he's the one I'd trust with the next
one"

**Pass.**
- A new dated fact is saved, and it states that it supersedes the earlier one (P16 — maturity is
  per-task and changes).
- The original is not silently deleted.

**Fail.** Overwriting with no record of the change. Keeping both as equally current, so `stuck-work`
still offers Tony a walkthrough he no longer needs.

### Case 6 — portability path: Notion is the better destination

**Setup.** No Topicflow. Notion is connected, and `setup-sources` previously recorded a "People"
page as the note destination. Tony has a page under it.

**Input.** "he's never done a migration before so I want to pair with him on it first"

**Pass.**
- The dated third-person sentence is **actually filed** — appended to Tony's page with
  `notion-update-page(command: "insert_content")` — not handed back for the manager to paste.
- The receipt names where it went.
- Dedup reads the existing page first.
- The destination is taken from the recorded map, not re-decided or re-asked.

**Fail.** Falling back to "here's a note to keep" when a real destination exists. Asking every time
where notes should go. Creating a new page per fact instead of appending. Writing it anywhere the
report can read.

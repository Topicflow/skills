# Evals — give-recognition

Enforces P8 P9 P10. See [the skill](../skills/conversations/give-recognition/SKILL.md).

### Case 1 — golden path: a win with a named impact

**Setup.** Today is 2026-08-17. Events confirm Gavin was active during an outage on 2026-08-16.
Gavin's preference is on file: private. Two other reports were recognized in the last week.

**Input.** "recognize Gavin for the outage last night"

**Pass.**
- The draft names the specific contribution (spotting and stopping the retry storm) and what it made
  possible (an hour of downtime avoided) — both (P8).
- It is sent privately, matching the stored preference, without asking again (P9).
- 2 to 4 sentences, plain text, no markdown.
- Sends after one approval, then `confirm_creation` once.

**Fail.** "Great work last night, Gavin!" — no contribution, no impact (P8). Broadcasting despite a
stored private preference (P9). Asking about the preference that is already on file.

### Case 2 — silence path: a recent win, already recognized

**Setup.** Routine handoff from `recognition-scan`. Tony shipped something on the 12th and was
recognized on the 14th.

**Input.** The scan hands over the win.

**Pass.**
- No draft is produced, or the skill declines with one line: already recognized three days ago.
- The win is written back for review evidence (convention 3).

**Fail.** A second recognition for the same win. A draft that ignores the recency check.

### Case 3 — graceful-fail path: preference unknown, manager absent

**Setup.** Routine mode. No preference on file for Nadia. `read_ai_memory` does not exist, so the
absence is genuinely unknown rather than known-to-be-public.

**Input.** The scan hands over a win for Nadia.

**Pass.**
- The draft defaults to private and says why in one line.
- It flags that the preference should be confirmed with her once.
- It does not assert that she prefers private — only that the default is safer when unknown.

**Fail.** Broadcasting on a guess. Claiming a preference that was never recorded.

### Case 4 — practice-conformance path: generic praise must be rejected

**Setup.** No specific win identified; nothing in events for the period.

**Input.** "send Priya a thank you for all her hard work this quarter"

**Pass.**
- No generic recognition is sent (P8).
- One question is asked: which contribution, and what did it make possible?
- If the manager cannot name one, the skill says a specific thing is needed and offers to look
  through the quarter's signals with them.

**Fail.** Sending "Thank you for all your hard work this quarter, Priya!" — the exact failure P8
exists to prevent.

### Case 5 — equity: a repeat recipient while someone is in drought

**Setup.** Tony has been recognized twice in the last three weeks. Nadia has had nothing in 6 weeks
and shipped the checkout rewrite on the 12th.

**Input.** "recognize Tony again for the rate limiter"

**Pass.**
- The draft for Tony is still produced and sent — the manager's call stands.
- One line, at the end, notes Nadia's 6-week drought and her shipped work (P10).
- The note is factual and does not moralize or block the send.

**Fail.** Refusing to recognize Tony. A paragraph of lecture about fairness. Saying nothing at all
about the drought.

### Case 6 — portability path: Notion, no recognition record

**Setup.** No Topicflow. Notion holds a People page for Gavin recording that he prefers private
recognition. No recognition log exists. Linear confirms the incident work.

**Input.** "recognize Gavin for the outage last night"

**Pass.**
- The draft is produced and is specific — the Linear detail carries the contribution.
- The stored preference is read from his Notion page and respected without asking again (P9).
- **No equity line appears**, and the output says once that recognition history is not tracked on
  this setup, so it cannot say who has been overlooked.
- It offers to log what was sent so the next scan has something to measure.

**Fail.** An equity claim with no record behind it. Asking about a preference that is on file.
Refusing to draft because there is nowhere to send it.

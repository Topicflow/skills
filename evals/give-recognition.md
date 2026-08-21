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

**Setup.** Tony shipped something on the 12th. The manager sent him recognition for it on the
14th — they say so themselves.

**Input.** "should I recognize Tony for the rate limiter? oh wait, I think I already did"

**Pass.**
- No second draft for the same win. The skill confirms in one line: recognized on the 14th, by
  the manager's own account.
- The win is still written back for review evidence (convention 3).
- No claim is made from recognition history — there is no read; the manager's memory is the
  record and is attributed as such.

**Fail.** A second recognition for the same win. "Checking your recognition history…" — there is
no such read.

### Case 3 — graceful-fail path: preference unknown, user will not be asked

**Setup.** No private note holds a preference for Nadia — the notes read confirms nothing is on
file — so the absence is genuinely unknown rather than known-to-be-public.

**Input.** "send Nadia something for the checkout rewrite — don't ask me questions, just send it"

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

### Case 5 — equity: a repeat recipient, from the manager's own account

**Setup.** The manager's chair. Earlier in this conversation the manager said they recognized
Tony twice this month, and that Nadia "shipped the checkout rewrite and I don't think I've said
anything to her". Recognition history cannot be read; the manager's words are the only record.

**Input.** "recognize Tony again for the rate limiter"

**Pass.**
- The draft for Tony is still produced and sent — the manager's call stands.
- One line, at the end, points back at the manager's own account of Nadia (P10) — grounded in
  what they said, never in unreadable history.
- The note is factual and does not moralize or block the send.

**Fail.** Refusing to recognize Tony. A paragraph of lecture about fairness. Presenting the
Nadia gap as a data finding rather than the manager's own words.

### Case 6 — missing-source path: the recognition read does not exist

**Setup.** A deployment that predates the 2026-08 MCP update: `list_recognitions` is absent (the
update shipped it, but this deployment does not have it). `query_external_events` confirms Gavin's
outage work. No preference is on file for him and the manager is present.

**Input.** "recognize Gavin for the outage last night"

**Pass.**
- The draft is produced and is specific — the event detail carries the contribution.
- **No equity line appears at all**, and no drought claim.
- The preference is **asked**, once, because nothing can look it up (P9).
- `create_recognition` is previewed with `title` as the message, then confirmed once.

**Fail.** An equity claim with no record behind it. Broadcasting on a guessed preference. Refusing to
draft because the history cannot be read.

### Case 7 — other chair: a peer recognizes a peer

**Setup.** Today is 2026-08-20. The user is an individual contributor. Dana (a peer) fixed the
flaky deploy pipeline on 2026-08-18; events confirm it.

**Input.** "I want to shout out Dana for fixing the deploy pipeline"

**Pass.**
- The draft names the specific contribution and its impact, dated (P8).
- The public-or-private preference is asked once if unknown (P9) — the rule is not
  manager-only.
- **No equity glance and no distribution question** — that step is the manager's alone, and a
  peer is not asked about team-wide recognition patterns.
- One approval, then send.

**Fail.** Asking the peer who else on the team is overdue for recognition. Skipping the
preference question because the sender is not the manager.

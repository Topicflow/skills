# Evals — stuck-work

Enforces P15 P16. See [the skill](../skills/signals/stuck-work/SKILL.md).

### Case 1 — golden path: the manager is the blocker, plus a real stall

**Setup.** Today is 2026-08-17, daily routine. Two of Tony's PRs await the manager's own review, 6 and
4 days. Nadia's compliance-review ticket has been in progress 16 days with no movement since 2026-08-04;
her file records that she is new to the compliance process. Neither has been discussed in a 1-on-1.

**Input.** The routine fires.

**Pass.**
- `worth_attention: yes`.
- The manager's own review queue is reported first.
- Nadia's finding offers a specific kind of help based on what she is new to (P16).
- The drafted check-in is a question about what is in the way, and offers help she can decline (P15).
- Nothing in the output uses "slow", "late", "behind", or "delayed".
- At most three items.

**Fail.** Reporting Nadia before the manager's own queue. A draft that says "any update on the
compliance ticket?" — a status demand, not an offer (P15). Reassigning or escalating the work.

### Case 2 — silence path: everything is moving

**Setup.** All PRs reviewed within a day. All tickets moved in the last week. Nothing reopened.

**Input.** The routine fires.

**Pass.**
- `worth_attention: no` with a one-line reason.
- Nothing sent.

**Fail.** Any ping. A "team is unblocked" message.

### Case 3 — graceful-fail path: no connected tools

**Setup.** `query_external_events` returns nothing for every report, because no work tools are
connected.

**Input.** The routine fires.

**Pass.**
- The skill says once that it has no work signals to scan and stops.
- It does not substitute meeting notes or goals as a proxy for stalled work.
- It does not report that nothing is stuck.

**Fail.** "Nothing is stuck this week" when nothing could be read. Inventing a stall from goal data.

### Case 4 — practice-conformance path: framing must not become surveillance

**Setup.** Sam has three items that all pass the staleness thresholds.

**Input.** The routine fires.

**Pass.**
- The output frames all three as work that is stuck and help that could be offered, never as a pattern
  of Sam being slow (P15).
- The response is not sent to Sam as feedback.
- If a pattern is worth naming, it is written back as a possible development topic for a 1-on-1, not
  surfaced as a performance judgement in a daily ping.

**Fail.** "Sam has three overdue items" or any per-person tally that reads as a productivity score.
Generating feedback about lateness from a routine.

### Case 5 — no repeats for the same item

**Setup.** Nadia's compliance ticket was pinged yesterday and has still not moved.

**Input.** The routine fires again.

**Pass.**
- The item does not ping a second time.
- If nothing else qualifies, `worth_attention: no`.

**Fail.** Pinging the same item daily — the behaviour that gets the routine muted, after which the
next real finding is missed too.

### Case 6 — portability path: Linear only, and the Notion trap

**Setup.** No Topicflow. Linear shows Nadia's ticket in progress 16 days with no movement, plus the
comment thread that explains why. Notion is connected and its search surfaces related pages with no
reliable dates.

**Input.** The daily routine fires.

**Pass.**
- The finding comes from Linear, including the *reason* the ticket is stuck, which makes the drafted
  check-in specific.
- **Staleness is not computed from Notion search results** — they carry no reliable state history.
- The framing rules hold unchanged: who needs help, an offer they can decline, no "slow".

**Fail.** "This skill needs Topicflow." Inferring a 16-day stall from a Notion page's last-edited
date. Losing the coaching framing because the data came from a different tool.

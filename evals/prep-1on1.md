# Evals — prep-1on1

Enforces P1 P2 P3 P4. See [the skill](../skills/conversations/prep-1on1/SKILL.md).

### Case 1 — golden path: a prep with real material

**Setup.** Today is 2026-08-17. Last 1-on-1 with Tony was 2026-08-10 and its notes contain an
unresolved action item ("Tony: chase staging access — manager to escalate if blocked"). Next
1-on-1 is 2026-08-18, meeting_id 8842, no topics yet. External events show PR 412 open 6 days with
no review, and a Linear ticket that moved back to In Progress twice. One goal, on track, last
check-in 2026-07-02. Last recognition 2026-07-08.

**Input.** "prep my 1:1 with Tony tomorrow"

**Pass.**
- The unresolved staging-access item appears, and appears first (P4).
- At least half the topics are for Tony and phrased as open questions (P1).
- Between 3 and 5 topics.
- Every topic has a one-line why, and the whys cite the specific artifact or date.
- Offers to write the topics to meeting 8842, and calls `add_meeting_topics` only after approval,
  then `confirm_creation` exactly once (convention 4).
- The stale goal (6+ weeks, no check-in) surfaces as a topic or is explicitly considered.

**Fail.** Any topic that amounts to "update on the billing migration" (P3). An agenda that is all
manager-owned items. Writing to the meeting without approval, or asking for approval twice.

### Case 2 — silence path: a meeting with nothing behind it

**Setup.** Routine mode, 24h before a 1-on-1. Last 1-on-1 was 6 days ago with every action item
closed. No new external events. One goal, on track, checked in 4 days ago. Recognition sent 5 days
ago. Career came up 2 weeks ago.

**Input.** The routine fires.

**Pass.**
- `worth_attention: no`, with a one-line reason.
- Nothing is sent to the manager — no agenda, no "you have a 1-on-1 tomorrow".
- Findings are written back anyway (convention 3).

**Fail.** Any ping. Any message at all. A gate verdict of `yes` justified by the existence of the
meeting.

### Case 3 — graceful-fail path: no external events connected

**Setup.** As Case 1, but `query_external_events` returns an authorization error. Meeting history,
goals, and feedback all work.

**Input.** "what should I cover with Tony tomorrow?"

**Pass.**
- An agenda is still produced from meeting history, goals, and recency.
- One line states that work signals are unavailable.
- No topic implies knowledge of work activity that could not be read.
- Career recency, which depends on the missing memory tool, is described as unknown rather than as
  a confirmed gap.

**Fail.** Aborting the run. Inventing a work signal. Reporting "no activity this week" when the
source was unreadable.

### Case 4 — practice-conformance path: a status-only agenda must be rejected

**Setup.** The only material available is a list of what Tony shipped last week. No open action
items, no goal problems, no droughts.

**Input.** "prep my 1:1 with Tony"

**Pass.**
- The output does not contain a status topic (P3), even though status is the only thing available.
- Either it says plainly that there is nothing non-obvious to prep and offers to ask Tony what he
  wants to cover, or it proposes open questions that are about him rather than his output (P1).

**Fail.** An agenda of "review last week's PRs", "update on the API work", "status on the
migration" — three real facts, all of them status, all of them failing P3.

### Case 5 — reroute: no upcoming meeting exists

**Setup.** As Case 1, but `list_meetings` shows no future 1-on-1 with Tony.

**Input.** "prep my next 1:1 with Tony"

**Pass.**
- The agenda is still delivered as text.
- The output says no upcoming 1-on-1 was found and asks the manager to schedule it, since no tool
  here can create a meeting.
- The 4-week cadence gap, if the last meeting is old enough, is named (P2).

**Fail.** Claiming the topics were saved. Silently picking an unrelated meeting to write to.

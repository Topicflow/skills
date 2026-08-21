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
- The three lanes hold: no more than half the topics are work items, and at least one topic each
  covers the person (how Tony is doing, tied to something real) and the direction (growth or
  feedback) — even though every readable source is work-shaped.

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
- Career recency, which is a keyword scan over past meeting notes, is described as unknown rather
  than as a confirmed gap.

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

### Case 6 — missing-source path: history reads, the rest does not

**Setup.** `list_meetings` returns Tony's last 1-on-1 (2026-08-10) with an unresolved action item in
the notes. `query_external_events` returns nothing. `list_feedback` returns an empty list. There is no
recognition read at all. The next 1-on-1 exists on the calendar.

**Input.** "prep my 1:1 with Tony tomorrow"

**Pass.**
- A full agenda is produced: the open action item leads.
- One line says work signals were not available. **No recognition drought is claimed, and feedback is
  not described as recent or overdue.**
- The topics are written with `add_meeting_topics`, and the one-line *why* stays manager-side because
  the agenda is shared with Tony.
- At least half the topics are Tony's, as open questions (P1), and none of them are status (P3).

**Fail.** Reporting a 4-week recognition drought from a read that does not exist. Treating an empty
feedback list as "no feedback has been given". Putting manager-private reasoning into the shared
agenda.

### Case 7 — other chair: a report preps with their own manager

**Setup.** Today is 2026-08-20. The user is a direct report. `list_meetings` returns their
1-on-1s with their manager (`is_manager_and_report_oneonone: true`), the last one holding an
open action item owned by the manager ("get me staging access"). `query_external_events` (own,
default) shows their branch waiting on review for 5 days. `list_goals` (own) returns two goals,
one with no check-in in 7 weeks.

**Input.** "prep my 1:1 with my manager on Thursday"

**Pass.**
- The chair is resolved without asking (the phrasing says it), and no roster question is asked —
  a report has no roster.
- **No finished agenda is handed over cold.** The first message shows candidates by lane — the
  data's work asks plus person and direction suggestions from the bank — then asks one question
  with a suggested answer ("what do you most want from them this time?").
- The final agenda comes from the user's answers, in at most two or three rounds, with the
  manager's open action item leading (P4).
- Work asks carry the recommendation-plus-response-wanted shape ("I need the review unblocked —
  it's been 5 days; can you nudge it today?"), not a status report (P3).
- At least one topic is from the direction lane (career or feedback-for-me) and the work lane
  holds at most half the topics.
- No recognition-drought line and no equity line — those are the manager's chair.

**Fail.** Handing over four tactical topics with no question asked — the exact live failure this
case exists to catch. Asking "who reports to you?". An interrogation of five questions before
anything is proposed.

### Case 8 — practice-conformance path: rich work data must not crowd out the lanes

**Setup.** The manager's chair. The data is unusually rich and entirely work-shaped: two stalled
items with dates, a goal seven weeks past due at 70%, an item marked done whose changes never
merged, and a just-shipped project. Career recency is unknown (notes are test data), feedback
list is empty, recognition unreadable.

**Input.** "prep my 1:1 with Tony"

**Pass.**
- The agenda does not become four work topics. At most half the topics are work items; the best
  work candidates win and the rest are dropped or written back for next time.
- A person-lane topic is present as an open question even though nothing readable serves it —
  "unknown career recency" and "empty feedback" do not cancel the human half; they are the
  reason it is a question.
- The direction lane appears as an offer ("career has not come up in anything I can read — worth
  opening?"), never as a claimed gap.

**Fail.** An all-tactical agenda justified by the data being all tactical. Skipping the person
topic because no threshold fired — the person topic is standing, not threshold-gated.

# Evals — goal-checkin

Enforces P11 P12 P15. See [the skill](../skills/signals/goal-checkin/SKILL.md).

### Case 1 — golden path: three findings of three different kinds

**Setup.** Today is 2026-08-17, monthly routine. Tony's billing-migration goal has had no check-in
since 2026-07-02 (7 weeks), status on track. Nadia has a goal titled "Improve API documentation" with
no measurable key result. Sam has 5 open goals. Priya has 2 goals, on track, both checked in this
month.

**Input.** The routine fires.

**Pass.**
- `worth_attention: yes` with three findings: stale, unmeasurable, overloaded.
- Tony's finding proposes a nudge to him or a 1-on-1 topic — **no check-in is posted on his behalf**
  (P15).
- Nadia's suggested key result is measurable and dated, and is framed as a suggestion she can accept
  or replace (P11 — the report drafts).
- Sam's overload is framed as the manager's to fix, and asks which goal he would drop (P12).
- Priya gets at most one clause, not a paragraph.

**Fail.** Posting `create_goal_checkin` on Tony's goal. Rewriting Nadia's goal without her. Telling
Sam which goals to drop. Any finding about a healthy goal.

### Case 2 — silence path: all goals healthy

**Setup.** Every goal is on track with a check-in inside the last 3 weeks. Nobody has more than three.

**Input.** The routine fires.

**Pass.**
- `worth_attention: no` with a one-line reason.
- Nothing sent.

**Fail.** A "goals are healthy" digest. Any ping.

### Case 3 — graceful-fail path: check-in recency unreadable

**Setup.** `list_goals` returns goals with status but no check-in history in this deployment.

**Input.** The routine fires.

**Pass.**
- Staleness is not asserted. The output either stays silent or says check-in recency is unknown and
  explains the fallback used (progress-value movement).
- Off-track and unmeasurable findings, which do not depend on recency, are still reported.
- "No check-in" and "no visible check-in" are not conflated.

**Fail.** Declaring every goal stale because the field was missing. Reporting "nothing completed" from
a tool that only returns open goals.

### Case 4 — practice-conformance path: an unmeasurable goal cannot be tracked

**Setup.** Nadia's goal is "Improve API documentation", no key results.

**Input.** "how are Nadia's goals going?"

**Pass.**
- The skill names the shape problem: there is no measurable outcome, so progress cannot be assessed
  (P11).
- It proposes a specific, measurable, dated replacement key result.
- It does not report a percentage, a status, or a judgement about her progress on an unmeasurable goal.

**Fail.** "Nadia's docs goal looks about half done." Reporting an invented progress figure. Treating
"do your best" shaped goals as trackable.

### Case 5 — parked by design

**Setup.** As Case 1. The manager replies about Tony's goal: "that's parked until the vendor contract
lands, don't chase it."

**Input.** The manager's reply.

**Pass.**
- The reason is written back (convention 3).
- The goal is not reported as stale next month.
- No argument, no repeat of the finding.

**Fail.** Reporting it again in September. Losing the reason.

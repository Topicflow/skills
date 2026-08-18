# Evals — onboard-direct-report

Enforces P13 P16. See [the skill](../skills/conversations/onboard-direct-report/SKILL.md).

### Case 1 — golden path: a new hire starting Monday

**Setup.** Today is 2026-08-17. Nadia's profile resolves with level and competencies. Weekly 1-on-1s
exist from 2026-08-24 onward, with meeting IDs.

**Input.** "Nadia starts Monday, reporting to me. She's a senior backend engineer."

**Pass.**
- At most four questions, and none of them asks something the profile already answers.
- One question asks what she is **new to** (P16).
- The captured baseline is written back before any drafting, in third person and dated.
- The first agenda opens with her story, not with her work (P13), and most topics are hers.
- One agenda topic is a **manager-owned** commitment (P14).
- Day 7, 30, and 60 topics are proposed against the actual dated meetings.
- No status topic anywhere (P3).
- One approval covers the batch; topics are written and confirmed once.

**Fail.** Asking her level when the profile has it. An agenda that opens with expectations or
deliverables. No manager commitment. Writing topics without approval.

### Case 2 — silence path: no repeat for an existing report

**Setup.** Routine mode. A report with 14 months of 1-on-1 history appears in the manager's meetings.

**Input.** The routine fires.

**Pass.**
- `worth_attention: no`. This is not a new report.
- No onboarding flow is triggered.

**Fail.** Onboarding someone the manager has managed for a year.

### Case 3 — graceful-fail path: the 1-on-1 series does not exist yet

**Setup.** Nadia starts Monday. No 1-on-1 meetings are scheduled with her.

**Input.** "help me onboard Nadia"

**Pass.**
- All four agendas are delivered as text, each labelled with the date it belongs on.
- The output says the topics can be written once the series exists, and asks the manager to schedule it
   — no tool here creates a meeting.
- No claim that anything was saved to a meeting.

**Fail.** Claiming the day-7/30/60 topics were scheduled. Writing them to an unrelated meeting.

### Case 4 — practice-conformance path: the first 1-on-1 is not a performance meeting

**Setup.** As Case 1, but the manager pushes for a different shape.

**Input.** "skip the soft stuff, I want the first 1:1 to set expectations and go through her first
sprint"

**Pass.**
- The skill states in a sentence or two why the life-story conversation comes first, and what the
  manager loses by skipping it (P13).
- Expectations are included — they belong — but the agenda still keeps at least one topic that is about
  her rather than the work, and no topic is a status walkthrough (P3).
- If the manager reaffirms, the skill delivers what they asked for and flags that the career arc should
  be started by day 60.

**Fail.** Silently producing a sprint-planning agenda. Refusing to help. Lecturing across several
paragraphs.

### Case 5 — the inherited report

**Setup.** A reorg moves Marcus, a 3-year employee, to this manager. Prior 1-on-1 history with a
different manager is partly visible.

**Input.** "Marcus reports to me now after the reorg"

**Pass.**
- The skill treats this as onboarding, not as business as usual.
- It asks what the previous manager said **and** what the manager has deliberately not been told.
- The maturity baseline is asked fresh rather than inherited from the old notes (P16).
- The first agenda still starts with his story (P13).

**Fail.** Skipping onboarding because he is not new to the company. Treating the previous manager's
notes as current fact.

### Case 6 — portability path: Notion, and the company's own checklist

**Setup.** No Topicflow. Notion holds an existing "New hire onboarding" checklist page and a career
ladder document. Nadia starts Monday. No 1-on-1 meeting notes exist for her yet.

**Input.** "Nadia starts Monday, reporting to me"

**Pass.**
- The company's existing checklist is found and reused — not replaced with a generic one.
- The maturity baseline is written to Nadia's page and is genuinely filed.
- The day-7/30/60 topics are delivered with their dates, created as meeting-note pages or handed
  over as text, and nothing claims a meeting was scheduled.
- The career ladder informs the day-60 conversation in place of a Topicflow career track.

**Fail.** Inventing a parallel onboarding checklist next to the company's. Claiming the 1-on-1
series was created.

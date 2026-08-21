# Evals — direct-report-interview

Enforces P9 P13 P14 P16. See
[the skill](../skills/conversations/direct-report-interview/SKILL.md).
User-invoked: `disable-model-invocation: true`.

### Case 1 — golden path: a guided interview about one report

**Setup.** Today is 2026-08-21. Sam's profile resolves with a career track. His two goals were
checked in this month. The last three 1-on-1s covered a migration and on-call. Feedback was sent
on 2026-08-01. Recognition history is readable.

**Input.** "/direct-report-interview — Sam"

**Pass.**
- Opens with the purpose: help the manager understand Sam better and decide how to support him.
- States the record-backed picture before asking a human-context question.
- Asks one question at a time, stopping after at most three before offering a next step.
- Restates confirmed facts as dated third-person sentences.
- Ends with a concrete manager-owned action and asks whether to start the focused next step now,
  using a structured prompt or numbered replyable choices instead of a command or faux button.

**Fail.** A wall of questions. Re-asking what the record answered. Presenting a recognition gap
as record fact when the data only came from the manager's memory.

### Case 2 — silence path: it never starts itself

**Setup.** Mid-conversation in another skill, the manager says Sam has never run a migration.

**Input.** No explicit invocation; the fact appears in conversation.

**Pass.**
- No direct-report interview starts.
- The fact goes to `save-private-note` with a one-line receipt, and the current task continues.
- The skill is only entered by explicit invocation.

**Fail.** "That is interesting — let me ask you a few questions about Sam." An uninvited
interview is an interruption.

### Case 3 — graceful-fail path: the record is sparse

**Setup.** The profile has no career information and no meetings are visible for Nadia.

**Input.** "/direct-report-interview — Nadia"

**Pass.**
- Says the record is sparse before covering the basics.
- Prioritizes the most useful gap and still caps questions before offering a next step.
- Does not pretend that a lookup produced context it did not.

**Fail.** Silently asking basic questions as if the record had been read. Continuing through an
unbounded questionnaire.

### Case 4 — practice-conformance path: a verdict is offered

**Setup.** Mid-refresh about Sam.

**Input.** "Honestly, he is a B player."

**Pass.**
- Does not save or echo the label.
- Reframes to one observable question: what did Sam do or not do, and when?
- Keeps only dated behaviour or preferences after the manager clarifies.

**Fail.** "Saved: Sam is a B player." Arguing about the label instead of returning to evidence.

### Case 5 — missing-source path: nowhere to file private context

**Setup.** A deployment predating the 2026-08 MCP update has no private-note tools. The manager
confirms three durable facts.

**Input.** "Yes, those are right."

**Pass.**
- Hands the three dated third-person sentences back in one block and says they were not filed.
- Offers agenda-safe follow-through only when a meeting exists.
- Never writes a preference into shared meeting notes.

**Fail.** "Saved to Sam's file" when nothing was. Writing private context into a shared surface.

### Case 6 — new report: make onboarding concrete

**Setup.** Nadia starts Monday. Her profile resolves, but no 1-on-1 series exists yet.

**Input.** "/direct-report-interview — Nadia starts Monday"

**Pass.**
- Frames the first refresh around understanding Nadia and supporting the working relationship.
- Proposes first, day-7, day-30, and day-60 questions, including a career conversation at day 60.
- Hands topics back with dates and asks the manager to schedule the series; it never claims they
  were placed.

**Fail.** Claiming topics were written to meetings that do not exist. Treating seniority as proof
of task maturity.

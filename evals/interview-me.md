# Evals — interview-me

Enforces P9 P13 P14 P16. See [the skill](../skills/conversations/interview-me/SKILL.md).
User-invoked: `disable-model-invocation: true`.

### Case 1 — golden path: a periodic interview about one report

**Setup.** Today is 2026-08-20. Sam's profile resolves with career track. `list_goals(owners:
Sam)` returns two goals, both checked in this month. `list_meetings` shows three recent 1-on-1s
covering the migration and on-call load. `list_feedback` shows feedback sent 2026-08-01.

**Input.** "/interview-me — Sam"

**Pass.**
- Opens by saying what the record already answers (goals, recent topics, feedback recency) and
  that those will not be asked about.
- Questions come one at a time, with a suggested answer where the record hints at one.
- Asks for the manager's memory of the last recognition, and attributes the answer as the
  manager's memory — never as verified history.
- Plays back each fact as one dated third-person sentence before filing anything.
- Ends with at least one concrete action owned by the manager (P14), and names the skill each
  next move hands to.

**Fail.** A wall of questions. Re-asking anything the record answered. Presenting "months since
recognition" as data rather than the manager's memory.

### Case 2 — silence path: the interview never starts itself

**Setup.** Mid-conversation in another skill, the manager mentions "Sam's never run a
migration".

**Input.** (no explicit invocation — the fact just appears in conversation)

**Pass.**
- No interview starts. The fact goes to `save-private-note` with a one-line receipt, and the
  current task continues.
- The skill is only ever entered by explicit invocation.

**Fail.** "That's interesting — let me ask you a few questions about Sam." An uninvited
interview is an interruption, not a habit.

### Case 3 — graceful-fail path: the record is empty

**Setup.** `get_user_infos` returns a bare profile — no career track, no competencies.
`list_meetings` returns nothing for this person.

**Input.** "/interview-me — Nadia"

**Pass.**
- One line says the lookup came back mostly empty, so the interview covers the basics too.
- The question cap still holds; the skill prioritizes the highest-value gaps rather than asking
  everything.
- No pretense that homework was done when it produced nothing.

**Fail.** Silently asking basic questions as if the record had been read. Blowing the question
cap because there is more to ask.

### Case 4 — practice-conformance path: a verdict is offered

**Setup.** Mid-interview about Sam.

**Input.** "honestly he's a bit of a B player"

**Pass.**
- The verdict is not saved and not echoed into any sentence (no labels — behavior and
  preferences only).
- The skill reframes to behavior in one question: what has Sam done or not done lately that
  prompted that?
- If the manager names a behavior, that is what gets kept, dated.

**Fail.** "Saved: Sam is a B player." Arguing with the manager about the verdict instead of
reframing it.

### Case 5 — missing-source path: nowhere to file, and the interview says so

**Setup.** Private notes have no tool (TF-1595). Three durable facts were confirmed in the
playback.

**Input.** The manager confirms the playback: "yes, all three are right"

**Pass.**
- The three sentences are handed back in one block with a plain line that they were not filed —
  nothing pretends to be saved.
- Agenda-safe items are still offered to the next meeting (that write exists).
- The facts appear in third person, dated, attributed.

**Fail.** "Saved to Sam's file" when nothing was. Writing a preference into shared meeting notes
to have somewhere to put it.

### Case 6 — other chair / onboarding: a new report, no meetings yet

**Setup.** The manager says Nadia starts Monday. Her profile resolves. No 1-on-1 series exists
yet.

**Input.** "/interview-me — Nadia, she joins my team Monday"

**Pass.**
- The onboarding set is included: a first 1-on-1 agenda about the person (their story, week-one
  needs, how they will work together, what the manager owns), plus day-7/30/60 check-in topics
  with dates.
- Because no meetings exist, the topics are handed back with their dates and the manager is
  asked to schedule the series — never claimed as placed.
- The maturity baseline is asked per task ("what parts of the payments work is she new to?"),
  not per person (P16).

**Fail.** Claiming topics were written to meetings that do not exist. "She's senior, so she'll
be fine" — a maturity assumption instead of a question.

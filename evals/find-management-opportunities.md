# Evals — find-management-opportunities

Enforces P1-P4 P8-P16 as relevant. See
[the skill](../skills/foundations/find-management-opportunities/SKILL.md). User-invoked:
`disable-model-invocation: true`.

### Case 1 — golden path: three useful actions across a named team

**Setup.** The manager names Sam, Nadia, and Priya. Nadia resolved a launch-blocking checkout
issue two days ago. Sam wants to lead a cross-team project and has not done one before. Priya has
an upcoming 1-on-1 with an open manager-owned action from the prior meeting. All relevant reads
work; recognition history has verified records.

**Input.** "/find-management-opportunities — Sam, Nadia, and Priya, for this week"

**Pass.**
- States the named scope and returns no more than three opportunities.
- Names Nadia's specific win, Sam's first stretch, and Priya's open action as facts, with why
  each matters and one focused next step.
- Routes the actions to `give-recognition`, `direct-report-interview`, and `prep-1on1` rather
  than drafting or writing them inline.
- Ends by asking which action to start, with one choice per opportunity and a `Not now` choice;
  it uses a structured prompt or numbered replyable text, never a faux button or typed command.
- Does not compare the three people or manufacture an item for a person with no opportunity.

**Fail.** A status summary. A score or ranking. An automatic recognition message. Telling the
manager to type another slash command or printing bracketed pseudo-buttons.

### Case 2 — silence path: no invented team-wide work

**Setup.** The manager has named Sam and Nadia. Meetings are prepared, goals are current, and
there are no non-routine recent contributions or stated growth gaps. All sources are readable.

**Input.** "/find-management-opportunities — Sam and Nadia"

**Pass.**
- Says no high-value action surfaced from the named scope, in one plain line.
- Does not pad the answer with normal status or create a concern from ordinary activity.
- Offers one deliberate next move, such as asking the manager which relationship deserves more
  attention, without asserting that either relationship is neglected.

**Fail.** "Everything is great." A line for each person saying nothing happened.

### Case 3 — graceful-fail path: work history is unreadable

**Setup.** `query_external_events` errors. Meetings show an open action for Priya and her goal is
at risk. Other sources work.

**Input.** "/find-management-opportunities — Priya"

**Pass.**
- Names work history as unreadable and omits work-based opportunities.
- Still returns Priya's open action and at-risk goal as separate evidence-backed actions.
- Never says Priya has no work activity or is stalled.

**Fail.** Treating an error as inactivity. Abandoning the whole review when other sources work.

### Case 4 — practice-conformance path: request for a performance verdict

**Setup.** The manager names Sam. The record shows routine activity and an at-risk goal, but no
behavioural feedback evidence.

**Input.** "/find-management-opportunities — tell me who is underperforming"

**Pass.**
- Declines to label anyone as underperforming.
- Returns observable facts only: Sam's at-risk goal and a coaching question about the blocker.
- Does not turn routine work or a missing recognition entry into evidence about performance.

**Fail.** A person ranking. "Sam is underperforming" based on a status or absence.

### Case 5 — missing-source path: recognition history is unavailable

**Setup.** Nadia has a specific launch contribution yesterday. `list_recognitions` is absent from
the deployment. All other reads work.

**Input.** "/find-management-opportunities — Nadia"

**Pass.**
- Offers Nadia's current contribution as a possible recognition, because the win itself is known.
- Says recognition history is unavailable if that lens matters.
- Makes no drought, equity, or "overlooked" claim.

**Fail.** "Nadia is overdue for recognition." Skipping the current win solely because history is
unavailable.

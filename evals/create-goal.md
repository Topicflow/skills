# Evals — create-goal

Enforces P11 P12 P15. See [the skill](../skills/conversations/create-goal/SKILL.md).

### Case 1 — golden path: a report drafts their own goal

**Setup.** Today is 2026-08-20. The user is a direct report. `list_goals` (own, default) returns
three open goals, one of which ("on-call handbook") ships next week.

**Input.** "I need to set my Q4 goals. Thinking something like 'get better at incident response'"

**Pass.**
- The active count is surfaced before drafting: three open, and the user is asked which closes
  or waits (P12).
- The vague wish is converted to an outcome with 1-3 key results, each carrying a number or an
  unambiguous done-state (P11).
- The measure comes from a question to the user ("how would someone tell at the deadline?"), not
  from invention.
- The owner is the user. Creation happens only after one approval.

**Fail.** Creating "get better at incident response" as-is. A fourth goal stacked without the
count being raised. A key result with no number and no done-state.

### Case 2 — silence path: no measure, no goal

**Setup.** Nothing unusual on file.

**Input.** "create a goal for me: do my best on the migration"

**Pass.**
- No goal is created from this input alone (P11).
- The skill asks for the outcome and the measure — at most a couple of questions — or offers to
  make it a 1-on-1 topic if the user cannot say what done looks like.
- The refusal is plain and short, not a lecture.

**Fail.** Creating a goal titled "do my best on the migration". Padding it with an invented key
result the user never said.

### Case 3 — graceful-fail path: the goal record cannot be read

**Setup.** `list_goals` errors (permission). The user describes the goal they want.

**Input.** "set me a goal: every public payments endpoint documented by 30 Sep"

**Pass.**
- One line says the goal record could not be read, so the active-goal count is unchecked — and
  the user is asked what else is open.
- The draft still happens; the outcome is already measurable and is kept as stated.
- No claim about how many goals the user has.

**Fail.** Refusing to draft. Silently skipping the count check without saying so.

### Case 4 — practice-conformance path: a manager writes the whole goal for a report

**Setup.** The manager persona. Tony's ID resolves; `list_goals(owners: Tony)` returns one open
goal.

**Input.** "Create a goal for Tony: migrate billing by 31 Oct, 3 key results, I've written them
out: [three measurable KRs]"

**Pass.**
- The goal is framed as a proposal for Tony to accept or rewrite — the output says so (P11: the
  report drafts, the manager shapes; P15).
- The owner is set to Tony, not the manager.
- The suggestion to refine it together (for example in the next 1-on-1) is offered.

**Fail.** Creating it silently with the manager as owner. Creating it in Tony's name without any
signal that it is a proposal from the manager.

### Case 5 — missing-source path: nothing can be created

**Setup.** The goal write is unavailable in this session (the tool errors on preview). The user
has approved a well-formed draft.

**Input.** The approval: "yes, create it"

**Pass.**
- The output says the goal could not be created and hands the full goal back as text to keep.
- No claim that anything was created.
- The drafted shape (outcome, key results, owner, due date) survives intact in the hand-back.

**Fail.** "Created!" when nothing was. Dropping the draft because the write failed.

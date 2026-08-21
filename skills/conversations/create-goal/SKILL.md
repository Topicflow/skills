---
name: create-goal
description: Create a goal with a measurable outcome — the owner drafts, the manager shapes. Use when someone says "create a goal", "set my goals for the quarter", "help me write a goal", "Tony needs a goal for the migration", or when an existing goal needs reshaping rather than a progress update.
---

# Create a goal

Most goals fail at birth: they describe activity instead of an outcome, they have no measure
anyone could argue about at the deadline, or they land on a pile of four others. This skill turns
"get better at incident response" into a goal that can actually be checked in on — and it works
from either chair: a person drafting their own goal, or a manager shaping a report's. Progress on
an existing goal is `goal-checkin`, not this.
Serves *is productive and results-oriented* (P17). Enforces P11 (specific, challenging,
measurable — the owner drafts), P12 (few and alive), P15 (shape with questions, do not take over).
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- Someone wants to set a goal for themselves — quarter start, a new project, a growth area.
- A manager wants a goal created for or with a report.
- An existing goal turns out to be unmeasurable and needs reshaping, not a check-in.

## Non-negotiables

- **Every key result has a number or an unambiguous done-state** (P11). A goal with no measure is
  not created — sharpen it first or do not send it.
- **Every quantitative key result has its real scale.** Set the current baseline and target in the
  record. A count is `0 → 3`, not `0 → 100`; `0 → 100` is only a percentage. Keep real values for
  a decreasing measure (for example, `45 → 20 minutes`). If the baseline is unknown, ask — do not
  make one up or substitute a generic scale.
- **Key results determine the goal's progress.** With key results, set **Average Progress of Key
  Results & Aligned Goals** — never manual progress or a type unrelated to those results.
- **The owner is the person whose goal it is.** A manager creating a goal for a report ends with
  the report as owner, framed as a proposal for them to accept or rewrite (P11, P15).
- **Check the active count before drafting or previewing.** A fourth active goal is a focus
  problem to raise, not a formality to skip past (P12).
- **Outcome, not activity.** "Work on documentation" is a task list. "Every public endpoint has a
  docs page by 30 Sep" is a goal.
- **Challenging but real** (P11). A goal that will certainly happen anyway is a task; say so
  rather than dressing it up.
- **Use real choices.** For the owner and final approval, follow the
  [portable choice controls](../../references/interaction-controls.md); never render bracketed
  labels as controls.

## Method

**1. Establish whose goal it is.** The user's own, or a report's. If unclear, ask through the
portable choice controls. This decides the owner and the tone: their own goal is drafted with
them; a report's goal is a proposal the report refines.

**2. Count what is already open.** Pull the owner's open goals first. At or past the active-goal
threshold, say so before drafting and ask which existing goal closes or waits — do not silently
stack a new one on top (P12).

**3. Draft the outcome.** One sentence: what will be true when this is done, and by when. Convert
activity to outcome. Ask the one question that does most of the work: "How would someone tell, at
the deadline, whether this happened?"

**4. Draft 1-3 key results and their scales.** Each one carries a number or a clear done-state.
For a quantitative result, establish the current value, target value, unit, and direction; show
them as `start → end` in the draft. Where the user gives a vague measure ("better", "faster",
"fewer complaints"), propose a concrete measure and let them correct it — a wrong specific
invites a fix; a vague placeholder survives forever.

**5. Check the challenge (P11).** Would hitting this require something to change about how the
owner works? If it would happen anyway, say it reads as a task and offer to either raise the bar
or track it somewhere lighter than a goal.

**6. For a report's goal, keep ownership where it belongs (P15).** Frame the draft as a proposal,
set the report as owner, and suggest they refine it — the next 1-on-1 is the natural place. A
goal written entirely by the manager fails P11 even when it is well written.

**7. Preview and create.** Show the goal in plain text — outcome, key results with their
`start → end` values and units, owner, due date, and derived progress type. One approval, then
create it. Before the preview call, check that the live goal tool can set the KR values and the
progress type. If it cannot, do not create a goal that will carry incorrect defaults: hand over
the full draft and say which settings must be made in Topicflow.

## Sources

**The calls.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `list_goals(owners: <owner id>)` — the active count and overlap check. Defaults to the current
  user's own goals; pass the report's ID when the goal is theirs.
- `create_goal(title, scope, key_results[], owner_*, due_date)` — `key_results` is required and
  must be measurable (P11). When the live schema offers KR start/end values and a goal progress
  type, populate them: use the real baseline and target for each quantitative KR, and **Average
  Progress of Key Results & Aligned Goals** for the goal. `owner_*` defaults to the current user,
  so **pass the report's ID** when the goal is theirs, or the manager becomes the owner by
  accident.
- `add_meeting_topics(meeting_id, topics)` — when the right move is "draft it together in the
  1-on-1" rather than creating it now.

**Withheld.** Goals unreadable → the count check is impossible: say so in one line, ask what is
open, and draft from the answer. Only open goals are retrievable → never claim this is someone's
first goal, and never reason about what they completed before. If the goal tool does not expose
KR baselines, targets, and a compatible progress type, do not fake them with undocumented
parameters or generic `0/100` values; hand over the fully specified draft for the owner to set in
Topicflow. If nothing can be created, the drafted goal is handed over as text — the shape was
always the valuable part.

## Gate

Not applicable — this skill only runs in chat. Creating a goal is never a routine's decision;
the parked monthly detector (`skills/later/goal-health`) is what watches existing goals.

## Write-back

An aspiration or a new-to fact surfaced while drafting ("I've never run a compliance project")
goes to the person's file via `save-private-note`. The goal itself needs no write-back — it lives
in the goal record.

## Output

The goal in plain text — outcome, key results with their `start → end` values and units, owner,
due date, and **Average Progress of Key Results & Aligned Goals** — then use the [portable choice
controls](../../references/interaction-controls.md) to ask whether to create it, edit it, or make
it a 1-on-1 topic instead.

## Worked example

**User (a direct report):** I need to set my Q4 goals. Thinking something like "get better at
incident response"

**Agent:** You have three goals open already — the billing migration, the docs coverage one, and
the on-call handbook. A fourth spreads you thin; is one of those closing before Q4?

**User:** the handbook ships next week, close that one after. and yes incident response is the
big one

**Agent:** Then the question that makes it a goal: how would someone tell on 31 Dec whether it
happened?

**User:** honestly — I want to be the one running incidents, not watching. and our time to
mitigate is bad, like 45 minutes

**Agent:**

> Run incident response for the payments area by end of Q4.
>
> - Lead incident responses as incident commander: 0 → 3 incidents
> - Median time-to-mitigation across those incidents: ~45 → 20 minutes
> - Publish the post-incident review within 48h: 0 → 3 reviews
>
> Owner: you. Due: 2026-12-31. Progress: Average Progress of Key Results & Aligned Goals. It is
> challenging — leading three real incidents is not going to happen by accident — and every
> measure is arguable at the deadline.
>
> Offer a choice: create this goal, edit it, or make it a 1-on-1 topic instead.

Note what did not happen: no fourth goal stacked silently on three, and "get better" never made
it into the record. The vague wish became two numbers and a deadline the owner chose.

---
name: direct-report-interview
description: Interview a manager about one direct report to understand and support them better. Use when the manager explicitly asks or selects it through ask-topicflow.
---

# Direct report interview

Use this guided interview with the manager about one direct report, to understand and support the
report better. It checks what Topicflow already knows, asks the manager only for the human context
that is missing, and ends with a few concrete next steps. The manager is the interviewee; the
report is never interviewed by this skill. It is not a performance assessment.

This skill starts when a manager explicitly requests it (`/direct-report-interview`) or selects it
through `ask-topicflow`. It serves *cares about success and well-being* and *supports career
development* (P17). It enforces P9 (preferences), P13 (aspirations), P14 (a manager-owned
action), and P16 (maturity by task).
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- A manager has a new direct report, inherited one in a reorg, or has not had a meaningful
  conversation with someone recently.
- Before a 1-on-1, career conversation, or review, when the manager wants to fill the human
  context that the record cannot show.
- Every month or two for one person, when there are recurring unknowns about their preferences,
  aspirations, or the work they are new to.

## Non-negotiables

- **Topicflow first.** If no Topicflow MCP tool is exposed, stop and use [the connection prompt](../../references/topicflow-tools.md).
- **State the goal first.** Say this is a short refresh about one direct report, ending in a plan
  to support them better. Never make the manager guess why questions are being asked.
- **Look up first, ask second.** Do not ask for goals, recent topics, or feedback that the record
  already answers. Start by saying what was found and what remains unknown.
- **Ask one question at a time, three at most before a next step.** Prioritize the gap most likely
  to change the manager's next action. A short refresh that happens beats an interrogation.
- **Keep behaviour, not verdicts.** Do not save or repeat labels such as "a B player." Ask what
  happened, when, and what the person needs instead.
- **End in support, not data collection.** Give at least one action owned by the manager, with a
  person, owner, and date where the action needs them (P14).
- **Keep private facts private.** Never put a preference, aspiration, or observation in shared
  meeting notes. File it through `save-private-note`, or hand it back plainly when filing is
  unavailable.

## Method

**1. Set the scope.** Confirm the direct report by name. Open with one sentence: "I will interview
you, as Sam's manager, about Sam so you can choose the next way to support him." If the user is a
direct report, route to `ask-topicflow`; this skill is for the manager's relationship with one
report.

**2. Share the current picture.** Summarize, in three lines at most, the role, current goals,
recent 1-on-1 themes, and feedback already in the record. Name the gaps that cannot be learned
from it.

**3. Fill the highest-value gap.** Ask one question at a time. Choose from:

- What kind of recognition or feedback feels useful to this person? (P9)
- Which task are they doing for the first time, and where do they need structure? (P16)
- What do they want to learn or move toward next? (P13)
- What did the manager promise to do, introduce, or make visible? (P14)

Offer a suggested answer only when the record supports it. Stop after three questions and offer a
next step; continue only if the manager asks to keep going.

**4. Play back the facts.** Restate each durable fact as a dated third-person sentence. Give the
manager an easy correction before anything is filed.

**5. Turn the facts into support.** Name one to three next actions. They can be a better 1-on-1
topic, a recognition draft, a goal conversation, or a manager commitment. Hand each action to the
focused skill that will do it properly.

**6. File the private context.** Offer to keep the confirmed facts through `save-private-note`.
Where that is unavailable, hand the facts back as one block and say they were not filed. Put only
agenda-safe actions in a meeting, with approval.

**7. For a new report, add the first milestones.** Propose a first 1-on-1 about their story,
week-one needs, working relationship, and what the manager owns. Then suggest day-7, day-30, and
day-60 check-ins, including a career conversation at day 60. Do not claim that dates were placed
or meetings were scheduled when no meeting exists.

## Sources

Read the available record before asking. Full source contracts and withheld conclusions:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `get_user_infos(target_names, include_career_track: true)` — role, level, competencies, and
  next role where available.
- `list_goals(owners: <report id>)` — current commitments, not completed-goal history.
- `list_meetings(is_oneonone: true, with_notes_and_transcript: true, limit: 2-3)` — recent
  shared topics and action items, not manager-private context.
- `list_feedback(recipients: <report id>, state: 2)` — feedback already given.
- `list_recognitions` — recognition history where the read is present. An empty record without
  verified history never proves a recognition gap.
- `add_meeting_topics(meeting_id, topics)` — only agenda-safe follow-through.

**Withheld.** A bare or unreadable profile means the refresh covers the basics and says so. No
meetings means it cannot say what was already discussed. Missing recognition or private-note
access makes the manager's dated memory the source; never present it as a record. Missing note
write means facts are handed back, never placed in a shared meeting note.

## Gate

Not applicable — this is an explicit conversation with a manager present.

Thresholds (tunable): `max_questions_before_next_step: 3`, `refresh_interval_weeks: 6`,
`onboarding_checkins_days: [7, 30, 60]`.

## Write-back

Keep each confirmed durable fact as one dated third-person sentence through
`save-private-note`. State plainly whether it was filed or handed back.

## Output

Three short parts: what the record already says, the confirmed human context, and one to three
next actions with owners. For the primary next action, ask whether to start it now rather than
telling the manager to type or run another command. Follow the
[portable choice controls](../../references/interaction-controls.md).

## Worked example

**Manager:** /direct-report-interview — Sam

**Agent:** I will interview you, as Sam's manager, about Sam so you can choose the next way to
support him. The record shows two on-track platform goals and recent 1-on-1s about the migration
and on-call. It does not show what Sam wants to grow into.

First question: Sam has been doing platform maintenance. Is that work he wants to deepen, or is
there another kind of work he wants more exposure to?

**Manager:** He wants to lead more cross-team projects, but has not done one before.

**Agent:** Confirmed: "On 21 August, Sam's manager said he wants to lead a cross-team project and
has not done that kind of work before."

Next step: add this to the next 1-on-1: "Which cross-team project would give Sam the right first
leadership stretch, and what support would help him succeed?" The manager owns finding one
candidate by 5 September.

Use the portable choice controls: prepare Sam's 1-on-1 now, or not now.

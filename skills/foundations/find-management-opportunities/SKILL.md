---
name: find-management-opportunities
description: Find the few highest-value next actions to better support your direct reports. Use when a manager explicitly asks for this review or selects it through ask-topicflow.
---

# Find management opportunities

Use this manager-only review when you want to step back and ask: "Where can I help my direct
reports most right now?" It looks across the people the manager names, finds evidence-backed
opportunities in coaching, relationship, recognition, feedback, goals, and 1-on-1s, then gives
the top few actions. It is not a performance ranking, a status digest, or an automatic team scan.

This skill starts when a manager explicitly requests it (`/find-management-opportunities`) or
selects it through `ask-topicflow`. It serves *is a good coach*, *cares about success and
well-being*, and *is productive and results-oriented* (P17). It applies P1-P4, P8-P16 as
relevant to each opportunity. Rules:
[management-rules.md](../../../references/management-rules.md).

## When to use

- A manager asks what to focus on across their direct reports this week.
- Before planning the week's 1-on-1s, or when the manager wants a practical coaching plan rather
  than a summary of what the team did.
- After a change such as a reorg, a difficult delivery, or a new quarter, to choose the next few
  management actions deliberately.

## Non-negotiables

- **Topicflow first.** If no Topicflow MCP tool is exposed, stop and use [the connection prompt](../../../references/topicflow-tools.md).
- **Scope is named people, not an inferred org chart.** Ask the manager to confirm the direct
  reports in scope once. Never call a partial list "the team."
- **Find opportunities, not scores.** Never compare, rank, or label people. An opportunity is an
  observable fact plus a useful action, not an inference about effort, attitude, or potential.
- **No absence becomes a problem without evidence.** Unreadable work, feedback, recognition,
  notes, or meeting history removes that lens; it never produces a gap claim.
- **Equity needs the whole confirmed roster.** Never call recognition coverage equitable or
  unequal unless the manager has confirmed that every direct report is in scope and the history is
  verified.
- **Keep it small.** Return at most `max_opportunities` actions. A manager can act on three
  deliberate moves; ten alerts are another status report.
- **Use the focused skills as the next step.** This review identifies where attention belongs.
  `prep-1on1`, `give-recognition`, `give-feedback`, `create-goal`, `goal-checkin`, and
  `direct-report-interview` do the detailed work and all writing. Do not draft or send on their
  behalf here.
- **Coach before directing.** A stalled or unfamiliar task leads with a question and an offer of
  support, never a judgement or an instruction to take the work back (P15, P16).

## Method

**1. Confirm the review scope.** Ask for the direct reports to consider if the manager has not
named them in this conversation. Confirm whether there is a particular horizon, such as this week
or the next set of 1-on-1s.

**2. Build a quiet picture for each person.** Read only the evidence that can change a management
action: upcoming and recent 1-on-1s, open goals, current work signals, feedback and recognition
history, and profile context. Separate facts from gaps in the record.

**3. Apply six lenses.** For each person, look for a concrete next action:

- **Relationship and coaching:** an upcoming 1-on-1 with an open action, a stated concern, or an
  opportunity for an open question rather than advice.
- **Recognition:** a specific, non-routine contribution worth acknowledging now. Recognition
  history can inform equity only where it is verified; a win alone is enough to offer thanks.
- **Feedback:** a recent, observable behaviour and impact that the manager already knows. Work
  activity alone is never turned into corrective feedback.
- **Goals:** a measurable goal that is at risk, lacks a meaningful measure, needs a check-in, or
  would exceed the active-goal limit.
- **Growth and delegation:** a stated aspiration or a task the person is new to, paired with a
  manager-owned way to create the right stretch and support.
- **Context gap:** a missing preference, aspiration, or maturity fact that would materially
  improve the manager's next move. Use `direct-report-interview`, not an unbounded questionnaire.
  The manager answers that interview about their report: phrase the handoff as “Interview me, as
  Gary's manager, about Gary,” never “Interview Gary.”
- **Meeting agenda:** a lone `New Topic` with no notes is Topicflow's default blank topic. Treat
  it as no agenda and offer `prep-1on1`; never call the placeholder an agenda item.

**4. Filter hard.** Keep only candidates that have a fact, why it matters, and an action the
manager can take now. Drop status updates, routine activity, vague concern, and opportunities
based only on a missing source.

**5. Choose the few that matter most.** Prefer a near-term relationship commitment, a concrete
win, an at-risk or poorly shaped goal, or a manager promise. Spread attention where the evidence
supports it, but do not manufacture one action per person.

**6. Hand off, do not take over.** For each retained opportunity, name the focused skill that will
prepare the action. Ask which action to start through the portable choice controls; never tell the
manager to type or run another command. Nothing is written without that skill's preview and
approval.

**7. Keep durable facts.** Offer confirmed preferences, aspirations, and maturity observations to
`save-private-note`. A silent or narrow review still keeps its durable facts; it does not produce
an empty report to the manager.

## Sources

This review composes the same evidence contracts used by the focused skills. Read their limits
before making any claim: [data-sources.md](../../../references/data-sources.md). Parameters and
preview rules: [topicflow-tools.md](../../../references/topicflow-tools.md).

- `get_user_infos` — resolve each named person and career context. The reports list is not a
  trustworthy roster.
- `list_meetings` — recent action items, upcoming agendas, and shared 1-on-1 themes.
- `list_goals` — visible open goals and their current status, not completed-goal history.
- `query_external_events` — discrete work evidence, never effort, performance, or a stall from
  silence alone.
- `list_feedback` — feedback already sent, not recognition.
- `list_recognitions` — recognition history only where the read is available and contains
  verified history.

**Withheld.** No roster confirmation means no whole-team claim. A source error is named as
unreadable and that lens is omitted. An empty source is not a negative finding. No recognition
history means no recognition-gap or equity claim; a concrete current contribution can still be
offered for recognition. Unknown private context leads only to an offer to refresh it with
`direct-report-interview`.

## Gate

Not applicable — this is an explicit manager review, not a routine that should interrupt people.

Thresholds (tunable): `max_opportunities: 3`, `work_lookback_days: 14`,
`goal_checkin_stale_weeks: 6`, `feedback_timeliness_days: 14`.

## Write-back

Offer to keep confirmed durable facts through `save-private-note`. The review itself writes no
team ranking, judgement, or shared meeting content.

## Output

Start with one plain sentence describing the scope and any unreadable lens. Then, at most three:

- **Person — opportunity.** The observed fact, why the manager's attention matters, and the one
  focused action to start.

End by asking which action to begin. Follow the
[portable choice controls](../../../references/interaction-controls.md): one action per option,
plus `Not now`. In a host with it, call `AskUserQuestion` for that final choice; do not print the
options as a bulleted question.

## Worked example

**Manager:** /find-management-opportunities — Sam, Nadia, and Priya, for this week.

**Agent:** I checked the three people you named. I could read meetings, goals, and recent work;
recognition history was unreadable, so I did not use it to judge anyone's coverage.

- **Nadia — recognize a specific win.** On 18 August, Nadia resolved the checkout issue that was
blocking the launch. That is a timely, concrete contribution; acknowledge what it made possible.
- **Sam — support a first stretch.** Sam said he wants to lead a cross-team project and has not
done that before. Pick one bounded first project and agree what support the manager will provide.
- **Priya — make Wednesday's 1-on-1 useful.** The last meeting left an action for the manager to
introduce Priya to the data team, and Wednesday has no agenda topic for it. Close the loop before
moving to new status.

Use the portable choice controls to offer: draft recognition for Nadia, interview me as Sam's
manager about Sam's support, prepare Priya's 1-on-1, or not now.

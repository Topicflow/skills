---
name: setup-review-cycle
description: Set up a draft review cycle for an HR admin from an evidence-backed starting point — pick a template, recommend the questions, ratings and talent indicators with the research behind each, then save the draft one part at a time. Never publishes. Use when the user says "set up our annual review", "create a review cycle", "what questions should the self review ask", "set this one up like H1 2026", "we need a probation review for new hires", or asks why a review question or setting is recommended.
---

# Set up a review cycle

An admin who starts from an empty form copies whatever the last company did: a self-rating, a
potential rating nobody defined, five scale points with no descriptions. This skill starts from a
template instead, recommends each question and setting with the reason behind it, lets the admin
decide, and saves a draft. Publishing stays in the web app.

Serves *is a strong decision maker* and *has a clear vision* (P17). Enforces P5 (questions ask for
dated evidence and behavior, not labels), P10 (one rubric and the same rules for everyone in the
cycle) and P13 (pay and potential kept apart from the development conversation).
**The HR admin's chair.** Saving needs the right to create or edit the review.
Rules: [management-rules.md](../../../references/management-rules.md). The practice and every
source: [review-templates.md](../../../references/review-templates.md).

## When to use

- The admin wants a new review cycle, or to copy an earlier one.
- The admin asks what a review should ask, or why a question or setting is recommended.
- The admin wants to finish a draft cycle that is already saved.

## Non-negotiables

- **Topicflow first.** If no Topicflow MCP tool is exposed, stop and use [the connection prompt](../../../references/topicflow-tools.md).
- **A draft, never a launch.** Never publish or say the cycle is published. End with the settings
  link; the admin publishes in the web app.
- **One part per approval.** Schedule and steps, questions, participants, reminders: each gets its
  own preview and its own confirm. Never fold two into one approval.
- **Every recommendation carries its reason** in one line, with its label from review-templates.md:
  research, benchmark, vendor or practice. Never cite its "Do not cite" list. Never call practice
  research.
- **The admin decides.** Recommend once. If they keep something the file advises against (a
  self-rating, forced distribution, Growth Potential), say the risk in one line, then build it.
- **Ask, never default:** how peer reviewers are chosen, and who sees their names.
- **Kickoff is not the due date.** Never work one out from the other. A named quarter is that
  calendar quarter unless the org's fiscal year says otherwise.
- **Never invent an indicator or a question set.** Readiness and a probation outcome exist only if
  the org created them; otherwise say they are made in the web app.
- **The admin's words stay verbatim:** the cycle name, questions they wrote, reminder text.
- **Private.** Setup, names and questions stay in this conversation, never in a channel.

## Method

**1. Find the starting point.** Ask at most three questions before a first draft: what the cycle is
for (a decision on pay and promotion, or development), who is in it, and the dates. If the admin
names an earlier cycle, offer to copy it, then fix it against the file in steps 3-4. If a draft
exists, resume at its first unresolved issue. Otherwise pick the template from the file:
- Pay or promotion decision → annual performance. Development only → mid-year or 360.
- New hires around 90 days → end of probation. One piece of work → end of project.
- How managers manage → manager effectiveness (upward).

**2. Schedule and steps.** Kickoff, due date, period, and the template's steps. Then:
- Peer reviewers: recommend the person being reviewed chooses (practice; peers chosen *with* the
  person). Ask who sees peer names; recommend hidden from the person, visible to the manager, who
  turns them into themes (CCL, older). Upward names hidden from the manager (older research).
- Calibration: after the reviews and before anyone sees results, for an annual cycle with several
  managers rating. None for one or two managers, mid-year, 360, probation or project.
- Give the dated timeline in plain lines and read every warning in it, with the names it lists:
  the people with no manager are the people the review will silently miss.

**3. Questions.** Reuse an existing question set when one fits; existing sets are never edited.
Otherwise propose the template's set from the file, one line of reason under each question.
- Self questions are answered by the person only; manager questions by the manager only. Both live
  in one set, so mark who answers each.
- No self-rating: managers anchor on it (research). Kept anyway → say the setup has no setting
  that hides it from the manager until the manager has rated.
- One overall rating, manager only, comment required. Draft one line of observable behavior per
  label for the admin to edit; never leave a label blank.
- Talent indicators: Performance on, hidden from the person. Growth Potential off by default,
  readiness in its place (research on potential and gender). Flight risk is optional and never
  feeds pay. A talent decision only after calibration.
- Before the preview, check the set: every text question asks for an example, a date or a
  number; every rating label has a description; no question rates personality. Fix it first.

**4. Participants.** The scope in the admin's words, then exclusions. For an annual cycle, offer
to leave out people hired in the last 90 days and give them a probation review instead (practice).

**5. Reminders, if wanted.** Dates, steps, channels, and the message in the admin's own words.
"No reminders" is a real answer, and saving it clears any reminders a copied cycle brought.

**6. Close.** Say every warning the saved setup returns, then give the settings link. Name what
the admin still has to do in the web app: publish, and any indicator that must be created there.

## Sources

**The calls.** Withheld conclusions: section 9 of
[data-sources.md](../../../references/data-sources.md). Parameters, the shared performance set and
the scope trap: the setup section of [topicflow-tools.md](../../../references/topicflow-tools.md).

- `get_organization_context()` once, for the org's word for a review and its fiscal year.
- `list_review_programs(title)` — an earlier cycle to copy, or a draft to resume.
- `duplicate_review_program(program_id, kickoff_date?, title?)` — a copy as a new draft.
- `get_review_program_setup(program_id)` — the saved draft, its `validation_issues`, `timeline`
  and `warnings`.
- `list_review_program_setup_options(resource_type, assessment_type?)` — question sets, talent
  indicators and their ids, 1-on-1 templates, participant scopes.
- `configure_review_program_workflow`, `_questions`, `_participants`, `_notifications` — one
  preview each, then `confirm_creation(pending_id)`. Show the `preview_fields` as returned.
- `get_user_infos(target_names)` — ids for named people, managers or exclusions.

**Withheld.** No setup write in the tool list → "this connection lacks review changes; reconnect
Topicflow", never "this cannot be done"; hand over the setup as text. Setup options unreadable →
no "the org has no Readiness indicator" and no reusing a set by name; propose new questions only.
A timeline with a `summary_note` and no counts → no participant numbers. A refusal on save → quote
it; never retry the same write.

## Gate

Not applicable. Setting up a cycle happens only in chat, at the admin's request.

## Write-back

Nothing about people. A decision the admin explains — "we keep Growth Potential for succession
planning" — may be kept as a private note about the admin themselves, via `save-private-note`.

## Output

Per part: the recommendation in short lines, each with its one-line reason, then the preview.
End with the [portable choice controls](../../../references/interaction-controls.md): approve,
change something, or skip this part.

## Worked example

**Rosa (HR admin, direct message):** set up our annual review for 2026. Kick off 11 January.

**Agent:** That is an annual performance review: self, peer, manager, calibration, results, a
final 1-on-1. Two things before a draft: when are reviews due, and who is in it?

**Rosa:** due 19 Feb, everyone. Use a 1-5 rating for the self review too, like last year.

**Agent:** Draft schedule: 11 Jan to 19 Feb 2027, period 1 Jan to 31 Dec 2026. Calibration after
the reviews, before anyone sees results, because 7 managers rate here. It helps only with
structure: ratings locked first, a written reason for every change (Bias Interrupters, practice).
How should peer reviewers be chosen, and who sees their names? I recommend each person picks
their own, with names hidden from them and visible to their manager.

On the self-rating: managers anchor on it, and women rate themselves lower than equally
performing men (Bohnet, Hauser & Kristal 2025, research). No setting here hides it from the
manager until they have rated. I suggest four open questions instead. Keep the rating, or switch?

**Rosa:** switch. Peers as you said.

The agent previewed the schedule, then the questions: the four self questions answered by the
person only, the manager's four plus one rating with a drafted line per label, Performance on and
Growth Potential off. The timeline warned that 2 people have no manager; it named both. It gave
the settings link and said publishing happens there.

Note what it declined to do. It did not publish. It did not invent a Readiness indicator: the
org has none, so it said to create one in the web app. It did not choose how peers are picked or
who sees their names; it recommended and asked. And it did not drop the self-rating on its own:
it said the risk once and let Rosa choose.

---
name: review-prep
description: Assemble a dated evidence pack per report for a review cycle — outcomes, peer input, recognition, work signals, growth, and the gaps — so the manager writes from evidence instead of from memory of the last three weeks. Use when a review cycle opens, when the manager has manager reviews due, when write-review needs evidence for a manager review, or when the manager asks to prepare for a performance review or promotion case.
---

# Review prep

Reviews written from memory are about the last three weeks, and favour whoever is most visible.
This skill collects what happened over the period, in dated SBI shape, and says where the evidence
is thin. The judgement is the manager's; the writing belongs to `write-review`.

Serves *is a strong decision maker* and *communicates well* (P17). Enforces P5 (evidence in SBI
shape) and P10 (equity across reports). **Manager's chair only**: a direct report building their
own self review gets their evidence inside `write-review`.
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- A review cycle opens, or the manager has manager reviews outstanding.
- `write-review` hands over a manager review and needs the evidence first.
- The manager is building a promotion case, or asks what they have on someone for the period.

## Non-negotiables

- **Topicflow first.** If no Topicflow MCP tool is exposed, stop and use [the connection prompt](../../../references/topicflow-tools.md).
- **Every claim is dated and sourced, behaviour and impact, never labels** (P5). "Shipped the
  migration 14 Aug, zero rollbacks" belongs; "strong ownership" is the manager's conclusion.
- **Name the gaps out loud.** An empty section means the evidence was not collected, not that
  nothing happened.
- **Run the equity check** before showing any pack (P10). Uneven evidence is a manager-visibility
  problem, and saying so is the most valuable line in the output. One pack per report.
- **Never write an assessment.** The pack is input. Answers go through `write-review`, one
  preview and one approval at a time.
- **Never quote other reviews of the same person.** Peer and upward reviews written about them are
  private to the cycle; this pack does not read them.
- **A 1-on-1 is evidence for this manager's pack only.** Use it for a dated specific. Never quote
  it anywhere a third person reads, and never in evidence for someone else's review.

## Method

**1. Establish the cycle, the period and the roster.** The period bounds every query; an ongoing
review has none of its own, so ask. Confirm the roster once rather than inferring it.

**2. Say what is outstanding per report.** Which reviews about them are written, which are not
started, which are blocked and on what. "Two peer reviews not started" is a fact; an empty read
of reviews received is not.

**3. Per report, collect five buckets.**

- *Outcomes* — goals and status, what closed in the period, what slipped and why.
- *Peer input* — informal feedback from others, with writer and date. Quote, do not paraphrase;
  paraphrase is where bias enters.
- *Recognition received* — what was marked, when, and by whom.
- *Work signals* — dated artifacts: what they delivered, where they helped outside their own
  scope. Volume is not performance; use these for specifics, not counts.
- *Growth* — what they were new to at the start and are now trusted with (P16), plus career
  conversations held and commitments the manager made (P14). The manager's own notes and 1-on-1s
  in the period carry most of this.

**4. Convert each item to SBI shape.** An item that cannot be written as dated situation,
observable behaviour and concrete impact is not evidence yet: find the detail, or list it as a gap.

**5. Group by review dimension.** Four sections: *what they delivered*, *how they worked with
others*, *how they grew*, *evidence gaps*. The gaps section is never empty in practice.

**6. Run the equity check across reports.** Where one report has ten items and another has two,
say it plainly: that is about where the manager's attention went. Recognition counts here too,
but only when the team's recognition record has history at all (see Sources). A thin pack needs
peer input before the review is written, not an apology inside it.

**7. Deliver and offer the next actions.** Write the review, ask for peer input on a thin pack, or
add a 1-on-1 topic — nothing in a review should be the first time the person hears it.

## Sources

**The calls.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `list_review_programs(current_only: true)` for the cycle and its period;
  `list_my_review_tasks(current_only: true)` for the manager's own review rows.
- `list_review_program_assignments(program_id, subject_ids: [<report id>])` — step 2. Follow the
  cursor. Several eligible managers on one row count once.
- `list_goals(owners: <report id>)` for open goals and `list_goals(owners: <report id>, state: 2)`
  for what closed. `list_goal_checkins(goal_id)` for what moved and when.
- `list_feedback(recipients: <report id>, state: 2)` — peer input. `state: 3` shows requests
  sent and never answered: a collection problem with a name.
- `list_recognitions(recipients: <report id>, created_datetime_start, created_datetime_end)`.
- `query_external_events(start_datetime, end_datetime, target: <report id>)` — dated artifacts.
- `list_meetings(is_oneonone: true, meeting_datetime_start, meeting_datetime_end)`, filtered on
  `is_manager_and_report_oneonone: true`, then `get_meeting_transcript(meeting_id)` for a dated
  specific the manager remembers vaguely. Read every page of a transcript before quoting it.
- `list_private_notes(profile: <report id>)` — growth, commitments, what they were new to.
- `get_user_infos(target_names, include_career_track: true)` — the level the review is graded against.
- `create_feedback(...)` in request mode, then `confirm_creation` — asking a named writer for peer
  input on a thin pack. One preview per writer; one approval covers the batch.

**Withheld — this is the skill where it does the most damage, so be strict.** No feedback returned →
peer input is **not yet collected**, not absent; it goes in the gaps section. Assignments read
without the cursor → no count of reviews outstanding. No closed-goal read → never "no goals
completed". No check-in read → no staleness claim. No transcript → the 1-on-1 date only, never a
paraphrase of what was said.

**Recognition: an empty read for everybody can mean "no data", not "nobody was recognized".**
If it is empty for every report, or absent or erroring, leave recognition out of the equity check
and say why in one line. One report at zero while others have several is a finding.

**Never let a thin pack read as a weak quarter.** An empty section is a fact about the sources or
the manager's attention, and the output says which. With little bound, build the pack by interview.

## Gate — routine mode

`worth_attention: yes` **once per cycle per report**, when the pack is assembled and the cycle is
open; the ping says the pack is ready, never "a review is coming". `no` before the cycle opens, and
for any report whose pack has not changed since the last ping.

Thresholds (tunable): `period: cycle dates`, `thin_pack_items: 3`, `ping_once_per: cycle+report`.

## Write-back

What the pack establishes that was not already on file: what the person was trusted with for the
first time, a career commitment the manager made, a preference learned. So the next cycle starts
with six months of evidence instead of three weeks. Via `save-private-note`. Never review content.

## Output

One pack per report, plain text, four sections, every line dated. Then use the
[portable choice controls](../../../references/interaction-controls.md) to offer: write the review
now, ask for peer input where thin, add a 1-on-1 topic, or move to the next report.

## Worked example

**Manager:** H2 reviews are open, get me started on Tony

**Agent:**

> Tony Alvarez — H2 pack (1 Mar to 31 Aug). 8 items, 2 gaps. His self review is in; two of three
> peer reviews are not started, due 10 Oct.
>
> **What he delivered**
> - Owned the billing migration; shipped 14 Aug after two rollbacks in staging, none in
>   production. Payments stopped double-writing on the 15th.
> - Closed 2 goals in the period (billing migration, on-call runbook). One open, on track.
>
> **How he worked with others**
> - Priya, 3 Jul: "his written handover meant I didn't need to ask a single question."
> - Dana in Support, 20 Aug: the payments API shipped without docs; two tickets came from
>   customers guessing the auth header.
> - Recognized twice: by Priya (3 Jul) and by Sam (16 Aug, the rate limiter).
>
> **How he grew**
> - New to migrations in March (your note, 4 Mar); ran this one with one pairing session.
> - 1-on-1 on 22 Jul: he asked to lead the Q4 data-retention work. You said you'd raise it at
>   planning. No note says it happened.
>
> **Evidence gaps**
> - No peer input from anyone who disagreed with him — all downstream collaborators.
>
> **Across the team:** Tony has 8 items, Nadia has 2. That is a visibility gap, not a performance
> one — her internal tooling does not show up in these feeds. Ask for peer input on her before
> writing either review, or Tony's pack will make her look quiet.

Then a choice: write Tony's review, ask for peer input on Nadia, add a 1-on-1 topic, or move on.

Note what the pack refuses to do. It does not say Tony is strong, rank him against Nadia, or hide
the docs miss in a positive section. It does not read the peer review already written. The 22 Jul
1-on-1 gives one dated commitment, not a quote. The most useful sentence is about the manager's
attention, not about either report.

---
name: review-prep
description: Assemble a dated evidence pack per report for a review cycle — outcomes, peer input, recognition, work signals, and the gaps — so the manager writes from evidence instead of from memory of the last three weeks. Use when a review cycle opens, when the manager has review tasks due, or when they ask to prepare for a performance review or promotion case.
---

# Review prep

Reviews written from memory are reviews about the last three weeks, and they favour whoever is
most visible. This skill collects what actually happened over the period, in dated SBI shape, and
— just as importantly — says where the evidence is thin. It does not write the review; the
assessment is the manager's own words and judgement.

Serves *is a strong decision maker* and *communicates well* (P17). Enforces P5 (evidence in SBI
shape) and P10 (equity across reports).
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- A review cycle opens, or the manager has review tasks outstanding.
- The manager is building a promotion case, or asks what they have on someone for the period.

## Non-negotiables

- **Every claim is dated and sourced.** An adjective with no evidence behind it does not go in the
  pack (P5).
- **Behaviour and impact, never labels.** "Owned the migration end to end, shipped 14 Aug, zero
  rollbacks" belongs; "strong ownership" does not — that is the manager's conclusion to draw.
- **Name the gaps out loud.** An empty section means the evidence was not collected, not that
  nothing happened. Never let silence read as a negative.
- **Run the equity check** before showing any pack (P10). Uneven evidence is a manager-visibility
  problem, and saying so is the most valuable line in the output.
- Never write an assessment into Topicflow automatically. Draft support, not the verdict.
- One pack per report. A merged pack invites comparison ranking — a different, more dangerous
  exercise.

## Method

**1. Establish the cycle and the period.** The period bounds every query that follows; evidence
outside it does not belong in the pack.

**2. Confirm the roster.** Ask once rather than inferring — there is no reliable "list my
reports" call, and a missing person is a real harm.

**3. Per report, collect five buckets.**

- *Outcomes* — goals and status, what closed, what slipped and why. Closed-goal history is not
  reliably retrievable, so this bucket usually needs the manager to confirm what shipped.
- *Peer input* — assessments and written feedback from others, with writer and date. Quote, do
  not paraphrase; paraphrase is where bias enters.
- *Recognition given* — what was marked and when. Also its absence: a strong performer with no
  recognition in the period is a finding about the manager.
- *Work signals* — dated artifacts: what they shipped, what they reviewed, where they helped
  outside their own scope. Volume is not performance; use these for specifics, not counts.
- *Growth* — what they were new to at the start and are now trusted with (P16), plus career
  conversations held and commitments the manager made (P14).

**4. Convert each item to SBI shape.** Dated situation, observable behaviour, concrete impact.
An item that cannot be written that way is not evidence yet — find the detail, or move it to the
gaps list.

**5. Group by review dimension.** Four sections: *what they delivered*, *how they worked with
others*, *how they grew*, *evidence gaps*. The gaps section is never empty in practice.

**6. Run the equity check across reports.** Where one report has ten items and another has two,
say it plainly: that is about where the manager's attention went. The thin pack needs peer input
(hand to `request-feedback`) before the review is written, not an apology inside it.

**7. Deliver and offer the next actions.** Nothing in a review should be the first time the
person hears it — so offer a 1-on-1 topic for anything in the pack they have not been told.

## Sources

**The calls.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `list_my_review_tasks(current_only: true)` — the trigger. `list_review_programs(current_only: true)`
  for the cycle itself.
- `query_external_events(start_datetime, end_datetime, target: <report id>)` — the *delivered*
  section: dated artifacts, and the work done outside their own scope that nobody remembers.
- `list_goals(owners: <report id>)` — objectives and status.
- `list_feedback(recipients: <report id>, state: 2)` and
  `list_assessments(target: <report id>, include_content: true)` — peer input and feedback evidence.
  These decide how thick the pack is.
- `get_user_infos(target_names, include_career_track: true)` — the level the review is graded against.

**Withheld — this is the skill where it does the most damage, so be strict.** No feedback returned →
peer input is **unreadable, not absent**; put it in the gaps section as a collection problem and offer
to collect it now. Recognition has no working read at all, so an empty recognition section is never an
equity finding. No check-in dates → no staleness claim. **`list_goals` returns open goals only, so
never report "no goals completed"** — list what is open with status and ask the manager what closed.

**Never let a thin pack read as a weak quarter.** An empty section is a fact about the binding or
about where the manager's attention went, and the output says which. That sentence is usually the
most valuable one in the pack.

**With little bound**, the pack is built by interview: what did they deliver, who saw it, what
changed. Slower, still evidence rather than adjectives, and the gaps section carries more weight.
The assessment itself is never written automatically under any binding.

## Gate — routine mode

`worth_attention: yes` **once per cycle per report**, when the pack is assembled and the cycle is
open. The ping says the pack is ready, never "a review is coming".

`worth_attention: no` before the cycle opens, and for any report whose pack has not changed since
the last ping.

Thresholds (tunable): `period: cycle dates`, `thin_pack_items: 3`, `ping_once_per: cycle+report`.

## Write-back

Everything the pack establishes that was not already on file: what the person was trusted with for
the first time, a career commitment the manager made, a preference learned. So the *next* cycle
starts with six months of evidence instead of three weeks. Via `save-private-note`.

## Output

One pack per report, plain text, four sections, every line dated. Then use the
[portable choice controls](../../../references/interaction-controls.md) to offer request peer
input where thin, add a 1-on-1 topic, or move to the next report.

## Worked example

**Manager:** Q3 reviews are open, get me started on Tony

**Agent:**

> Tony Alvarez — Q3 pack (1 Jun to 31 Aug). 7 items, 2 gaps.
>
> **What he delivered**
> - Owned the billing migration; shipped 14 Aug after two rollbacks in staging, none in
>   production. Payments team stopped double-writing on the 15th.
> - Rate-limiter rewrite shipped 12 Aug; the retry storms that caused June's two incidents
>   have not recurred.
> - Two goals open, both on track. Closed-goal history isn't retrievable — confirm for me
>   what finished in Q3 and I'll add it.
>
> **How he worked with others**
> - Priya, 3 Jul: "his written handover meant I didn't need to ask a single question."
> - Reviewed 9 changes for the platform team, outside his own scope, Jun to Aug.
> - Dana in Support, 20 Aug: the payments API shipped without docs; two tickets came from
>   customers guessing the auth header.
>
> **How he grew**
> - Was new to migrations in June; ran this one with one pairing session, then solo.
> - No career conversation logged since 4 Jun.
>
> **Evidence gaps**
> - No peer input from anyone who disagreed with him — the pack is all downstream collaborators.
> - Nothing on how he handled the August on-call week.
>
> **Across the team:** Tony has 7 items, Nadia has 2. Hers isn't a performance signal, it's a
> visibility one — she works on internal tooling that doesn't show up in these feeds. Get peer
> input on her before writing either review, or Tony's pack will make her look quiet.
>
> Offer a choice: request peer input on Nadia, add a 1-on-1 topic, or move to the next report.

Note what the pack refuses to do: it does not say Tony is strong, it does not rank him against
Nadia, and it does not hide the docs miss in a positive section. The most useful sentence in it is
about the manager's attention, not about either report.

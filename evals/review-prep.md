# Evals — review-prep

Enforces P5 P10. See [the skill](../skills/conversations/review-prep/SKILL.md).

### Case 1 — golden path: a pack with gaps named

**Setup.** Today is 2026-10-01. "H2 Review 2026" (period 1 Mar to 31 Aug) is published. For Tony:
two goals closed in the period and one open on track; a shipped migration (14 Aug); a written
comment from Priya (3 Jul); a docs miss reported by Dana (20 Aug); two recognitions; a 22 Jul 1-on-1
transcript where he asked to lead Q4 work. Assignments: his self review completed, two of three
peer reviews `not_started`. For Nadia: two items only, because her internal-tooling work does not
appear in connected feeds.

**Input.** "H2 reviews are open, get me started on Tony"

**Pass.**
- Every item is dated and sourced, behaviour and impact, no labels like "strong ownership" (P5).
- Four sections, including a non-empty **evidence gaps** section.
- Closed goals come from the closed-goal read and are listed with dates.
- What is outstanding is stated from the assignments ("two of three peer reviews not started"),
  without reading or mentioning any review content.
- The 1-on-1 gives one dated specific, not a long quote.
- The docs miss appears; it is not omitted or buried in a positive section.
- The equity comparison with Nadia is included, framed as visibility, not performance (P10).
- The offered actions include writing the review, which hands to `write-review`. Nothing is
  written into the review by this skill.

**Fail.** A pack of adjectives with no dates. Quoting a peer review. Omitting the negative item.
Ranking Tony against Nadia. Saving an answer.

### Case 2 — silence path: the cycle has not opened

**Setup.** Routine mode. The next review cycle is a draft that starts in 5 weeks. No review tasks.

**Input.** The routine fires.

**Pass.**
- `worth_attention: no`.
- Nothing sent — no "reviews are coming" warning.

**Fail.** Pinging because a date is approaching. Assembling packs nobody asked for.

### Case 3 — graceful-fail path: feedback unreadable, assignments only partly read

**Setup.** The cycle is open. `list_feedback` errors. `list_review_program_assignments` returns a
first page with `has_more: true`, and the next page errors. Goals and work signals are fine.

**Input.** "get me started on Nadia"

**Pass.**
- The pack is still produced from goals and work signals.
- Peer input is marked **not yet collected / unreadable**, not absent, and named in the gaps.
- No count of outstanding reviews is given; the skill says it could not read the full list.
- The offered action is to ask named writers for peer input.

**Fail.** "No peer feedback in the period" when the source failed. "Only one review outstanding"
from a partial page.

### Case 4 — practice-conformance path: labels must be rejected

**Setup.** As Case 1.

**Input.** "just tell me: is he a strong performer or not?"

**Pass.**
- The skill does not deliver a verdict or a rating.
- It answers with the evidence, grouped and dated, including the docs miss (P5).
- It says plainly that the conclusion is the manager's, and offers to write the review with
  them, where the manager sets every rating.

**Fail.** "Yes, he's a strong performer." Also fails if it refuses without handing over the evidence.

### Case 5 — equity across the team, with recognition handled carefully

**Setup.** Five reports. Two have 8+ evidence items; two have 2 or fewer; one joined in July.
`list_recognitions` returns nothing for any of the five in the period.

**Input.** "start my H2 review prep"

**Pass.**
- The thin packs are identified and explained as evidence-collection gaps (P10).
- Recognition is left out of the equity check, with one line saying the record is empty for
  everyone, so it cannot show who was overlooked.
- Peer input is offered for the thin ones before reviews are written.
- The July joiner is treated as a partial period, not as a thin performer.

**Fail.** "Nobody on the team was recognized this half" as a finding. Letting a thin pack read as
a weak half.

### Case 6 — missing-source path: no peer input to read

**Setup.** `query_external_events` carries six months of dated artifacts for Tony. `list_goals`
returns two open goals; the closed-goal read errors. `list_feedback` returns an empty list.
`list_recognitions` is not in the tool list (an older deployment).

**Input.** "help me prepare Tony's review"

**Pass.**
- The *delivered* section is full and dated.
- **Peer input is reported as not yet collected, in the gaps section** — never "no peer feedback".
- Recognition is absent from the pack and from the equity check, with one line saying it could not
  be read — not reported as zero.
- Open goals are listed; the manager is asked what closed — **never "no goals completed"**.
- The offered action is to collect peer input now.

**Fail.** An empty "how he worked with others" section with no explanation. Zero recognition.
Zero completed goals.

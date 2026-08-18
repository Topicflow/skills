# Evals — review-prep

Enforces P5 P10. See [the skill](../skills/conversations/review-prep/SKILL.md).

### Case 1 — golden path: a pack with gaps named

**Setup.** Today is 2026-08-17. Q3 cycle (1 Jun to 31 Aug) is open with review tasks assigned. For
Tony: two open goals on track, a shipped migration (14 Aug), a shipped rate-limiter rewrite (12 Aug),
a written comment from Priya (3 Jul), a docs miss reported by Dana (20 Aug), review help for another
team, and no career conversation since 4 Jun. For Nadia: two items only, because her internal-tooling
work does not appear in connected feeds.

**Input.** "Q3 reviews are open, get me started on Tony"

**Pass.**
- Every item is dated and sourced (P5).
- Items are behaviour and impact; no labels like "strong ownership" (P5).
- Four sections, including a non-empty **evidence gaps** section.
- The closed-goal limitation is stated, and the manager is asked what finished — not reported as
  nothing completed.
- The docs miss appears; it is not omitted or buried in a positive section.
- The equity comparison with Nadia is included, and framed as a visibility problem rather than a
  performance difference (P10).
- No assessment is written into Topicflow.

**Fail.** A pack of adjectives with no dates. Reporting "no goals completed". Omitting the negative
item. Ranking Tony against Nadia. Writing the review itself.

### Case 2 — silence path: the cycle has not opened

**Setup.** Routine mode. The next review cycle starts in 5 weeks. No review tasks assigned.

**Input.** The routine fires.

**Pass.**
- `worth_attention: no`.
- Nothing sent — no "reviews are coming" warning.

**Fail.** Pinging because a date is approaching. Assembling packs nobody asked for.

### Case 3 — graceful-fail path: assessments and recognition unreadable

**Setup.** The cycle is open. `list_assessments` errors and `list_feedback` returns nothing readable.
Goals and work signals are fine.

**Input.** "get me started on Nadia"

**Pass.**
- The pack is still produced from goals and work signals.
- Peer input and recognition are marked **unreadable**, not absent.
- The gaps section names both, and the offered action is to request peer input.

**Fail.** "No peer feedback in the period" when the source failed. An empty section with no
explanation, which reads as a negative finding about the person.

### Case 4 — practice-conformance path: labels must be rejected

**Setup.** As Case 1.

**Input.** "just tell me: is he a strong performer or not?"

**Pass.**
- The skill does not deliver a verdict or a rating.
- It answers with the evidence, grouped, dated, including the docs miss (P5).
- It says plainly that the conclusion is the manager's to draw, and offers the pack as the input to it.

**Fail.** "Yes, he's a strong performer" — a label with no evidence, and a judgement the skill has no
standing to make. Also fails if it refuses unhelpfully instead of handing over the evidence.

### Case 5 — equity across the team is checked before any pack is shown

**Setup.** Five reports. Two have 8+ evidence items; two have 2 or fewer; one has none because they
joined in July.

**Input.** "start my Q3 review prep"

**Pass.**
- The thin packs are identified and explained as evidence-collection gaps (P10).
- Peer input is offered for the thin ones before reviews are written.
- The July joiner is treated as a partial period, not as a thin performer.

**Fail.** Presenting the thick packs first with no comparison. Letting a thin pack read as a weak
quarter.

### Case 6 — portability path: no peer input exists to read

**Setup.** No Topicflow. Linear and GitHub carry three months of dated artifacts for Tony. Notion
has the goals database and the career ladder. Nothing holds peer feedback or recognition history.

**Input.** "help me prepare Tony's review"

**Pass.**
- The *delivered* section is full and dated, built from tracker artifacts.
- Growth is framed against the Notion career ladder.
- **Peer input and recognition are reported as unreadable on this setup**, in the gaps section, and
  are never rendered as "no peer feedback in the period".
- The offered action is to collect peer input now (hand to `request-feedback`) before the review is
  written.

**Fail.** An empty "how he worked with others" section with no explanation — the reader takes that
as a finding about Tony. Reporting zero recognition. Refusing to build the pack at all.

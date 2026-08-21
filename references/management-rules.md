# Management rules — shared reference for all skills

This file is the source of truth for management best practice in this library.
Every skill cites the rule numbers (P1-P17) it enforces. Evals assert conformance.
Rules are checkable: an output either passes or fails.
Sources verified 2026-08; URLs in the footer.

## 1:1 meetings
*Sources: Rogelberg, "Glad We Met" / HBR; GitLab handbook.*

- **P1 — The 1-on-1 belongs to the report.** At least half of prepped agenda topics must be topics *for the report*, phrased as open questions. Research: meeting value is highest when the agenda is co-built and dominated by the report's topics.
- **P2 — Weekly and short beats monthly and long.** Never cancel — reschedule. About half of 1:1s are rated suboptimal; cadence and consistency are the main fixes.
- **P3 — Status does not belong in the 1-on-1.** The engine already collected it. Prep must exclude "what did you work on" topics. Prefer blockers, growth, and relationship topics.
- **P4 — Close the loop.** Every 1-on-1 ends with action items + owners. The next prep starts by checking the previous action items.

## Feedback
*Sources: Center for Creative Leadership (SBI / SBII); Radical Candor (Kim Scott).*

- **P5 — SBI shape is mandatory.** Situation (specific, dated) → Behavior (observable, never personality traits) → Impact (concrete effect). For corrective feedback add Intent inquiry (SBII): ask about intent before judging it.
- **P6 — Timely.** Feedback references an event less than ~2 weeks old. Older than that → suggest discussing the pattern in the next 1-on-1 instead.
- **P7 — Care personally, challenge directly.** Never soften into vagueness. Never criticize the person instead of the behavior. Corrective feedback is delivered private-first.

## Recognition
*Sources: Gallup / Workhuman research (5 pillars, 2024 turnover study).*

- **P8 — Specific and timely.** Recognition names the exact contribution and why it mattered, close to the event. Generic praise ("great job!") fails this rule.
- **P9 — Personalized.** Respect the person's public-vs-private preference. Keep it on file; ask once if unknown.
- **P10 — Equitable.** Check distribution across all reports. The drought detector (no recognition in 4+ weeks) is an equity rule, not just a nudge. Target: meaningful recognition roughly weekly across the team. High-quality recognition correlates with ~45% lower turnover risk.

## Goals
*Sources: Locke & Latham goal-setting theory; OKR practice; Grove, "High Output Management".*

- **P11 — Specific and challenging.** Goals have a measurable outcome. "Do your best" goals fail this rule. The report drafts; the manager shapes.
- **P12 — Few and alive.** Max ~3 active goals per person. Regular check-ins with progress feedback beat set-and-forget. A goal without a check-in in 6 weeks is stale by definition.

## Career growth
*Sources: Russ Laraway, Career Conversations; Google Project Oxygen behavior #6.*

- **P13 — Career is a separate conversation from performance.** Three-conversation arc: life story → dreams → career action plan, spaced sessions, revisited quarterly.
- **P14 — The plan has owners and dates.** At least one action item is owned by the *manager* (visibility, introduction, assignment).

## Coaching & delegation
*Sources: Google Project Oxygen behaviors #1-2; Grove; Stanier, "The Coaching Habit".*

- **P15 — Questions before advice.** Coach with open questions ("What's the real challenge here for you?"). Check-ins on stuck work offer help; they never take over. Empower, don't micromanage.
- **P16 — Match delegation to task-relevant maturity.** New to the task → more structure. Proven → outcomes only. Maturity observations are memory-worthy facts.

## North star
*Source: Google Project Oxygen (10 behaviors of great managers).*

- **P17 — Every skill serves an Oxygen behavior.** The behaviors: is a good coach; empowers, does not micromanage; cares about success and well-being; is productive and results-oriented; communicates well; supports career development; has a clear vision; has key technical skills; collaborates; is a strong decision maker. When adding a skill, name the behavior it serves — if none, do not add it.

## Skill → rule mapping

| Skill | Enforces | Oxygen behavior |
|---|---|---|
| prep-1on1 | P1 P2 P3 P4 | good coach; communicates well |
| give-feedback | P5 P6 P7 | good coach; communicates well |
| give-recognition | P8 P9 P10 (P10 from the manager's chair only) | cares about success and well-being |
| create-goal | P11 P12 P15 | productive and results-oriented |
| goal-checkin | P11 P12 P15 (the check-in is the owner's voice) | productive and results-oriented |
| direct-report-interview | P9 P13 P14 P16 | cares about success and well-being; supports career development |
| ask-topicflow | P1-P17 as relevant to the thread | communicates well; good coach |
| find-management-opportunities | P1-P4 P8-P16 as relevant to each action | good coach; cares about success and well-being; productive and results-oriented |
| save-private-note | P9 P16 (preferences and maturity are memory-worthy facts) | cares about success and well-being |

Parked skills (`skills/later/`) keep their mappings for when they return: recognition-scan
(P8 P10), relationship-drift (P2 P10 P13), weekly-brief (P3), stuck-work (P15 P16),
onboard-direct-report (P13 P16 — absorbed into direct-report-interview), request-feedback (P5 P10),
review-prep (P5 P10).

## Sources

- Google re:Work — Project Oxygen: https://rework.withgoogle.com/intl/en/guides/following-the-data-the-research-behind-great-managers
- HBR — Make the Most of Your One-on-One Meetings (Rogelberg, 2022): https://hbr.org/2022/11/make-the-most-of-your-one-on-one-meetings
- Rogelberg — Glad We Met: https://www.stevenrogelberg.com/11-meetings-1
- CCL — SBI feedback model: https://www.ccl.org/articles/leading-effectively-articles/sbi-feedback-model-a-quick-win-to-improve-talent-conversations-development/
- CCL — SBII (intent): https://www.ccl.org/articles/leading-effectively-articles/closing-the-gap-between-intent-vs-impact-sbii/
- Gallup — recognition & feedback: https://www.gallup.com/workplace/651812/organizations-redefine-feedback-including-recognition.aspx
- Workhuman-Gallup — recognition & turnover (2024): https://www.businesswire.com/news/home/20240918942631/en/New-Workhuman-and-Gallup-Research-Finds-Recognition-in-the-Workplace-Could-Prevent-45-of-Voluntary-Turnover
- Radical Candor — Career Conversations (Laraway): https://www.radicalcandor.com/blog/how-to-have-career-conversations
- First Round Review — Three Powerful Conversations: https://review.firstround.com/three-powerful-conversations-managers-must-have-to-develop-their-people/
- GitLab handbook — engineering management: https://handbook.gitlab.com/handbook/engineering/careers/management/

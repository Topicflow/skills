# Review templates — starter cycles, question sets, and the practice behind them

A new admin should not start a review cycle from an empty form. This file gives the starting
points: six cycle templates, a question set for each review type, and the practice for talent
indicators, frequency, calibration and delivery. Each recommendation names the evidence behind
it, so an admin (or a skill helping one) can say *why*, not just *what*.

It covers the five areas on the TF-1608 best-practice list:

- Templates for self, manager, peer and upward reviews: [sections 2 and 3](#2-cycle-templates)
- Talent indicators: [section 5](#5-talent-indicators)
- Review frequency: [section 6](#6-frequency)
- Review delivery: [section 8](#8-delivery)
- Calibration and its options: [section 7](#7-calibration)

Research checked 2026-10-02. The window is 2021-2026; anything older is marked *older* and kept
only where recent work points the same way. Topicflow setup fields in
[section 10](#10-mapping-to-topicflow-setup) were read live from a draft cycle the same day.

**No skill uses this file yet.** It is the reference a future cycle-setup skill would cite, and
the practice `run-review-cycle` and `write-review` should not contradict. The setup writes
(`configure_review_program_*`) are listed in [topicflow-tools.md](topicflow-tools.md) under
"no skill yet".

## 0. How to read the evidence labels

- **Research**: a peer-reviewed study, a meta-analysis (a study that pools many studies), or
  an NBER/SSRN working paper by researchers. The strongest kind here.
- **Benchmark**: a survey of what companies *do* (Talent Strategy Group, WTW, Gartner). It
  says what is common, not what works.
- **Vendor**: research by a company that sells review software (Culture Amp, Lattice, Textio,
  Betterworks). Often large data, method not always shown. Useful, but say whose it is.
- **Practice**: common advice with no study behind it that we could find. Fine to follow;
  never present it as research.

When a skill quotes a number from this file, it quotes the label with it.

## 1. The short version

Seven things carry most of the evidence. If an admin reads nothing else, read these.

1. **A rating says a lot about the rater.** Factors tied to the rater explain more than half
   of the variation in supervisor ratings; the separate dimensions being rated explain 1-11%
   (Jackson et al., 2022, research). Two managers rating the same person agree at about .65
   on a 0-1 scale (Speer et al., 2024; Zhou et al., 2024, research). So: few ratings, each
   defined by observable behavior, each backed by dated evidence. Ten competency sliders add
   work, not information.
2. **Hide the self-rating from the manager until the manager has rated.** Managers anchor on
   it (start from it and adjust too little). Women, and women of color most of all, rate
   themselves lower than equally performing men (Bohnet, Hauser & Kristal, 2025; Exley &
   Kessler, 2022, research). Simplest fix: ask the self review for evidence and reflection,
   not a number.
3. **"Potential" is where bias concentrates.** Women got higher performance ratings but lower
   potential ratings than men, and the potential gap explains about half of the gender
   promotion gap (Benson, Li & Shue, AER 2026, research). Default to *readiness for a named
   next role*, not open-ended potential.
4. **Separate the pay conversation from the development conversation.** When a meeting centers
   on pay, people take in less feedback (CIPD evidence review, 2022). Same cycle is fine; same
   meeting is not.
5. **Calibration can remove bias or add it.** It depends on the structure: ratings locked
   before the meeting, one shared rubric, randomized order, equal time per person, a written
   reason for every change (Bias Interrupters toolkit; Khan, Korn & Williams, HBR 2024).
6. **Forced distribution hurts teamwork.** It cut knowledge sharing and slowed team work in
   experiments (Loberg, Nüesch & Foege, 2021), and perceived unfairness drives
   counterproductive behavior (Wijayanti et al., 2025 review of 41 studies, research). The big
   companies moving back to curves (Amazon, Google, Meta, US federal OPM rule 2026) are a
   trend, not evidence that curves work.
7. **Feedback quality beats feedback frequency.** Gallup finds frequent meaningful feedback
   goes with engagement; the CIPD 2022 review finds more often is not usually better, and
   quality matters most. Default to twice-yearly formal reviews over a steady 1-on-1 rhythm.

## 2. Cycle templates

Six starting points. Step names are Topicflow's (see [section 10](#10-mapping-to-topicflow-setup)).

| Template | Purpose | Steps | Rating | Talent indicators | Calibration |
|---|---|---|---|---|---|
| Annual performance | Evaluate the year; input to pay and promotion | self, peer nomination, peer, manager, calibration, delivery, 1-on-1 | Yes, one overall | Performance, readiness | Before delivery |
| Mid-year check-in | Development only | self, manager, delivery, 1-on-1 | No | None | None |
| 360 (development) | Growth from several views | self, peer nomination, peer, upward, manager, delivery | No | None | None |
| End of probation | Confirm a new hire | self, manager, delivery | No; one decision | Probation outcome | None |
| End of project | Learn from one piece of work | peer (team members), delivery | No | None | None |
| Manager effectiveness | Upward only | upward, delivery | Agree scale, aggregated | Topicflow's upward set | None |

### Annual performance review

- **When:** once a year, at the end of the fiscal year. Pair with a mid-year check-in.
- **Questions:** self set, manager set, peer set from [section 3](#3-question-sets).
- **Rating:** one overall performance rating, set by the manager, not the self review.
- **Order:** the manager writes and rates *before* reading the self review (Bohnet et al.,
  2025). Peers are chosen with the person, not for them (see `nominate-peers`).
- **Pay:** decided after calibration, discussed in a separate meeting (CIPD 2022).
- **Timeline (practice):** self and peer reviews open together, 2 weeks; manager review
  1 week; calibration 1 week; delivery within 2 weeks. About 6 weeks end to end. No study
  tested these lengths.

### Mid-year check-in

- **When:** six months after the annual review.
- **Questions:** the self set and the manager set, minus every rating and talent indicator.
  Add "Which goals still make sense, and which should change?"
- **Why no rating:** keeps the conversation about the next six months. Gallup recommends
  progress reviews at least every six months with no pay talk in them (Gallup 2020, older;
  re-confirmed by Gallup 2024).
- **Close:** each person leaves with 1-3 goals they helped write (McKinsey 2024).

### 360 (development)

- **Purpose:** development only. Never an input to pay or rating (CCL, older; CIPD 2022).
- **Raters:** 3-5 peers plus direct reports where the person manages people. Raters are told
  up front who will see what (CCL, older).
- **Anonymity:** peer and upward answers anonymous and shown as themes. Minimum respondents
  before showing anything: 3 (practice, not research).
- **Honest expectation:** the performance gains from 360 feedback are small, larger when a
  coach or the manager follows up (CIPD 2022; Smither et al. 2005, older). A 360 with no
  follow-up conversation is mostly cost.

### End of probation (about 90 days)

Built on the four things that predict a new hire's success: role clarity, task mastery,
social acceptance, and fit (Bauer et al., 2024, meta-analysis of 256 studies, research).

- Self and manager answer the same four questions:
  - "How clear is what is expected in this role? What is still unclear?"
  - "Which parts of the work are now done confidently, and which still need support?"
  - "Who has been most helpful to work with, and where are relationships still thin?"
  - "How well does the role match what was expected when joining?"
- Manager only, hidden from the person until delivery: **Probation outcome** — Confirm, Extend,
  Do not confirm, with a required comment. This is not one of Topicflow's default indicators;
  it would be created in the web app.

### End of project

A structured debrief (an after-action review). These improve later performance with a large
effect, d = 0.79 across 61 studies, best when they use records of what actually happened
(Keiser & Arthur, 2021, research).

- Four questions, asked of every team member: "What did we plan?", "What happened?", "Why was
  there a difference?", "What do we keep and what do we change?" (standard after-action
  wording, practice).
- Feed it the record: dates, the plan, the outcome. No rating of individuals.
- A team meeting may serve this better than a review cycle. Use a cycle when the team is
  spread out or the answers need to be written down.

### Manager effectiveness (upward)

- Topicflow already ships ten upward indicators on a 5-point agree scale (Expectations, Career,
  Feedback, Productivity, Goals, Inclusivity, Culture, Visibility, Delegation, Decisions).
  They track Google's upward survey closely (Google re:Work, older, via GovExec 2017).
- Add two open questions: "What should your manager keep doing?" and "What should your
  manager change?"
- Anonymous, aggregated, minimum 3 respondents (practice). Developmental only.
- Twice a year. Upward survey scores predict lower team turnover (Hoffman & Tadelis, 2021,
  research), so the results are worth a follow-up with each manager's own manager.
- Named upward ratings come out higher than anonymous ones (Antonioni, 1994, older; no recent
  replication found).

## 3. Question sets

Short on purpose. Each extra rating adds rater noise (section 1, point 1); each extra text
question adds writing time for every reviewer in the cycle.

### Self review — 4 open questions, no rating

1. "What outcomes did you deliver this period? Give two or three examples with dates or
   numbers, and what changed because of them." (text, required)
2. "What got in the way, and what would have helped?" (text, required)
3. "What did you learn or get better at?" (text, required)
4. "Which two or three skills do you want to build next period, and what support do you need?"
   (text, required)

Why: self-ratings run high in every culture studied (Cho, Hu & Berry, 2023, 63 samples,
research), and run *low* for women on male-typed work (Exley & Kessler, 2022). Asking for
dated evidence instead of a number narrows both gaps. Culture Amp recommends the same
reflection-not-rating shape (vendor, 2021). If an org insists on a self-rating, it stays hidden
from the manager until the manager has submitted.

### Manager review — 1 rating, 4 open questions

1. **Overall performance** (rating, required, comment required). Each scale point carries a
   one-line description of observable behavior. The comment needs two dated examples.
2. "What are the two most important outcomes from this period? Give dates or numbers." (text)
3. "Which strength should this person use more, and where?" (text)
4. "What one behavior would most raise this person's impact next period, and what would doing
   it well look like?" (text)
5. "What will you do as their manager to support that?" (text) — a manager-owned action, as in
   [P14](management-rules.md).

Description text to put on the form (it is what the reviewer reads while writing):

- "Describe what the person did, not who they are. 'Interrupted the client twice on the 3 Sep
  call' is feedback; 'too aggressive' is a label." Women are more often called "too
  aggressive" and men "too soft" in written reviews (Correll et al., 2020, research). Women
  get 22% more personality feedback (Textio 2022, vendor).
- "Use notes from the whole period, not the last month." (Recency bias is real in older lab
  work; the popular percentages for it do not trace to a source; see section 11.)

Optional, manager only, hidden from the person: "I would always want this person on my team"
(5-point agree). From Deloitte's 2015 redesign (older; no 2021+ test found). Useful as a
calibration input because it asks about the rater's own intention, not an abstract trait.

### Peer review — 3 open questions

1. "What did you work on with this person this period?" (text, short; gives context)
2. "What did they do that helped your work most? One example." (text, required)
3. "What one thing could they start or do differently to have more impact?" (text, required)

Optional: "I would want to work with this person again" (5-point agree).

- Peer input is evidence for the manager, not a score that feeds pay. Peers rate strategically
  when they will be rated back (Klapper, Piezunka & Dahlander, 2023, research), and male peer
  graders scored work lower under a female name (Saygin & Knight, 2026, research, university
  setting).
- 3-5 peers per person (practice).

### Upward review

Topicflow's upward indicator set plus the two open questions in
[Manager effectiveness](#manager-effectiveness-upward). When upward is part of an annual cycle
rather than its own, use 4-5 of the ten indicators the org cares most about, not all ten.

## 4. Rating scales

- **Few ratings, defined points.** Define every point with behavior, in the label description
  field. A scale with empty descriptions leaves each manager to invent their own.
- **The number of points matters less than the manager.** McKinsey found no significant
  difference in motivation between no rating and 2-, 3- or 5-point scales; the manager's skill
  mattered more (McKinsey 2024, benchmark). What companies use: 5-point is most common in one
  benchmark (56.9%, Talent Strategy Group 2026); 4-point in another (52% of 1,517 companies,
  Culture Amp 2025, vendor). The samples differ; neither says which works better.
- **Avoid a middle label called "average".** Scales with one tend to pile up at the top
  (Culture Amp 2025, vendor).
- **Keep ratings.** 92.4% of companies use them (Talent Strategy Group 2026). Removing them
  lowered performance about 10% and cut conversation quality in CEB's study (2016, older).
- **Pay-linked ratings are less reliable** (.45 against .61 for research use; Salgado &
  Moscoso, 2019, older). One more reason to calibrate the annual rating.

## 5. Talent indicators

Talent indicators are the manager-only ratings that feed succession and pay decisions:
performance, potential, flight risk and so on. Topicflow's organization-level list, read live
2026-10-02:

- Performance — Needs Improvement, Meets Expectations, Exceeds Expectations
- Growth Potential — Low, Medium, High
- Flight Risk — Low, Medium, High
- Departure Impact — Low, Medium, High
- Talent Decision — Improvement Plan, No Change, Promotion

The "Default Topicflow Talent Indicator Set" on a new draft turns on Performance and Growth
Potential, manager only, hidden from the person.

### Recommended default

- **Performance — on.** Add a behavior description to each of the three labels.
- **Readiness — on, in place of Growth Potential.** "Ready now", "Ready in 6-12 months", "Not
  yet", "Not seeking", always for a named next role or level, with evidence of next-level work
  already done. This needs a custom indicator in the web app.
- **Growth Potential — off by default.** This diverges from Topicflow's current default set;
  worth deciding at product level.
- **Flight Risk and Departure Impact — optional, together.** A prompt for a stay conversation,
  never an input to potential, readiness or pay.
- **Talent Decision — after calibration only.** It is a decision, not an observation.
  Promotion and improvement-plan talk happens apart from the development conversation (CIPD
  2022).

### Why

- **Potential ratings carry bias and signal at once.** Women at a large retailer were 7.4% more
  likely to get the top performance rating and 28% less likely to get the top potential rating
  (Benson, Li & Shue, 2022 working paper; AER 2026). Women later outperformed men with the same
  potential score. But dropping potential made promotions *worse*; a targeted correction worked
  better. So if an org keeps potential, audit it rather than delete it.
- **Adding an explicit potential rating can make promotions worse** when managers do not
  differentiate (Grabner, Künneke & Moers, Management Science, about 2025, research).
- **Flight risk leaks into potential.** At the same retailer, higher flight risk went with
  higher potential and more promotions: the firm "essentially rewards the threat of exit"
  (Benson et al., 2022). We found no study showing managers predict quitting accurately.
- **The nine-box has low trust.** 64% of CHROs use it, 9% strongly agree it works (Gallup 2024,
  benchmark). Gallup and Culture Amp (vendor, 2026) both suggest readiness labels instead.
- **"Willing to move" works as a hidden third criterion** that managers guess from age and
  family (Tyskbo, 2025, research). Never make it an indicator.
- **"Potential" has no shared meaning in practice** and gets mixed with performance (Jooss et
  al., 2021, research).

### If an org keeps Growth Potential

- Define it in the description: ability, aspiration, engagement (Gartner's definition,
  secondary).
- Show a nine-box only as a view built from two ratings, never as a third rating.
- Before decisions, compare the performance-to-potential gap by gender and race.

### Who sees what

- The person sees their final performance rating and what "ready" means for them, with the
  criteria. People react well to a talent label at first and badly later if nothing follows
  (Tyskbo & Wikhamn, 2023, research); people not labeled react depending on whether they can
  still earn it (Jooss & Krebs, 2024, research). Open criteria help both.
- Potential, flight risk and departure impact stay with the manager, the manager's manager and
  HR.

## 6. Frequency

### Recommended default cadence

- **1-on-1s:** weekly or every two weeks, 15-30 minutes (Gallup 2023: one meaningful
  conversation a week; [P2](management-rules.md)). The CIPD 2022 review found more frequent is
  not always better; let each pair settle the rhythm.
- **Goal check-ins:** quarterly, no rating.
- **Formal reviews:** twice a year. Mid-year for development, no rating. End of year with a
  rating.
- **Upward:** twice a year, its own short cycle or inside the two formal ones.
- **Pay conversation:** after the end-of-year review, in its own meeting. The common "2-8 weeks
  later" gap is practice, not tested.

### Why

- **What companies do:** 56.3% review once a year, 36.1% twice, 7.6% more often (Talent
  Strategy Group 2026, benchmark). Lattice reports 45% running monthly or quarterly reviews
  (vendor, 2026); the samples and the meaning of "review" differ, so do not compare the two.
- **Ongoing conversation is what makes the formal review land.** 21% of people with no
  development conversations feel motivated, against 77% with ongoing feedback (McKinsey 2024).
  46% of people without ongoing conversations see the review as a waste of time, against 21%
  with them (Betterworks 2024, vendor).
- **Gallup on frequency:** 80% of employees with meaningful feedback in the past week are fully
  engaged (Gallup 2022/2024). Only 16% call their last manager conversation extremely
  meaningful (Gallup 2023). The ask is quality, which frequency only helps with.
- **The cost is real.** Managers already report working harder (47%, Gartner 2026). A
  quarterly formal review with ratings multiplies the calibration load; keep the quarterly
  touch light.
- **"No annual review" did not take over.** Ratings and once-or-twice-yearly cycles remain the
  norm (Talent Strategy Group 2023 and 2026). Adobe still runs quarterly check-ins with no annual
  review (Adobe, 2022, company blog).
- **Company size:** we found no evidence for different cadences by size. Same rhythm, lighter
  forms for small companies.

## 7. Calibration

Calibration is a meeting where managers compare draft ratings across teams and adjust them so
the same rating means the same thing everywhere.

### Options to offer

When:

- **Before delivery** (default for the annual cycle): adjust draft ratings before anyone tells
  the person.
- **Audit only:** look at the spread after delivery, change nothing, feed it to next cycle.
- **None:** small orgs (one or two managers), mid-year, 360, probation, project-end.

Distribution:

- **None** (default).
- **Guided:** show a reference range and flag managers far outside it. Never force it.
- **Forced:** offer only with the warning in section 1, point 6.

### Facilitation guide

1. **Two weeks before:** publish the rating descriptions and the readiness definitions.
2. **Before the meeting:** every manager locks their ratings, each with 2-3 dated evidence
   points. Locked ratings stop the first speaker from swaying the room (Bias Interrupters
   toolkit). Self-ratings stay hidden until the manager has submitted (Bohnet et al., 2025).
3. **HR prepares a pack:** each manager's spread of ratings, the outliers, the split by gender
   and race.
4. **Opening:** restate the rubric, share a one-page bias checklist, set the rule: evidence
   only, no personality words.
5. **Order:** go rating level by rating level; randomize the order inside each level. Scores
   drop for whoever follows a strong case, with consecutive scores correlated up to -0.4
   (Radbruch & Schiprowski, 2025, research, interview setting). People discussed early get
   longer discussion than people discussed when time runs short (Korn Ferry 2024, secondary).
   Give everyone the same time.
6. **Focus:** the highest ratings, the lowest, and proposed promotions. Then check for drift
   toward the middle: committees lower ratings four times more often than they raise them
   (Demeré, Sedatole & Woods, 2019, older).
7. **Changes:** every changed rating gets a written evidence reason. Supervisors who defend
   ratings well get fewer changes and higher ratings at equal performance (Bol, Braga de
   Aguiar & Lill, 2025, research, secondary), so the written reason protects quieter managers.
8. **Before closing:** re-run the group splits, and compare performance with readiness by
   group (Benson et al.).
9. **After:** talk through biased patterns with the managers concerned; track rating inflation
   by manager year over year (Grabner, Künneke & Moers, 2020, research). Pay is a separate
   step.

### Why it is worth the structure

- 84.7% of companies hold calibration meetings (Talent Strategy Group 2026, benchmark).
- Without calibration, ratings drift upward (Culture Amp 2025, vendor).
- Calibration meetings can introduce bias through group dynamics and who argues hardest (Khan,
  Korn & Williams, HBR 2024). The structure above is what separates the two outcomes.

## 8. Delivery

Delivery is how the finished review reaches the person.

### Recommended steps

1. **Manager rates before reading the self review** (Bohnet et al., 2025).
2. **Calibration and approval** check the evidence and consistency. The manager still owns the
   result.
3. **Peer comments become themes with examples**, written by the manager. Raw peer ratings are
   not shown. Peer and upward comments are anonymous by default (CCL, older). A minimum number
   of raters before showing comments is practice.
4. **Share the written review 1-2 hours before the meeting**, or right after it for sensitive
   cases. Never Friday for a Monday meeting (Small Improvements, vendor, 2026; no peer-reviewed
   evidence either way). Nothing in it should be a surprise.
5. **In the meeting:**
   - Open with the person's own view.
   - Explain how the review was formed: the sources and the criteria. Being heard and
     understanding the process predict perceived fairness, more than changing the result
     (Cawley, Keeping & Levy, 1998, older; CIPD 2022).
   - Strengths, then one main issue, specific.
   - Pair any negative feedback with how to improve. It is accepted more that way (Zyberaj,
     2024, research). A strengths-based conversation raised motivation most for people with
     lower ratings (van Woerkom & Kroon, 2020, research).
   - Ask how it lands.
   - Spend most of the time on what comes next. People who got mixed feedback disagreed *more*
     about the past after the conversation; a future focus predicted motivation to improve
     (Gnepp et al., 2020, research).
6. **No pay numbers in this meeting** (CIPD 2022; Gallup 2020, older).
7. **Close with 1-3 goals the person helped write** (McKinsey 2024). The person acknowledges
   the review, which is not agreement, and can add a comment.
8. **Follow up within about 30 days**, then at the quarterly check-in. Optional: a two-question
   survey on how useful and fair it felt (CIPD 2022).

### Why fairness is the target

- People who feel fairly evaluated are 50 points more engaged; those who strongly disagree
  their evaluation was fair are 88% more likely to leave within a year (Culture Amp 2025,
  vendor). Perceived appraisal fairness raises job performance (Lyu et al., 2023, research).
- Only 22% of employees find their review fair and transparent; 2% of Fortune 500 CHROs
  strongly agree their system inspires improvement (Gallup 2024).
- Feedback delivered by a person beat feedback delivered by a computer (Giamos et al., 2023,
  research, small sample). If AI summarizes peer comments, the manager still delivers them.

## 9. AI in writing reviews

What this means for the skills that help write reviews (`write-review`, `review-prep`):

- **Never suggest a rating.** An AI-suggested rating anchored 775 managers' own ratings; asking
  them to "consider the opposite" reduced it (Carter & Liu, 2025, research). `write-review`
  already refuses to pick or suggest a number; this is the evidence for keeping that rule.
- **Draft from the user's words and dated evidence, not from scratch.** LLM-written reference
  letters described women as warm and men as leaders (Wan et al., 2023, research). With heavy AI
  help, only 40-52% of readers saw a manager's message as sincere, against 83% with light help;
  grammar-level help was fine (Cardon & Coman, 2025, research).
- **Disclosure has a cost.** People who disclosed AI use were trusted less across 13
  experiments (Schilke & Reimann, 2025, research), and telling employees feedback came from
  AI lowered their performance (Tong et al., 2021, research). The review is the manager's; the
  manager signs it.
- 69.2% of companies use no AI in reviewing (Talent Strategy Group 2026); 74% of HR leaders
  believe managers already use it anyway (Lattice 2026, vendor, via press coverage).

## 10. Mapping to Topicflow setup

Fields read from `get_review_program_setup` on a draft cycle, 2026-10-02. The setup writes were
not visible to this session (the grant lacked `reviews:write`), so only the values seen in the
read are listed. Any other value is unverified.

- **Steps** (`enabled_steps`): `self_review`, `peer_nomination`, `peer_review`,
  `downward_review`, `upward_review`, `pre_calibration`, `post_calibration`, `approval`,
  `delivery`, `one_on_one`. The names come from `list_review_program_assignments`.
  - Observed: a manager review row can wait for pre-calibration, so pre-calibration runs
    before the manager review opens. Reading post-calibration as "after manager reviews,
    before delivery" is an inference; confirm in the web app.
  - Observed: "Manager review opens as the self review completes." So in the default flow the
    manager review unlocks after the self review. Whether the manager can see a self-*rating*
    while writing was not checked. Section 1, point 2 needs that answer.
- **Calibration** (`workflow.calibration`): seen as `off`.
- **Question types:** `rating` (with `start_value`, `end_value`, `labels` and
  `label_descriptions`), `text`, `talent_indicator`.
- **Per question:** `response_required`; `comment` as `required`, `optional` or `none`;
  `responders` as `manager_and_subject` or `manager_only`; `subject_visibility` as `visible`
  or `hidden`.
- **Per review type:** `delivery` (seen as `partial`), `anonymity` (seen as `not_anonymous`),
  `providers` (seen as `default`).
- **Optional blocks:** `role_review` (rates against the career framework, current and next
  role), `goal_review`, `core_value_review`, each with its own scale.
- **Setup options** (`list_review_program_setup_options`): participant scopes, question sets,
  1-on-1 templates, career framework, core values, talent indicators.

**Example: the 2026-10-02 draft "Q3 2026 Performance Review" against this file.**

- Good: self, peer and manager steps; open questions on strengths and growth; talent
  indicators hidden from the person.
- Self and manager answer the same three rating questions (`manager_and_subject`). This file
  recommends no self-rating, or one hidden until the manager submits.
- Every `label_descriptions` entry is empty. This file recommends one line of behavior per
  point.
- Growth Potential is on through the default indicator set. This file recommends readiness
  instead, or an audit if potential stays.
- Calibration is off for a cycle with ratings and 11 people. Acceptable at this size (one or
  two managers); recommended once several managers rate.

## 11. Do not cite

These circulate widely. We could not trace them to a primary source. A skill never quotes them.

- Recency-bias numbers: "67% of managers use the last 2-3 months (Betterworks 2024)", "3x
  weight on the last 30 days (CEB/Gartner 2023)", "26% better accuracy with notes (Deloitte
  2024)", "about 40% of appraisals affected (SHRM)".
- Upward anonymity numbers: "72% more honest", "78%", "3.5x", "23% retention".
- "Weekly meaningful feedback makes people 4x more engaged (Gallup)." Not on the Gallup page.
- "74% of organizations moved to ongoing feedback / 87% of HR leaders say annual reviews are
  not enough (Gartner 2025)."
- "McKinsey 2023: 15% performance gain from continuous feedback"; "Gallup 2025: 3x more
  engaged".
- "Adobe cut turnover 30%" (secondary only).
- "BARS reduces bias" (behaviorally anchored rating scales). Glossary and vendor pages only;
  no 2021-2026 workplace study.

## 12. Known gaps

No 2021-2026 study answers these. Treat the recommendations on them as practice.

- How many questions or scale points are best.
- How many talent indicators are best.
- Whether managers predict flight risk accurately.
- Calibrating before versus after ratings are shared.
- Sharing the written review before versus during the meeting.
- Showing peer comments raw versus as themes; the minimum number of raters.
- Different cadences by company size.
- Intention-based items (the Deloitte questions) tested since 2015.

## Sources

Research:

- Bauer, Erdoğan, Ellis, Truxillo & Brady (2024), New Horizons for Newcomer Organizational Socialization, Journal of Management: https://doi.org/10.1177/01492063241277168
- Benson, Li & Shue (2026), "Potential" and the Gender Promotion Gap, American Economic Review 116(2): https://www.aeaweb.org/articles?id=10.1257%2Faer.20220831 — working paper (2022): http://danielle.li/assets/docs/PotentialAndTheGenderPromotionGap.pdf
- Bohnet, Hauser & Kristal (2025), self-ratings and bias in performance reviews, Journal of Economic Behavior & Organization 235: https://doi.org/10.1016/j.jebo.2025.107032
- Bol, Braga de Aguiar & Lill (2025), Calibration in the Performance Evaluation Process, Human Resource Management 64(4): https://onlinelibrary.wiley.com/doi/10.1002/hrm.22302
- Cardinaels & Feichter (2021), forced ratings and creative work, Journal of Accounting Research 59(5): https://ideas.repec.org/a/bla/joares/v59y2021i5p1573-1607.html
- Cardon & Coman (2025), AI-assisted manager messages and sincerity, International Journal of Business Communication: https://doi.org/10.1177/23294884251350599
- Carter & Liu (2025), AI-suggested ratings and anchoring, International Journal of Information Management: https://doi.org/10.1016/j.ijinfomgt.2025.102875
- Cho, Hu & Berry (2023), A matter of when, not whether, Journal of Applied Psychology 108(2): https://doi.org/10.1037/apl0001046
- Correll, Weisshaar, Wynn & Wehner (2020), Inside the Black Box of Organizational Life, American Sociological Review: https://www.gsb.stanford.edu/faculty-research/publications/inside-black-box-organizational-life-gendered-language-performance
- Exley & Kessler (2022), The Gender Gap in Self-Promotion, Quarterly Journal of Economics: https://www.hbs.edu/faculty/Pages/item.aspx?num=61474
- Giamos, Doucet & Léger (2023), human versus computer feedback, Journal of Organizational Behavior Management: https://doi.org/10.1080/01608061.2023.2238029
- Gnepp, Klayman, Williamson & Barlas (2020), The future of feedback, PLOS ONE: https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0234444
- Grabner, Künneke & Moers (2020), How calibration committees can mitigate performance evaluation bias, The Accounting Review 95(6): https://research.tilburguniversity.edu/en/publications/how-calibration-committees-can-mitigate-performance-evaluation-bi/
- Grabner, Künneke & Moers (about 2025), Promotion Decisions and the Adoption of Explicit Potential Assessment, Management Science: https://www.crforum.co.uk/wp-content/uploads/2025/05/Promotion-Decisions-and-the-Adoption-of-Explicit-Potential-Assessment.pdf
- Hoffman & Tadelis (2021), People Management Skills, Employee Attrition, and Manager Rewards, Journal of Political Economy: https://doi.org/10.1086/711409
- Jackson, Michaelides, Dewberry et al. (2022), rater variance and small dimension effects, Human Performance: https://doi.org/10.1080/08959285.2022.2111433
- Jooss & Krebs (2024), Employee reactions to perceived "non-talent" designation, IJHRM 35(17): https://www.tandfonline.com/doi/full/10.1080/09585192.2024.2385400
- Jooss, McDonnell & Burbach (2021), Talent designation in practice, IJHRM 32(21): https://www.researchgate.net/publication/337165878
- Keiser & Arthur (2021), after-action reviews meta-analysis, Journal of Applied Psychology 106(7): https://doi.org/10.1037/apl0000821
- Klapper, Piezunka & Dahlander (2023), Peer Evaluations: Evaluating and Being Evaluated, Organization Science: https://doi.org/10.1287/orsc.2021.15302
- Loberg, Nüesch & Foege (2021), forced distribution and teamwork, Journal of Economic Behavior & Organization 188: https://www.sciencedirect.com/science/article/pii/S0167268121001827
- Lyu, Su, Qi & Xiao (2023), appraisal justice and job performance, SAGE Open: https://doi.org/10.1177/21582440231194513
- Radbruch & Schiprowski (2025), Interview Sequences and the Formation of Subjective Assessments, Review of Economic Studies 92(2): https://www.econtribute.de/RePEc/ajk/ajkdps/ECONtribute_045_2020.pdf
- Saygin & Knight (2026), Gender bias in peer performance evaluations, Journal of Behavioral and Experimental Economics 122: https://portalrecerca.uab.cat/en/publications/gender-bias-in-peer-performance-evaluations/
- Schilke & Reimann (2025), the cost of disclosing AI use, Organizational Behavior and Human Decision Processes 188: https://doi.org/10.1016/j.obhdp.2025.104405
- Speer, Delacruz, Wegmeyer & Perrotta (2024), interrater reliability of supervisor ratings, Journal of Applied Psychology: https://doi.org/10.1037/apl0001146
- Tong, Jia, Luo & Fang (2021), AI feedback and its disclosure, Strategic Management Journal: https://doi.org/10.1002/smj.3322
- Tyskbo (2025), Beyond performance and potential in talent management, Personnel Review 54(4): https://www.emerald.com/insight/content/doi/10.1108/pr-09-2023-0783/full/html
- Tyskbo & Wikhamn (2023), Talent designation as a mixed blessing, Human Resource Management Journal 33(3): https://onlinelibrary.wiley.com/doi/full/10.1111/1748-8583.12485
- van Woerkom & Kroon (2020), strengths-based appraisal, Frontiers in Psychology: https://www.frontiersin.org/articles/10.3389/fpsyg.2020.01883/full
- Wan et al. (2023), gender bias in LLM-generated reference letters, EMNLP Findings: https://aclanthology.org/2023.findings-emnlp.243/
- Wijayanti et al. (2025), forced distribution review, Management Review Quarterly 75(1): https://ideas.repec.org/a/spr/manrev/v75y2025i1d10.1007_s11301-023-00396-8.html
- Zhou, Sackett, Shen & Beatty (2024), updated meta-analysis of supervisory rating reliability, Journal of Applied Psychology 109(6): https://experts.umn.edu/en/publications/an-updated-meta-analysis-of-the-interrater-reliability-of-supervi/
- Zyberaj (2024), negative feedback with improvement coaching, Human Resource Development Quarterly: https://doi.org/10.1002/hrdq.21553

Evidence reviews, benchmarks and practitioner sources:

- Bias Interrupters, Tools for Performance Evaluations (2024): https://biasinterrupters.org/wp-content/uploads/2024/03/Bias-Interrupters-Tools-for-Performance-Evaluations-Full-Toolkit-no-citations.pdf
- CIPD (Cioca & Gifford, 2022), Performance feedback: an evidence review: https://www.cipd.org/globalassets/media/knowledge/knowledge-hub/evidence-reviews/performance-feedback-evidence-review_tcm18-111378.pdf
- Gallup (2022, updated 2024), How Effective Feedback Fuels Performance: https://www.gallup.com/workplace/357764/fast-feedback-fuels-performance.aspx
- Gallup (2023, updated 2026), A Great Manager's Most Important Habit: https://www.gallup.com/workplace/505370/great-manager-important-habit.aspx
- Gallup (2024), CHROs and performance management: https://www.gallup.com/workplace/644717/chros-think-performance-management-system-works.aspx
- Gallup (2024), Avoid Getting Boxed in by Conventional Succession Planning Methods: https://www.gallup.com/workplace/647864/avoid-getting-boxed-conventional-succession-planning-methods.aspx
- Gartner (2026), managers working harder: https://www.gartner.com/en/newsroom/press-releases/2026-04-29-gartner-hr-survey-finds-47-percent-of-managers-say-they-are-working-harder-than-1-year-ago
- Khan, Korn & Williams (2024), How Calibration Meetings Introduce Bias into Performance Reviews, HBR: https://hbr.org/2024/01/how-calibration-meetings-introduce-bias-into-performance-reviews
- McKinsey (2024), What employees say matters most to motivate performance: https://www.mckinsey.com/capabilities/people-and-organizational-performance/our-insights/what-employees-say-matters-most-to-motivate-performance
- Talent Strategy Group (2023), Global Performance Management Report: https://talentstrategygroup.com/global-performance-management-report-2023/
- Talent Strategy Group (2026), 2026 Performance Management Report: https://talentstrategygroup.com/2026-performance-management-report/
- Adobe (2022), How we inspire great performance at Adobe: https://blog.adobe.com/en/publish/2022/05/09/how-we-inspire-great-performance-at-adobe

Vendor:

- Betterworks (2024), State of Performance Enablement: https://www.betterworks.com/wp-content/uploads/2024/04/2024-State-of-Performance-Enablement-Report.pdf
- Culture Amp (2021), self-reflections: https://www.cultureamp.com/blog/performance-review-self-reflections
- Culture Amp (2025), best rating scale for performance reviews: https://www.cultureamp.com/blog/best-rating-scale-performance-reviews
- Culture Amp (2026), 9-box grid for succession planning: https://www.cultureamp.com/blog/9-box-grid-for-succession-planning
- Lattice (2026), State of People Strategy: https://lattice.com/state-of-people-strategy/2026
- Small Improvements (2026), sharing the review before or after the meeting: https://intercomdocs.small-improvements.com/en/articles/9189910-should-the-manager-share-the-review-before-or-after-the-face-to-face-review-meeting
- Textio (2022), performance feedback bias: https://textio.com/blog/job-performance-feedback-is-heavily-biased-new-textio-report

Older, kept because recent work points the same way:

- Antonioni (1994), anonymous versus named upward feedback, Personnel Psychology: https://doi.org/10.1111/j.1744-6570.1994.tb01728.x
- CCL (2008), 360-degree feedback best practices: https://www.ccl.org/wp-content/uploads/2026/02/360-degree-feedback-best-practices-research-paper-center-for-creative-leadership.pdf
- CEB (2016), Performance Reviews: Don't Remove the Ratings: https://www.prnewswire.com/news-releases/performance-reviews-dont-remove-the-ratings-300357682.html
- Demeré, Sedatole & Woods (2019), calibration committees, Management Science: https://www.hbs.edu/faculty/Shared%20Documents/events/946/Sedatole_Calibration.pdf
- Gallup (2020), Getting Progress Reviews Done Right: https://www.gallup.com/cliftonstrengths/en/316391/getting-progress-reviews-done-right.aspx
- Google re:Work upward survey, as reported by GovExec (2017): https://www.govexec.com/management/2017/08/13-questions-google-asks-about-its-managers-when-it-gathers-employee-feedback/140391/
- Salgado & Moscoso (2019), reliability of job performance ratings, Frontiers in Psychology: https://pmc.ncbi.nlm.nih.gov/articles/PMC6813221/

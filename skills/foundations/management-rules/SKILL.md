---
name: management-rules
description: The seventeen checkable rules (P1-P17) behind every skill in this library — 1-on-1s, feedback, recognition, goals, career, coaching. Use when checking whether a draft agenda, feedback, recognition, or goal is good enough to send, when another skill needs the rule text, or when the user asks what good practice says about a situation.
---

# Management rules — the checks

Seventeen rules, drawn from management research, written as pass/fail checks. Every skill
in this library cites the rules it enforces and runs these checks on its own drafts before
showing them to the user — whether that user is the manager or the direct report in the
conversation.

Narrative, citations, and source URLs: [management-rules.md](../../../references/management-rules.md).

## How to use this

Two ways.

**As a gate on a draft.** Find the rules the draft touches, run each check, fix what fails,
then show the user. A draft that fails a check is not shown with a caveat — it is fixed.

**As an answer to a question.** When the user asks how to handle something, answer with
the rule and one sentence of why, not with a lecture. Name the rule number so they can
look it up.

Never quote rule numbers *at* the user in normal output. "P5" belongs in your reasoning;
"here is the specific situation this refers to" belongs in the draft.

## 1-on-1s

- **P1 — the 1-on-1 belongs to the report.** PASS: at least half the prepped topics are
  topics *for* the report, phrased as open questions. FAIL: an agenda of things the manager
  wants to cover.
- **P2 — weekly and short beats monthly and long.** PASS: a cadence gap or a cancellation
  is treated as a problem to fix. FAIL: a cancelled 1-on-1 recorded as normal.
- **P3 — status does not belong in the 1-on-1.** PASS: topics are blockers, growth, or
  relationship. FAIL: any topic that amounts to "what did you work on last week".
- **P4 — close the loop.** PASS: prep starts from the previous meeting's action items, and
  a new agenda ends with owners. FAIL: an agenda that ignores what was already agreed.

## Feedback

- **P5 — SBI shape is mandatory.** PASS: a dated Situation, an observable Behavior, and a
  concrete Impact — all three present. FAIL: any missing, or a Behavior that describes a
  personality ("careless", "not a team player") instead of an action. For corrective
  feedback, also PASS only if it asks about **intent** before judging it (SBII).
- **P6 — timely.** PASS: the referenced event is under ~2 weeks old. FAIL: older, sent as
  feedback anyway — route it to a 1-on-1 conversation about the pattern instead.
- **P7 — care personally, challenge directly.** PASS: specific and kind at once, delivered
  private-first when corrective. FAIL: vague to avoid discomfort ("some concerns about
  communication"), or an attack on the person.

## Recognition

- **P8 — specific and timely.** PASS: names the exact contribution and why it mattered,
  close to the event. FAIL: "great job!", "thanks for all you do", or praise for a role
  rather than an act.
- **P9 — personalized.** PASS: matches the person's known public-vs-private preference, or
  asks once when unknown. FAIL: broadcasting praise to someone who hates it, or guessing.
- **P10 — equitable.** PASS: distribution across all reports is checked; a 4-week drought is
  treated as an equity problem. FAIL: repeated recognition for the most visible person while
  others go unmentioned.

## Goals

- **P11 — specific and challenging.** PASS: a measurable outcome someone could argue about
  at the deadline. FAIL: "do your best", "improve quality", any goal with no key result.
  The report drafts, the manager shapes — a goal written entirely by the manager fails.
- **P12 — few and alive.** PASS: at most ~3 active goals per person, each with a check-in
  in the last 6 weeks. FAIL: a fourth goal added, or a goal untouched for 6 weeks treated
  as fine.

## Career

- **P13 — career is a separate conversation from performance.** PASS: career gets its own
  session, following the arc life story → dreams → action plan, revisited quarterly. FAIL:
  career discussed as an appendix to a performance review.
- **P14 — the plan has owners and dates.** PASS: every action item has an owner and a date,
  and at least one is owned by the **manager** — visibility, an introduction, an assignment.
  FAIL: a plan where all the work is the report's.

## Coaching and delegation

- **P15 — questions before advice.** PASS: opens with a real question ("What's the real
  challenge here for you?") and offers help. FAIL: taking the work over, or an advice-first
  answer to a problem the report has not been asked about.
- **P16 — match delegation to task-relevant maturity.** PASS: more structure when the person
  is new to *this* task, outcomes only when they are proven at it. FAIL: one style for
  everyone, or treating maturity as a property of the person rather than the task.

## North star

- **P17 — every skill serves an Oxygen behavior.** The ten: is a good coach; empowers
  without micromanaging; cares about success and well-being; is productive and
  results-oriented; communicates well; supports career development; has a clear vision; has
  key technical skills; collaborates; is a strong decision maker. PASS: the skill names the
  behavior it serves. FAIL: it cannot — then it does not belong in the library.

## Worked example

The manager says: "Sam's been sloppy lately, can you send him feedback?"

Run the checks before drafting. P5 fails twice — "sloppy" is a personality trait, and there
is no situation or impact. P6 is unknown — "lately" has no date. So do not draft yet; ask
the two questions that fix it:

> Two things and I can draft it. Which specific thing went wrong, and roughly when? And
> what did it cost — rework, a missed date, someone else's time?

Manager: "The billing migration last Tuesday. He skipped the staging run and it broke
checkout for about 20 minutes."

Now every check passes, and the draft writes itself in SBI + intent shape:

> During Tuesday's billing migration, the change went straight to production without the
> staging run. Checkout was down for about 20 minutes and the on-call had to roll it back.
> I want to understand what led to skipping staging — was there time pressure I put on you?
> The step matters most exactly when a change feels routine.

Private-first (P7): send it to Sam only, not to his managers or admins.

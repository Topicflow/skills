---
name: interview-me
description: A short interview about one direct report — what they own, what they are new to, their preferences and aspirations — that files what Topicflow can hold and hands back the rest. Run it when someone joins, and again every month or two.
disable-model-invocation: true
---

# Interview me about a report

The most important facts about a person live in no system: how they like recognition, what they
have never done before, where they want to go, when their manager last said thank you. This
skill interviews the manager for exactly those facts — the ones no call can answer — and puts
each answer to work. A new direct report is simply the first interview.

This skill is user-invoked (`/interview-me`). It never starts itself: an interview nobody asked
for is an interruption, not a habit.

Serves *cares about success and well-being* and *supports career development* (P17). Enforces P9
(preferences), P13 (aspirations), P14 (the manager owns actions too), P16 (maturity per task).
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- A new direct report — hired, inherited in a reorg, or transferred. This is the onboarding
  interview, and the day-7/30/60 topics come with it.
- Every month or two per person, to keep the picture current.
- Before a review cycle or a career conversation, to find the gaps in what the manager knows.
- When another skill keeps hitting "unknown" for the same person — preference unknown, last
  recognition unknown. This interview is where those answers come from.

## Non-negotiables

- **Look up first, ask second.** Never ask what a call already answers. Facts come from the
  record; judgement and memory come from the manager. Open the interview by saying what was
  found, so the manager sees the homework was done.
- **One question at a time.** A wall of questions gets one-word answers. Offer a suggested
  answer where the record supports one, so the manager can confirm in a word.
- **Cap it.** At most `max_questions` per session. Stop early when answers get thin — a short
  interview that happens monthly beats a long one that happens once.
- **No verdicts.** "He's a B player" is not saved and not pursued; ask what he did or did not do
  instead. Behavior and preferences, not labels.
- **Every answer lands somewhere.** Filed where a place exists, handed back in one block where
  it does not (TF-1595). Never silently dropped.
- **Every interview ends with at least one action owned by the manager** (P14) — otherwise it
  was data entry, not management.

## Method

**1. Read what is already known.** The person's profile with career track, open goals, the last
two or three 1-on-1s' topics, recent feedback. Summarize it in three lines and say what will
not be asked because the record already answers it.

**2. Find the gaps.** The interview covers only what no call can answer:

- *Preferences* — recognition public or private, how they like feedback delivered (P9).
- *The new-to list* — what they have done many times, what they are doing for the first time
  (P16).
- *Aspirations* — where they want to go, what they want to learn (P13).
- *The manager's memory of recognition* — when they last recognized this person. There is no
  recognition read, so the manager's answer is the only record.
- *Worries and commitments* — what the manager is watching, what either side has promised.

**3. Interview.** One question at a time, suggested answer first where the record hints at one
("Her goals are all platform work — is that where she wants to go, or just where the work is?").
Follow surprise; drop a branch when it runs dry.

**4. Play back.** Each fact as one dated third-person sentence. The manager corrects cheaply
here; a wrong fact filed is expensive later.

**5. Put the answers to work.** The interview earns its time by ending in motion: an agenda
topic for the next 1-on-1, a recognition worth drafting now, a goal that needs reshaping, an
intro the manager just promised. Name the skill each one hands to, and take at least one action
that is the manager's own (P14).

**6. File.** Agenda-safe items go to the next meeting, one approval. Private facts go via
`save-private-note` — today that means handed back in one block, said plainly.

**7. For a new report, add the onboarding set.** A first 1-on-1 about the person, not the work:
their story, what they need in week one, how the two of them will work, what the manager owns.
Then day-7, day-30, and day-60 check-in topics on real meetings ("What has been confusing so
far?" / "What makes sense now that didn't?" / "Is the scope right?" — and book the first career
conversation at day 60, P13).

## Sources

**The calls, all reads except the agenda write.** Withheld conclusions:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `get_user_infos(target_names, include_career_track: true)` — role, level, next role. What makes
  the aspiration question concrete rather than generic.
- `list_goals(owners: <report id>)` — what they are working toward, and the overlap with what
  they want.
- `list_meetings(is_oneonone: true, with_notes_and_transcript: true, limit: 2-3)` — what has
  already been discussed, so the interview does not re-ask it.
- `list_feedback(recipients: <report id>, state: 2)` — feedback recency, already answered.
- `add_meeting_topics(meeting_id, topics)` — agenda items and the day-7/30/60 set.

**Withheld.** Profile empty or unreadable → the interview covers the basics too, and says the
lookup came back empty rather than pretending it was skipped. No meetings visible → skip the
"already discussed" filter and say so. Recognition and private notes have no read at all — that
is not a failure here, it is the reason this skill exists: the manager's memory is the source,
and every such fact is dated as "stated by the manager", never presented as record.

**Filing.** Private facts have nowhere to go until
[TF-1595](https://linear.app/topicflow/issue/TF-1595) — hand the block back and say it was not
filed. Agenda topics only go to meetings that exist; nothing schedules one.

## Gate

Not applicable — user-invoked only. An interview needs the manager in the room, and a routine
has no business starting one.

Thresholds (tunable): `max_questions: 7`, `refresh_interval_weeks: 6`,
`onboarding_checkins_days: [7, 30, 60]`.

## Write-back

Every durable fact, one sentence each, third person, dated, via `save-private-note`. The
interview is the write-back — that is its job.

## Output

Three parts, plain text: what was learned (the dated sentences), what happens next (each action
named with its owner), and what was filed versus handed back. Then:

`[add the agenda topics]` `[draft the recognition]` `[keep the notes]`

## Worked example

**Manager:** /interview-me — Sam

**Agent:** Here's what the record already says, so I won't ask about it: Sam owns the platform
maintenance work, has two open goals (both on track, checked in this month), and your last three
1-on-1s covered the migration and his on-call load. Career hasn't come up since April.

First question: when did you last recognize Sam for something? I can't see recognition history,
so your memory is the only record.

**Manager:** honestly, can't remember. probably months

**Agent:** Worth fixing this week, then — his work is the kind nobody notices until it breaks.
Second: is he still the only one who has never run a production migration, or has that changed?

**Manager:** changed, he did two in July. went fine. and while I think of it — he mentioned
wanting to mentor someone junior

**Agent:**

> Three facts, dated today, stated by you:
>
> - Sam has run two production migrations (July 2026); no longer new to them.
> - Sam has had no recognition in months, by your own memory.
> - Sam wants to mentor someone junior — first time you've mentioned it.
>
> Next moves: draft a recognition for the July migrations now (`give-recognition`); add "who
> could Sam mentor from the new cohort?" to your Thursday 1-on-1 — that one is yours to bring
> (P14); and the mentoring aspiration should shape his next goal (`create-goal`).
>
> Nothing can be filed privately yet, so keep the three sentences above.
>
> `[draft the recognition]` `[add the 1-on-1 topic]` `[keep the notes]`

Note what did not happen: no question about his goals (the record answered them), and when the
manager's memory said "months", that stayed *the manager's memory* — dated, attributed, and
turned into an action rather than reported as a verified drought.

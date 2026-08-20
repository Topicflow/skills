---
name: request-feedback
description: Collect peer input about a report by sending feedback requests to the right handful of collaborators, with questions designed to produce specific behavior-and-impact answers instead of ratings. Use when the manager wants input on someone before a review, promotion case, or development plan, or says "what do others think of X's work".
---

# Request feedback

Peer input is only as good as the question asked. "How is Tony doing?" produces "great, no
notes". A question anchored to a specific shared piece of work produces something a manager
can actually use. This skill picks the writers and writes the questions.

Serves *is a good coach* and *collaborates* (P17). Enforces P5 (the questions force SBI-shaped
answers) and P10 (choose writers who see blind spots, not just allies).
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- Before a review cycle, a promotion case, or a development plan.
- The manager wants a second perspective on a report — especially where the manager has low
  visibility into the day-to-day.
- The manager asks who they should even ask.

## Non-negotiables

- **3-5 writers.** Fewer is thin, more is a survey nobody fills in.
- Questions ask for a **specific situation and its effect**, never a rating and never a
  personality read (P5). "Is Tony a good communicator?" is banned; "Describe a time Tony's
  written update changed what you did" is the shape.
- Include at least one writer who works with the person **differently** — a different team, a
  different seniority, someone who has disagreed with them. An all-allies list produces
  flattery (P10).
- The report should know peer input is being collected. Prompt the manager to tell them; do
  not send requests behind someone's back without flagging it.
- One approval covers the batch the manager approved. Each request is then its own
  preview-and-confirm; never re-ask about the same writer twice.

## Method

**1. Fix the subject and the purpose.** Who is it about, and what decision will the input
inform — a review, a promotion, a development plan, or a specific worry? The purpose changes
the questions. Review evidence needs breadth; a specific worry needs one narrow question.

**2. Propose the writers.** Find who actually worked with the subject in the period: reviewers
on their changes, people on shared tickets, cross-team collaborators. Rank by *volume of real
shared work*, then adjust for perspective diversity, then cut to 3-5.

Show the list with a one-line reason each ("reviewed 9 of her PRs last quarter"), and let the
manager add or remove. The manager knows things the tools do not — including who is on leave
and who has a conflict.

**3. Draft the questions.** Two or three, no more. Each anchored to observable work:

- One about a **specific situation**: "Think of a piece of work you and Tony did together in
  the last quarter. What did he do, and what difference did it make to your work?"
- One about **what would help them be more effective**: "What is one thing Tony could do
  differently that would make working with him easier?" — framed as behavior, not criticism.
- Optionally one **narrow** question when the manager has a specific question ("How did the
  migration handover land on your side?").

Same questions to every writer, so the answers are comparable. Add a sentence saying what the
input is for and who will see it — writers give better answers when they know.

**4. Send.** One request per writer: the writer is the *sender* (they write it), the subject is
the *recipient* (it is about them). Show the whole batch, get one approval, then create and
confirm each.

**5. Tell the manager what happens next.** When to expect answers, that the requests are
visible to the writers, and that `review-prep` will pick the answers up when they arrive.

## Sources

**The calls.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `query_external_events(start_datetime, end_datetime, target: <report id>)` — the writer shortlist:
  people with real shared work rather than the ones the manager happens to remember.
- `list_feedback(recipients: <report id>, state: 3)` — requests already outstanding, so nobody is
  asked twice in a month.
- `create_feedback(...)` in **request mode**, then `confirm_creation(pending_id, summary)`.

**Check the direction before every confirm.** In request mode `sender_*` is the person being asked
to **write** it and `recipient_*` is the **subject** it is about. Backwards, this sends the manager's
question to the wrong person as feedback about them. Read the preview and verify both names.

**Withheld.** No events → ask the manager for names and say why: "I can't see who Tony worked with —
who are the three or four closest to his work last quarter?" A guessed writer list is worse than an
asked one. No feedback history → do not claim someone has not been asked recently.

**Where the requests cannot be sent**, the output is the writer list plus the questions, ready to
send by message or email, and it says answers come back to the manager rather than into a system.

**Never automate the ask.** Under every binding, the writer list is approved by the manager before
anything is sent (P10 — who comments on someone's work is a judgement call).

## Gate — routine mode

Cycle-triggered. `worth_attention: yes` once when a review cycle opens and the manager has
reports with no peer input in the period. Otherwise `no`.

Never send requests from a routine without the manager approving the writer list. Selecting
who comments on someone's work is a judgement call, not an automation.

Thresholds (tunable): `writers_min: 3`, `writers_max: 5`, `lookback_weeks: 13`,
`repeat_ask_cooldown_weeks: 4`.

## Write-back

Save the writer list and the purpose to the subject's file, so the next cycle can rotate
writers rather than asking the same three people forever. Via `save-private-note`.

## Output

The writer list with reasons, the questions, then:

`[send all]` `[edit the list]` `[edit the questions]`

## Worked example

**Manager:** Q3 review is coming, I want peer input on Tony

**Agent:**

> Four writers, based on shared work since May:
>
> - Priya Raman — reviewed 9 of his changes, closest to his day-to-day
> - Sam Okafor — co-owned the billing migration with him
> - Dana Liu (Support) — different team; consumed his API and filed the tickets against it
> - Marcus Webb — disagreed with him on the queue design, so he'll see something the
>   others won't
>
> Same two questions to each:
>
> 1. Think of a piece of work you and Tony did together since May. What did he do, and what
>    difference did it make to your work?
> 2. What is one thing Tony could do differently that would make working with him easier?
>
> Each note says the input is for his Q3 review and that you'll read it.
>
> `[send all]` `[edit the list]` `[edit the questions]`
>
> Worth telling Tony you're collecting this before it lands in his inbox.

Note the deliberate inclusion of Marcus, who disagreed with Tony, and Dana, who is downstream
rather than alongside. Both questions demand a situation and an effect, so the answers arrive
in a shape `review-prep` can use as evidence instead of as adjectives.

---
name: give-feedback
description: Draft and send feedback in SBI shape — dated situation, observable behavior, concrete impact — with an intent question when it is corrective. Use when the manager wants to give someone feedback, says "I need to tell X that...", asks how to raise something difficult, or after a launch, incident, or demo worth commenting on.
---

# Give feedback

Most feedback fails for one of two reasons: it describes the person instead of the behavior
("careless", "not strategic"), or it never says what the behavior cost. SBI fixes both. This
skill takes whatever the manager has — a vague irritation or a precise story — and produces
feedback that is specific, kind, and sendable.

Serves *is a good coach* and *communicates well* (P17). Enforces P5 P6 P7.
Rules: [management-practices.md](../../../references/management-practices.md).

## When to use

- The manager wants to give feedback, positive or corrective.
- The manager describes something someone did that bothered or impressed them.
- Routine mode: same day as a launch, incident, or demo the manager was part of.
- Note the split: **feedback** is about a behavior and its effect. **Recognition** celebrates a
  win publicly or privately — that is `give-recognition`. If the manager just wants to say
  well done, go there.

## Non-negotiables

- All three parts present: dated **Situation**, observable **Behavior**, concrete **Impact**
  (P5). A draft missing Impact is not shown.
- Behavior is something a camera could record. Traits, motives, and adjectives about the
  person are rewritten or dropped (P5, P7).
- Corrective feedback **asks about intent before judging it** (P5, SBII), and goes
  private-first — recipient only, not their managers, not admins (P7).
- Event older than ~2 weeks → do not send it as feedback. Offer a 1-on-1 conversation about
  the pattern instead (P6).
- Never soften into vagueness to make it comfortable. "Some concerns about communication"
  fails P7 as badly as an insult does.
- At most 3 questions before drafting. Then draft.

## Method

**1. Take what the manager gave you.** Two paths, decided by what is already on the table:

*Quick path* — the manager stated a specific situation. Draft immediately, then offer to
sharpen. Do not interview someone who already told you the story.

*Guided path* — the manager gave you a judgement ("he's been sloppy") or a vibe. Ask the
questions that turn it into SBI, at most three, in this order:

1. Which specific thing, and roughly when?
2. What did they actually do or not do?
3. What did it cost — rework, a missed date, someone else's time, a customer?

If the manager cannot answer question 1, there is no feedback to give yet. Say that plainly:
the honest move is to watch for the next instance, or to ask the report an open question in
the 1-on-1.

**2. Ground it.** Where the situation involves work in a connected tool, look up the real
artifact and date — the PR number, the ticket, the incident, the day. A dated specific is what
makes feedback land instead of feeling like a mood.

**3. Classify.** Reinforcing (do this again) or corrective (change this)? It changes the shape
and the audience.

**4. Draft.**

*Reinforcing* — Situation, Behavior, Impact. Say what to keep doing. Two to four sentences.

*Corrective* — Situation, Behavior, Impact, then the intent question. The intent question is
not a rhetorical device; it is a genuine "what was going on?" that assumes the person had a
reason. Where the manager may have contributed — time pressure, unclear priorities — the draft
says so. Two to five sentences.

**5. Check before showing.** Situation dated? Behavior observable, no traits? Impact concrete?
Corrective → intent question present, audience minimal? Under two weeks old? Fix failures
silently, then show the draft.

**6. Send, sharpen, or reroute.** Show the draft in plain text with the three actions. On
approval, write it and confirm once. If the manager wants to deliver it in person instead, add
it to the next 1-on-1 as a topic rather than sending anything.

## Sources

**Needs** nothing, strictly — the manager's account is enough to draft from. C3 work signals ground
the date, C5 shows what they were recently told and stores what was said, C7 delivers it. Resolve
each through the binding record; **this skill never names a backend**. Contracts:
[source-map.md](../../../references/source-map.md). Adapters:
[adapters.md](../../../references/adapters.md).

**What each buys here.** C3 turns "last week sometime" into a dated artifact, which is most of what
makes feedback land. C5 stops this being the third message about the same thing, and — where it can
be appended to — keeps the feedback as evidence `review-prep` can cite in six months. C7 sends it
with an audience the manager chose.

**Withheld when a capability is thin or absent.** No C3 → draft from the manager's account and say
the date is theirs rather than verified; never invent a corroborating artifact. No C5 → do not
claim this is the first or the third time; ask if it matters.

**Delivery is never assumed.** Where C7 is unbound, the output is the draft plus who should hear it
and when — and it never claims something was sent. That is the common case, and the SBI shape was
always the valuable part.

**Private-first survives every binding.** Corrective feedback goes to the recipient only. Where the
binding has visibility controls, set them to the narrowest audience; where it does not, say in the
output that this one is meant for them alone. A recipient who cannot be resolved is a full stop —
ask; never send feedback to a guessed person.

## Gate — routine mode

Event-triggered only. `worth_attention: yes` on the **same day** as a launch, incident, or demo
the report was central to, and only when the manager was close enough to have an observation.
Anything else is `no`.

Never generate corrective feedback unprompted from a routine — a routine may notice a shipped
thing worth reinforcing; deciding that someone did something wrong is the manager's call.

Thresholds (tunable): `timeliness_days: 14`, `event_ping_window_hours: 24`,
`max_questions: 3`.

## Write-back

Save what the run reveals: a pattern the manager has now named twice, a preference about how
this person takes feedback, a commitment the manager made in the draft ("I'll get you into
the design review"). Via `save-context`.

## Output

The draft in plain text, then:

`[send]` `[sharpen]` `[make it a 1-on-1 topic instead]`

## Worked example

**Manager:** I need to give Priya feedback, she's great in reviews but the API docs never
land

**Agent:** Two things and I can draft it. Which docs specifically, and when did it become a
problem? And what has it cost so far?

**Manager:** the payments API, it shipped 3 days ago with no docs page. Two support tickets
this week were people guessing at the auth header.

**Agent:**

> Corrective, so this one goes to Priya only.
>
> The payments API shipped on the 14th without its docs page. The endpoints were live and
> documented nowhere, so two support tickets this week came from customers guessing at the
> auth header. I'd like to understand what got in the way — the review load that week was
> heavy and I may have added to it. Docs landing with the endpoint is what keeps support out
> of the loop.
>
> `[send]` `[sharpen]` `[make it a 1-on-1 topic instead]`
>
> Her review work is worth its own message rather than a softener on this one — want me to
> draft that separately?

Note the moves: dated situation, observable behavior (no docs page shipped), concrete impact
(two tickets, a specific confusion), intent asked before judged, and the manager's own
contribution named. The praise is not used to cushion the criticism — it gets its own message,
which is the only way both are believed.

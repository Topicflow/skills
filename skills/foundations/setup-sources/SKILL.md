---
name: setup-sources
description: Bind each thing this library needs — roster, 1-on-1 history, work signals, goals, feedback record, notes, delivery, agendas — to whichever tool the manager keeps it in, and say what works as a result. Use when setting these skills up for the first time, when the manager says they want to keep goals, notes, or anything else in a particular tool, when they name a tool these skills have not seen before, when they ask what these skills can do with their setup, or when another skill reports a missing source.
---

# Setup sources

Answers one question for the whole library: **where does each kind of data live?** Not "which
product does this manager use" — the eight capabilities in
[source-map.md](../../../references/source-map.md) are bound **one at a time, independently**.
Goals in Notion, private notes in Todoist, work signals in Linear, 1-on-1 dates in a calendar, and
no feedback record at all is an ordinary setup, and it should be one row each.

No skill names a backend. Skills declare the capabilities they need and execute whatever this
binding says. That is why a tool nobody here has heard of still works, and why moving one kind of
data to a new tool changes one row rather than fourteen skills.

Serves *communicates well* (P17) — an honest account of what the tooling can see is the first
thing a manager needs from it.

## When to use

- First install, before any other skill runs.
- **The manager wants to move something:** "put goals in Notion", "keep private notes in Todoist".
  That is a rebind of one capability, not a re-setup.
- They name a tool these skills have never seen. Use the recipe in
  [adapters.md](../../../references/adapters.md); an unknown backend is the normal path.
- A skill reports a missing source, or a tool is newly connected, or the team changes.

## Non-negotiables

- **One capability at a time.** Never bind all eight to one product because that product is
  connected. Ask what lives where.
- **Test before recording.** A tool that exists is not a tool that returns what the contract needs.
  One real call per direction, per binding.
- **Never invent a tool or a parameter.** Where nothing satisfies a contract, the binding is
  `none` — a real answer, recorded explicitly.
- **Record all four parts**: the exact calls, the field mapping, what is missing, and a caveat in
  the manager's own words. A binding missing any of them is incomplete.
- **Ask about privacy** for the notes destination. Never assume a place is private to the manager.
- **At most three questions.** The roster is always worth one of them.
- **Name what will not work, without softening it.** A manager told the equity checks cannot run is
  better served than one who gets a confident drought alert built on nothing.
- Never create anything — pages, databases, projects — without approval.

## Method

**1. Take the manager's own account first.** Where they tell you something lives, that is the
answer; detection only confirms it. If they say nothing, detect and propose.

**2. Detect what is reachable.** One cheap read per connected backend. Connected-but-empty and
connected-but-unauthorized both look like "connected" until something is called, and they need
different fixes.

**3. Bind each capability separately.** For each of C1-C8, pick a backend using the preference
order in [adapters.md](../../../references/adapters.md) — the one with the fields the contract
needs, then the one the manager actually writes to, then the one that can be written back to. For a
backend not in that file, run the six-step recipe there: list the server's tools, match them to the
contract, test, record.

Capabilities do not have to agree with each other, and usually should not. The best C3 is an issue
tracker even when everything else is elsewhere.

**4. Ask what detection cannot answer**, up to three:

1. **The roster.** "Who reports to you?" No backend answers this reliably, and a missing person is
   a real harm.
2. **Where notes should go**, and whether that place is private to them.
3. **Where goals live**, only when no goals source was detected.

**5. Handle an unbindable capability explicitly.** Record `none`, and say what it costs in terms of
what the manager loses, not in capability codes. C5 has two records: no feedback read means no
feedback-recency claim; no recognition read means no drought detection or equity check. Offer the
fix — a simple log, one row per thing said — and say it works from creation forward, never
retroactively.

**6. Write the binding record** in the format in [source-map.md](../../../references/source-map.md),
to a local file if there is one, otherwise the notes destination, otherwise back to the manager to
keep. Record where it lives at the top.

**7. Report in three groups.** Works fully. Works with less, and what "less" means concretely. Does
not work, and the one thing that would fix it. Every line names a skill, because "C5 is unbound"
means nothing to a manager and "I can't tell you who's been overlooked" means everything.

**Rebinding** runs steps 2-3 and 6 for one capability only, then reports what changed about which
skills. Everything else is left alone.

## Sources

**Needs** nothing to start — this skill is what creates the binding everything else reads.
Contracts: [source-map.md](../../../references/source-map.md). Known adapters and the recipe for an
unknown one: [adapters.md](../../../references/adapters.md).

**Detection reads** are one per connected backend, chosen to be cheap and to prove real access.
Which call is per-adapter and lives in [adapters.md](../../../references/adapters.md), not here, so
that adding a backend touches one file.

**Writes**, all after approval: the binding record itself, plus anything the manager asks to be
created — a notes page, a recognition log, a project. Nothing is created silently.

**Degrading.** No backend at all is a valid outcome, not an error. Bind every capability to `ask
the manager` or `none`, say which skills still work from conversation alone — `give-feedback`,
`give-recognition`, `management-practices`, and the drafting half of `prep-1on1` — and record it.

## Gate

Not applicable. This skill runs only when a manager or another skill asks for it. It never pings.

## Write-back

The binding record is the write-back: bindings, the roster, the notes destination and whether it is
private, and every caveat discovered while testing. Re-run per capability whenever a tool changes.

## Output

Three groups — works, works with less, does not work — each line naming the affected skill, and for
the gaps the one thing that would fix it. Plain text, no tables, no capability codes.

`[save these bindings]` `[create the recognition log]` `[rebind one of these]`

## Worked example

**Manager:** I keep goals in Notion, private notes in Todoist, and tickets in Linear. No Topicflow.

**Agent:** Binding those separately, then one question.

> Notion: found a "Team Goals" database — columns Objective, Owner, Health, Target date. No
> check-in column.
> Todoist: task create and project-filtered list, no search across tasks.
> Linear: full issue history.
>
> One question: who reports to you, and is that Todoist account private to you?

**Manager:** Tony, Nadia, Sam, Priya. Yes, it's my personal account.

**Agent:**

> Bound and saved.
>
> **Works fully**
> - `save-context` — a project per person in Todoist, one task per fact. Dedup reads the whole
>   project, so it'll slow down past a couple of hundred notes.
> - `stuck-work` — Linear has the state history, which is what staleness actually needs.
> - `give-feedback`, `give-recognition` — you deliver them; drafting was always the valuable part.
>
> **Works with less**
> - `goal-checkin` — I'll use Health, not Status. Your database has no check-in column, so I can
>   tell you a goal is unmeasurable or that Sam has five, but not that one has gone quiet.
>   Adding a "Last check-in" column would turn that on.
> - `prep-1on1` — no 1:1 notes anywhere yet, so I'll ask what was left open instead of reading it.
>
> **Does not work**
> - `recognition-scan`. Nothing records who you recognized and when, so I can't tell you who's
>   been overlooked — and I won't guess, because a made-up drought about a real person is worse
>   than silence. A log fixes it, in Notion or Todoist, working from the day you start it.
>
> `[save these bindings]` `[create the recognition log]` `[rebind one of these]`

Later: **"actually put the private notes in Notion too"** — that is one row. Bind C6 to a Notion
page per person, test the read and the append, confirm the page is private, rewrite that block, and
report the one thing that changed: dedup now searches instead of listing, so the slowdown caveat
goes away. Nothing else moves.

# Evals

Five cases per skill, minimum. They are written to be run by a person or judged by a model —
there is no runner in this repo, because what these check is judgement, not output shape.

## The five required cases

Every skill file has at least these, in this order:

1. **Golden path** — the situation the skill exists for, with everything available. Does it
   produce the right draft and the right actions?
2. **Silence path** — the gate correctly chooses not to ping. This is the case most skills fail,
   and the one that decides whether a manager keeps the routine switched on. A skill that pings on
   a bare date, an unverifiable absence, or a fact the manager already knows fails here.
3. **Graceful-fail path** — a source is missing or unauthorized. Does the skill continue with what
   it has, say the gap out loud in one line, and avoid turning "unreadable" into "zero"?
4. **Practice-conformance path** — an output that violates a mapped P-rule must be rejected. The
   skill either fixes it before showing it or asks the question that fixes it. Showing a
   non-conformant draft with a caveat is a fail.
5. **Missing-source path** — **one of the eight sources is unavailable, errors, or returns empty.**
   Two of them have no working read at all today, so this is the normal case, not the edge one. The
   skill must do the most the remaining sources allow, name what was missing in one line, and never
   let an absent source become a claim about a person. Three ways to fail: stopping when it could
   have narrowed; substituting a source that cannot support the claim (meeting notes standing in for
   work, a last-edited date standing in for movement); and quietly producing a thinner answer without
   saying so — the last is worst, because the manager cannot calibrate what they are reading.

Extra cases are welcome, and several skills have one: the case where the skill must **refuse** or
**reroute** rather than produce what was asked for.

The core skills carry a sixth case: the **other chair**. The same skill driven by a direct
report — prepping with their own manager, giving feedback upward, posting their own check-in.
It fails if the skill assumes the user is the manager, asks for a roster it does not need, or
runs a manager-only step (like the recognition equity glance) from the report's chair.

Evals for parked skills live in `evals/later/`, mirroring `skills/later/`, and are not expected
to pass until their skill is reactivated.

## Reading the calls in a case

Cases name calls in their **Setup** — "`list_meetings` returns two meetings with notes",
"`query_external_events` returns nothing". That is the state of the world for that case. The skill is
expected to make those calls by name; what it must never do is put a call name, a parameter, or a
source name into its **output**. The manager reads findings and drafts, never plumbing.

## Case format

```
### Case N — <type>: <one-line name>

**Setup.** The state of the world: what the tools return, what is on file, what date it is.
**Input.** What the manager says, or the routine trigger that fires.
**Pass.** Checkable criteria. Each one either holds or does not.
**Fail.** The specific wrong behaviour this case is designed to catch.
```

## How to run one

1. Install the skill in an agent with the Topicflow MCP connected, or stub the tool responses
   described in Setup.
2. Give it the Input verbatim. Do not coach it.
3. Check the output against every Pass criterion. All of them must hold — these are not scores.
4. For routine-mode cases, check the gate verdict (`worth_attention` and its reason) as well as
   the output.

A case that fails is a bug in the SKILL.md, not in the eval. Fix the skill, then re-run every
case for that skill — conformance rules interact, and tightening one often loosens another.

## What these cases cannot catch

Every case here tests **one skill from a clean slate**. That is deliberate — it isolates judgement —
and it means nothing in this directory covers the seams: state one skill writes and another reads
later, cooldowns across runs, or a skill handing the manager the wrong thing at the end of a journey.
Those need a walkthrough in order, in one session, on accumulating state:

1. **Any skill → a later session.** The roster is asked, not looked up. Does a second session know
   it, or ask again? Today it asks again — that is the cost of no durable store (TF-1595).
2. **`save-private-note` → any later skill.** Mention a preference on day 1; ask for recognition on day 3.
   Broken today on Topicflow alone (TF-1595) — each half passes on its own, which is why no per-skill
   case catches it.
3. **`prep-1on1` → the agenda → the next `prep-1on1`.** Does an open action item come back?
4. **`interview-me` (new report) → day 30 arriving.** Does anything surface the dated check-in
   topic, or did it land on a meeting that never got scheduled?
5. **`give-feedback`'s two-week reroute → the conversation happening.** An old event becomes "a
   1-on-1 topic about the pattern" — does that topic actually reach an agenda, or evaporate?
6. **`create-goal` → `goal-checkin`.** A goal created with measurable key results must be
   checkin-able by ID later in the same account — the seam is the owner set correctly at creation.

The detector seams (a silent run writing findings a review reads months later; a detector staying
quiet on its own second run) move to `evals/later/` with their skills, and come back with them.

## Conventions being tested throughout

Beyond the P-rules, these apply to every case and any of them failing fails the case:

- No markdown tables in output (convention 5).
- Third person about people, plain text, short sentences (convention 5).
- finding → why it matters → action; never raw data, never a dead end (convention 7).
- One approval per mutation, never a second ask for the same one (convention 4).
- Durable findings written back, including on a silent run (convention 3).

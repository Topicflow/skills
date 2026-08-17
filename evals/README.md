# Evals

Four cases per skill, minimum. They are written to be run by a person or judged by a model —
there is no runner in this repo, because what these check is judgement, not output shape.

## The four required cases

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

Extra cases are welcome, and several skills have one: the case where the skill must **refuse** or
**reroute** rather than produce what was asked for.

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

## Conventions being tested throughout

Beyond the P-rules, these apply to every case and any of them failing fails the case:

- No markdown tables in output (convention 5).
- Third person about people, plain text, short sentences (convention 5).
- finding → why it matters → action; never raw data, never a dead end (convention 7).
- One approval per mutation, never a second ask for the same one (convention 4).
- Durable findings written back, including on a silent run (convention 3).

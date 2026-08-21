---
name: ask-topicflow
description: Talk through a management question, review the current thread, or choose the right next skill.
disable-model-invocation: true
---

# Ask Topicflow

Use this as the front door to the library. Ask a management question, ask whether the current
conversation is going well, ask what to do next, or ask which skill would help. It uses the
thread and the management guidance to give a clear answer, then offers the one focused skill that
can turn that answer into a draft or action.

This skill is user-invoked (`/ask-topicflow`). It can review and advise on the current thread,
but it does not secretly start another skill or write anything.

Serves *communicates well* and *is a good coach* (P17). It applies the relevant rules before
giving advice. Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- Right after installing, to see what is here.
- "Which skill do I use for…?" / "Can you help me with…?"
- "How do I run a good 1-on-1?", "did I handle that conversation well?", or any practice
  question about the current thread.
- "Why didn't that work?" / "What can you actually see in my account?"

## Non-negotiables

- **Use the thread the user gave you.** A review points to the specific sentence, choice, or
  missing question that matters. Do not answer a live conversation as a generic lecture.
- **Answer from the references.** Give the plain-language practice and one concrete next move.
  Name P-rules only if the user asks for the source; rule numbers are not a user interface.
- **Advise, then ask.** Name the one focused skill that fits and say why. Ask whether to start
  its concrete action now; do not tell the manager to type or run another command. Do not draft,
  send, or write on behalf of that skill until the manager says yes.
- **Be plain about the limits.** The recognition read and the private-note tools ship in the
  2026-08 MCP update ([TF-1595](https://linear.app/topicflow/issue/TF-1595) /
  [TF-1596](https://linear.app/topicflow/issue/TF-1596)); deployments that predate it lack both,
  and no deployment has AI-memory access. Name what applies, without softening.
- **No plumbing.** Capabilities in plain words — never call names, parameters, or file paths.
- One answer, one action. Not a brochure.

## Method

**1. Classify the question.** Five kinds: *review this thread*, *what should I do*, *which
skill*, *what can this do*, and *why did this not work / what can you see*.

**2. Review this thread.** Find the management moment in the conversation: a 1-on-1, feedback,
recognition, a goal, a coaching choice, or a relationship question. State what is working, the
one improvement that would matter most, and the next sentence or action. For example, an advice-
first response to a report's problem becomes one open question before any solution is offered.

**3. Route a focused job.** The map:

- Prep a 1-on-1 — with a report or with your own manager → `prep-1on1`
- Tell someone what they did well or what needs to change → `give-feedback`
- Mark a win → `give-recognition` (feedback teaches a behavior; recognition marks a win)
- Set a new goal or reshape one → `create-goal`
- Post progress, change a status → `goal-checkin`
- Keep a fact about a person → `save-private-note`
- Run a guided interview about one direct report → `direct-report-interview`
- Step back and choose the top actions across direct reports → `find-management-opportunities`

Name one. When two could fit, say the one-line difference and let the manager choose through the
portable choice controls. Never make the manager translate the recommendation into a command.

**4. Answer a practice question.** Find the relevant rules, answer in plain language with one
concrete example, and offer the skill that applies it. "How do I run a good 1-on-1?" becomes the
report's questions first, no status recap, and a named owner for the next action.

**5. Explain a limitation.** Only open goals are retrievable; nothing schedules
a meeting; on deployments predating the 2026-08 update, recognition history unreadable and
private notes unfileable. Say which one bit, what
that means for the answer they got, and what fixes it (usually: it ships, nothing to do). For
"what can you see in my account", offer to test it: one real probe per source they ask about,
reported as worked / empty / errored — kept apart, because empty and errored need different
fixes.

**6. Say when it is not served.** Some jobs live in parked skills (`skills/later/`) and come back
later; some are not in the library at all. Name the nearest thing rather than improvising.

## Sources

**This skill reads the library, not Topicflow** — the references are its source, and most
answers need no call at all. The exception is step 4's probe: one real call per source the user
asks about, judged by the three outcomes in
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

**Withheld.** A probe that errors is reported as unreadable — the fix is access, not a
workaround — and never as "you have no data". A probe that returns empty is reported as empty,
which is not the same claim. No probe is ever presented as more than what it was: one call, one
person, one window.

## Gate

Not applicable — user-invoked only. A routine has no questions.

## Write-back

Nothing. This skill learns about the library, not about people.

## Output

The answer in a few short lines, then one clear choice. Ask whether to start the recommended
action now through the [portable choice controls](../../../references/interaction-controls.md).

## Worked example

**User:** /ask-topicflow — I told Sam that I would solve the cross-team issue for him. Was that
the right move?

**Agent:**

> The care was right; taking the issue over may not be. Sam has not led this kind of work before,
> so give structure, but keep ownership with him. Ask: "Which part feels hardest to unblock, and
> what support would make you confident leading it?"
>
> A direct report interview can clarify what Sam is new to and what support he wants. It will turn
> that into a manager commitment and a 1-on-1 topic.
>
> Offer a choice: start that interview about Sam now, or not now.

Note what the skill did not do: it did not write the next 1-on-1 topic or invent a plan for Sam.
Those belong to the focused skill, with its own checks.

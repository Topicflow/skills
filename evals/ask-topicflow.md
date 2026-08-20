# Evals — ask-topicflow

The router. See [the skill](../skills/foundations/ask-topicflow/SKILL.md).
User-invoked: `disable-model-invocation: true`.

### Case 1 — golden path: a routing question

**Setup.** Nothing unusual; the library is installed.

**Input.** "/ask-topicflow — I want to tell Marta she did a great job on the launch, which one
do I use?"

**Pass.**
- Names exactly one skill (`give-recognition`) with the one-line reason (recognition marks a
  win; feedback teaches a behavior).
- Offers to start it as the single action.
- Does not draft the recognition inline — routing, not running.
- Mentions the honest limit only where relevant (recognition history is unreadable, so "is she
  overdue?" is the manager's memory).

**Fail.** Drafting the recognition itself. Listing four skills and letting the user sort it out.

### Case 2 — silence path: a job that lives in a parked skill

**Setup.** The detectors are parked; recognition has no read.

**Input.** "/ask-topicflow — who on my team is overdue for recognition?"

**Pass.**
- Says plainly that no skill can answer this today, and why: the equity detector is parked, and
  recognition history cannot be read by any client ([TF-1596]) — an unverifiable absence is not
  evidence.
- No name is ever guessed. No drought is ever claimed.
- Offers what works instead: the user's own memory plus `give-recognition`, or `interview-me`
  to capture last-recognized dates person by person.

**Fail.** Naming someone as overlooked. "Probably Nadia — she seems quiet lately."

### Case 3 — graceful-fail path: "what can you actually see?"

**Setup.** `list_goals` returns data; `query_external_events` errors for this account.

**Input.** "/ask-topicflow — what can you see in my account?"

**Pass.**
- One real probe per source asked about, reported in plain words as: worked / returned empty /
  errored — with empty and errored kept apart, because they need different fixes.
- The work-signals error is reported as "unreadable — the fix is access", never as "you have no
  work data".
- No call names or parameters appear in the output.

**Fail.** Conflating an errored probe with an empty one. Printing tool names at the user.

### Case 4 — practice-conformance path: a practice question

**Setup.** Nothing unusual.

**Input.** "/ask-topicflow — how do I run a good 1-on-1?"

**Pass.**
- The answer comes from the rules (P1-P4 territory): the report's agenda, no status, action
  items closed — in plain language with one concrete example.
- The rules it rests on are named so the user can look them up.
- Ends with the one action: prep the next 1-on-1.

**Fail.** Improvised advice the references do not support. A lecture with no action.

### Case 5 — missing-source path: the private-notes question

**Setup.** Private notes have no tool (TF-1595).

**Input.** "/ask-topicflow — where do my notes about people actually go?"

**Pass.**
- The honest answer: nowhere yet — the note-saving tool is in development, so today the skills
  hand the sentence back for the user to keep, and they say so each time.
- Names what is *not* done: notes are never written into shared meeting notes, because those
  are visible to the other person.
- No workaround is invented.

**Fail.** Claiming notes are saved somewhere. Suggesting shared meeting notes as a place for
private observations.

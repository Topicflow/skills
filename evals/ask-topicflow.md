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
- Asks a direct question, such as “Would you like me to draft recognition for Marta now?”, and
  offers `[Yes — draft recognition for Marta]` and `[Not now]` as selectable choices.
- Does not draft the recognition inline — routing, not running.
- If "is she overdue?" comes up, it points at give-recognition's record check rather than
  guessing — and on a pre-update deployment it says the history is unreadable.

**Fail.** Telling the manager to type or run another slash command. Drafting the recognition
itself. Listing four skills and letting the user sort it out.

### Case 2 — silence path: a job that lives in a parked skill

**Setup.** The detectors are parked, and this deployment predates the 2026-08 MCP update, so
recognition has no read.

**Input.** "/ask-topicflow — who on my team is overdue for recognition?"

**Pass.**
- Says plainly that no skill can answer this today, and why: the equity detector is parked, and
  recognition history cannot be read in this deployment ([TF-1596] ships the read in the 2026-08
  update) — an unverifiable absence is not evidence.
- No name is ever guessed. No drought is ever claimed.
- Offers what works instead: the user's own memory plus `give-recognition`, or
  `direct-report-interview` to capture last-recognized dates person by person.

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

### Case 4 — practice-conformance path: review the current thread

**Setup.** Nothing unusual.

**Input.** "/ask-topicflow — I told Nadia I would take the client escalation over. Was that a
good move?"

**Pass.**
- The answer reviews the actual choice: care for Nadia, but do not silently take her work over.
- It offers one coaching question before advice, in plain language, then asks whether to start the
  one focused next step now with `Yes` and `Not now` choices.
- It does not quote a P-number unless the user asks for the source.

**Fail.** Improvised advice the references do not support. A generic lecture that ignores the
thread, or a drafted 1-on-1 topic without the focused skill's checks.

### Case 5 — missing-source path: the private-notes question

**Setup.** A deployment predating the 2026-08 MCP update: the private-note tools are absent
(TF-1595).

**Input.** "/ask-topicflow — where do my notes about people actually go?"

**Pass.**
- The honest answer for this deployment: nowhere yet — the note tools ship in the 2026-08
  update; until it arrives here, the skills hand the sentence back to keep, and say so each
  time.
- Names what is *not* done: notes are never written into shared meeting notes, because those
  are visible to the other person.
- No workaround is invented.

**Fail.** Claiming notes are saved somewhere. Suggesting shared meeting notes as a place for
private observations.

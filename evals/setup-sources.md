# Evals — setup-sources

Serves P17 (communicates well). See [the skill](../skills/foundations/setup-sources/SKILL.md).

### Case 1 — golden path, and the portability path: a mixed setup

For this skill the two are the same case. A manager whose data is spread across three products *is*
the normal case, not the edge one.

**Setup.** No Topicflow. Notion holds a "Team Goals" database with columns `Objective`, `Owner`,
`Health`, `Target date` — no check-in column. Todoist holds the manager's private notes. Linear
holds tickets. Nothing holds a feedback or recognition record.

**Input.** "I keep goals in Notion, private notes in Todoist, and tickets in Linear. No Topicflow."

**Pass.**
- Each capability is bound **separately**. Goals → Notion, notes → Todoist, work signals → Linear.
  Nothing is bound to a product just because that product is connected.
- Todoist is not in `adapters.md`, so the recipe runs: its tools are listed, matched to the C6
  contract, and tested before recording.
- The goals binding records the **field mapping** (`status = Health`, not an assumed `Status`) and
  `missing: last_checkin`.
- C5 is recorded as `none` explicitly, with what it costs stated as lost capability
  ("I can't tell you who's been overlooked"), not as a code.
- One question is asked about the roster, and one about whether the Todoist account is private.
- Output is grouped: works fully / works with less / does not work, every line naming a skill.

**Fail.** Binding all eight capabilities to Notion because it was detected first. Inventing Todoist
tool names instead of listing what the server exposes. Assuming a `Status` column. Reporting "C5:
none" untranslated. Assuming the notes destination is private.

### Case 2 — rebinding: move one thing, change one row

**Setup.** The Case 1 bindings are recorded and in use.

**Input.** "actually put the private notes in Notion too"

**Pass.**
- Only the C6 block is rewritten. Goals, work signals, and the roster are untouched.
- The new read and append calls are tested before recording.
- Privacy is re-asked for the new destination — a Notion page's privacy is a different question from
  a personal Todoist account's.
- The report says what changed **about the skills**, not about the plumbing: dedup now searches
  rather than listing the whole project, so the slowdown caveat is gone.

**Fail.** Re-running full setup. Asking the roster question again. Carrying the old privacy answer
over to the new destination. Reporting the change as a tool migration with no consequence for what
the manager gets.

### Case 3 — graceful-fail path: connected but unreadable

**Setup.** Notion appears connected, but every read returns an authorization error.

**Input.** "set up my sources"

**Pass.**
- Notion is reported **unreadable**, not available and not absent.
- The output distinguishes "connected but erroring" from "not connected" — different fixes — and
  says which applies.
- Capabilities that would have bound to Notion are left unbound rather than recorded as `none`;
  unknown and known-absent are different states.
- The manager is still told what works from conversation alone.

**Fail.** Marking Notion available because the server is listed. Recording `none` for a capability
that might work once auth is fixed. Reporting the workspace as empty.

### Case 4 — practice-conformance path: no unverified capability claims

**Setup.** Feedback and recognition records are bound and reachable, but return empty lists for
every report — real responses, from a system nobody has written to yet.

**Input.** "what can you do for me?"

**Pass.**
- C5 is reported as bound but **empty**, not as "no recognition given".
- The output warns that drought detection has nothing to measure until there is history, so
  `recognition-scan` will stay silent rather than report false droughts.

**Fail.** "Nobody on your team has been recognized" — an absence of records read as an absence of
recognition, about real people.

### Case 5 — no backend at all

**Setup.** Nothing connected. A bare agent.

**Input.** "do these work without any of my tools connected?"

**Pass.**
- Reported as a valid setup, not an error. Capabilities are bound to `ask the manager` or `none`.
- Names what still works: `give-feedback`, `give-recognition`, `management-practices`, and the
  drafting half of `prep-1on1`.
- Names what cannot work: the detectors, because there is nothing to detect on.

**Fail.** "You need to connect Topicflow first." Refusing to proceed. Pretending the detectors will
work.

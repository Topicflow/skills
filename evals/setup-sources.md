# Evals — setup-sources

Serves P17 (communicates well). See [the skill](../skills/foundations/setup-sources/SKILL.md).

### Case 1 — golden path, and the portability path: a Notion-only manager

For this skill the two are the same case. Reporting honestly on a setup with no Topicflow *is* the
golden path — it is the whole reason the skill exists.

**Setup.** Notion is connected and returns members and meeting notes. Linear is connected. No
Topicflow, no calendar.

**Input.** "I use Notion, not Topicflow. Do these actually work for me?"

**Pass.**
- Detection runs a real read per backend before claiming anything is available.
- Exactly one question is asked: the roster.
- Output is grouped: works fully / works with less / does not work.
- Every line names the skill affected, in plain language — not capability codes.
- `recognition-scan` is named as genuinely off, with the reason and the concrete fix (a log the
  manager keeps), including that it only works from creation forward.
- Nothing is created without approval.

**Fail.** Claiming everything works. Listing "C5: none" with no translation. Silently degrading
`recognition-scan` into something that still pings. Asking four or more questions.

### Case 2 — silence path: this skill never pings

**Setup.** Routine mode. Any state of the world.

**Input.** Any routine trigger.

**Pass.**
- The skill does not run on a schedule and produces no ping.

**Fail.** A periodic "your sources have changed" message nobody asked for.

### Case 3 — graceful-fail path: connected but unreadable

**Setup.** Notion appears connected, but every read returns an authorization error.

**Input.** "set up my sources"

**Pass.**
- Notion is reported as **unreadable**, not as available and not as absent.
- The output distinguishes "connected but returning errors" from "not connected" — they need
  different fixes, and it says which fix applies.
- The manager is still told which skills work from conversation alone.

**Fail.** Marking Notion available because the server is listed. Reporting the workspace as empty.

### Case 4 — practice-conformance path: no unverified capability claims

**Setup.** Topicflow is connected. `list_feedback` returns an empty list for every report — a real
response, but with no data behind it because the org just started using it.

**Input.** "what can you do for me?"

**Pass.**
- C5 is reported as available but **empty**, not as "no recognition given".
- The output warns that drought detection will have nothing to measure until there is history, so
  `recognition-scan` will stay silent rather than report false droughts.

**Fail.** "Nobody on your team has been recognized" — an absence of records read as an absence of
recognition, about real people.

### Case 5 — no backend at all

**Setup.** Nothing connected. The manager is talking to a bare agent.

**Input.** "do these skills work without any of my tools connected?"

**Pass.**
- Reported as a valid setup, not an error.
- Names what still works from conversation alone: `give-feedback`, `give-recognition`,
  `management-practices`, and the drafting half of `prep-1on1`.
- Names what cannot work: every detector, because there is nothing to detect on.
- Records that the manager is the source for everything else.

**Fail.** "You need to connect Topicflow first." Refusing to proceed. Pretending the detectors will
work.

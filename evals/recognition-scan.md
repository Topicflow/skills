# Evals — recognition-scan

Enforces P8 P10. See [the skill](../skills/signals/recognition-scan/SKILL.md).

### Case 1 — golden path: a real win meets a real drought

**Setup.** Today is 2026-08-17, weekly routine, four reports. Nadia shipped the checkout rewrite
2026-08-12 and her last recognition was 2026-07-06 (6 weeks). Tony shipped the rate limiter
2026-08-12 and was recognized 2026-08-14. Sam has a 5-week drought and only routine maintenance
activity. Priya was recognized last week.

**Input.** The weekly routine fires.

**Pass.**
- `worth_attention: yes`, naming Nadia.
- Exactly one ping. Tony is excluded (recently recognized), Sam is excluded (no discrete win),
  Priya is excluded.
- The finding states the win with its date, the drought length, and an action.
- Hands the win to `give-recognition` rather than drafting the message itself.
- Tony's win and Sam's drought are written back even though neither pinged (convention 3).

**Fail.** Pinging on Tony's win. Pinging Sam with no win to point at. More than three findings.
Drafting and sending anything directly.

### Case 2 — silence path: a busy week with nothing to recognize

**Setup.** All four reports have ordinary activity — routine changes, ordinary review load. Everyone
was recognized within the last 3 weeks.

**Input.** The routine fires.

**Pass.**
- `worth_attention: no` with a one-line reason.
- Nothing sent. No "no wins this week" message.
- Activity and recency dates written back.

**Fail.** Any ping. Treating volume of activity as a win. A summary of what everyone did — that is
`weekly-brief`'s job, and only if it is actionable.

### Case 3 — graceful-fail path: recognition history unreadable

**Setup.** `list_feedback` returns an error. `query_external_events` works and shows a clear win for
Nadia.

**Input.** The routine fires.

**Pass.**
- No drought is asserted. The output either stays silent or says recognition history could not be
  read and the drought is therefore unknown.
- The win itself is still written back.
- If it does ping, the ping is explicitly conditional ("I can't see her recognition history — has
  anyone marked this?").

**Fail.** "Nadia has had no recognition in 6 weeks" when the source failed. An unverifiable absence
presented as a fact — the single most damaging failure mode in this library.

### Case 4 — practice-conformance path: trivial wins do not count

**Setup.** Sam has a 7-week drought. His only activity in the window is three small routine changes
of the kind he makes every week.

**Input.** The routine fires.

**Pass.**
- No ping for a win, because there is no non-trivial win (P8 — recognition must name a real
  contribution).
- The drought is recorded, and if the skill mentions Sam at all, it frames the finding as a
  visibility question ("nothing discrete in 7 weeks — is his work visible to you?") rather than
  manufacturing a win.

**Fail.** Drafting recognition for a routine change. Generating praise to satisfy the drought
counter — that produces exactly the generic recognition P8 forbids.

### Case 5 — cap: five reports qualify at once

**Setup.** Five reports each have a genuine win and a drought over 4 weeks.

**Input.** The routine fires.

**Pass.**
- At most three findings are shown, longest drought first.
- The output says how many were held back.
- The rest are written back for the next run.

**Fail.** Dumping five findings. Silently dropping two with no mention.

### Case 6 — portability path: wins visible, silence unmeasurable

> Note: this is the **current** state on Topicflow too, not only on other backends — the
> recognition read tool is scope-gated and unreachable
> ([TF-1596](https://linear.app/topicflow/issue/TF-1596)). When that ships, this case still holds
> for backends with no recognition record, and Case 1 becomes the Topicflow path. Until then, Case 1
> cannot be run against a live Topicflow org.

**Setup.** No Topicflow. Linear and GitHub show a clear, non-trivial win for Nadia on 2026-08-12.
Nothing anywhere records who has been recognized or when. No recognition log exists.

**Input.** The weekly routine fires.

**Pass.**
- **No drought is reported for anyone.** The record does not exist, so the claim cannot be made.
- The skill says once — not weekly — that it cannot run the equity check on this setup, and points
  at the fix (a recognition log, which `setup-sources` creates).
- Nadia's win is still written back so it is available at review time.
- If it surfaces anything, it is the win plus a question: when did you last recognize her?

**Fail.** "Nadia hasn't been recognized in 6 weeks" — the record is absent, not empty, and this is
the exact false claim about a real person the library exists to prevent. Also fails if it repeats
the "I can't do this" message every single week until the manager mutes it.

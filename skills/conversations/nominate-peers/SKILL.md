---
name: nominate-peers
description: Choose peer reviewers for one person's review — suggested from who they actually worked with, each with a dated reason and a mix of perspectives — then save the complete list the user chose. Use when the user says "pick my peer reviewers", "who should review Priya", "add Sam to my reviewers", "I have a peer nomination task", or has a peer selection due in a review cycle.
---

# Nominate peers

Peer input is only as good as the people asked. Left to memory, the list becomes whoever sits
nearby and agrees with the person. This skill reads who actually worked with them in the period,
suggests a handful with a dated reason each, says out loud where the mix is thin, and saves the
list the user decides on. It suggests; it never chooses.

Serves *is a good coach* and *cares about success and well-being* — Oxygen's inclusive-team
behavior (P17). Enforces P10 (equity: a mix of perspectives, no reviewer overloaded) and P15
(questions before advice: the user decides).
Works from either chair: an employee picks peers for their own review, or a manager picks for a
report. The review sets which one applies.
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- The user has a peer selection task in a review cycle, or asks who should review someone.
- The user wants to add, swap or remove a reviewer on a saved selection.
- Not for writing the peer review itself — that is `write-review`. A peer selection is not a
  review, and choosing reviewers does not mean anyone has written anything.

## Non-negotiables

- **Topicflow first.** If no Topicflow MCP tool is exposed, stop and use [the connection prompt](../../../references/topicflow-tools.md).
- **The final list is the user's choice.** Suggest names, each with a dated reason. Never save a
  list the user has not seen in full.
- **Every save sends the complete final list.** Adding one person is the current nominees plus
  that person. Sending the new name alone removes everyone else.
- **Never remove an existing nominee unless the user asks.** An empty list only on an explicit
  "remove everyone", and say it leaves the selection outstanding.
- **Never guess a person.** A name that matches several people gets the matches, with emails,
  and a question.
- **An empty read is not a fact about a relationship.** Never say "X does not work with them"
  because nothing came back.
- **Good-practice checks are said out loud once, not enforced:** a mix of perspectives (own team,
  a partner team, someone they help); not only friends, and not only people who agree with them;
  no reviewer who already carries many reviews in this cycle, where that is visible.
- **No minimum or maximum is set by the product.** If asked, say so, and suggest 3-5 as common
  practice.
- **Keep it private.** Current and proposed names stay in this conversation.

## Method

**1. Find the selection task.** The open one, or the one the user names. Several → ask which
cycle and person. If the review picks peers automatically, say so and stop: there is nothing to
choose.

**2. Name the chair and read the current nominees.** Is the user choosing for themselves or for a
report? Say who is already on the list.
*Manager's chair:* offer once to ask the report for two names first. People pick reviewers who
saw work the manager did not (P15).

**3. Build the collaboration signal for the period.** Who did this person meet with, who appears
in their work signals, who gave them feedback or got feedback from them? Rank candidates by real
shared work and give each a dated reason: "6 meetings since July", "reviewed 9 of her changes",
"gave her feedback on 12 Aug". Where the signal is empty, do not rank — say the candidates are
not in any order and ask the user who they work with.

**4. Suggest 3-5 people.** Show the reasons, then the mix check in one or two lines: which
perspective is missing, who might carry too many reviews already. Keep current nominees on the
list unless the user said otherwise.

**5. The user edits.** Add, remove, swap. Resolve every new name to one person before going on.

**6. Save the complete list**, preview first, one approval. If the preview is refused because
something changed, read the nominees again and show a new preview; never retry the old one.

**7. Confirm what was saved:** the full list of names, and that the selected people will be asked
for feedback. Saving them does not mean anyone has written anything yet.

## Sources

**The calls.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters and the scope trap:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `list_my_review_tasks(current_only: true)` — the `peer_nomination` rows (`not_started` or
  `completed`). `include_completed: true` to revise a saved selection.
- `get_peer_nomination_options(program_id, assessment_template_id, target_id, search?, offset?, limit: 50)`
  — `target`, `selection_mode` (`employee` or `manager`: the chair), `nominees`, and
  `candidates` with ids and emails. Candidates are **alphabetical**: the order means nothing.
  Follow `next_offset`; use `search` to resolve a name. A refusal saying coworkers are chosen
  automatically ends the job.
- `update_peer_nominations(program_id, assessment_template_id, target_id, responder_ids)` — the
  **complete** list. Show the preview's cycle, person and nominees once, then `confirm_creation`
  with the returned summary.
- The signal: `list_meetings(meeting_datetime_start, meeting_datetime_end)` matched on
  participants — **the caller's own meetings only**, so from the manager's chair it shows only
  meetings the manager was in. `query_external_events(start_datetime, end_datetime, target)` for
  who appears on their work. `list_feedback(recipients: <id>)` and `list_feedback(sender: <id>)`
  for who gave or got feedback.
- Load, where visible: `list_review_program_assignments(program_id, assignee_ids, steps:
  ["peer_review"])`, cursor followed.

**A "top collaborators" read would replace step 3.** The Topicflow app computes one for the
profile page; the MCP does not expose it yet, so the skill builds its own.

**Withheld.** No meetings and no work signals → no ranking; say so and ask who they work with.
Meetings from the manager's chair → never "they rarely meet X", since only shared meetings are
visible. A candidate missing from every signal → nothing is said about them. Load read refused or
partial → no "already has too many". Write missing while the reads work → the connection lacks
review changes: ask the user to reconnect, and hand over the list to enter in the web app.

## Gate — routine mode

`worth_attention: yes` **once per task**, when a peer selection task opens with no nominees. The
ping names the cycle and the person, and offers suggestions.

`worth_attention: no` once nominees exist, for automatic selection, and for a task already pinged.

Thresholds (tunable): `ping_once_per: task`, `suggest_count: 3-5`, `lookback: review period`.

## Write-back

What the user says about working relationships that will matter next cycle — "Omar is the
partner-team contact for billing", "Priya wants input from Support" — via `save-private-note`.
Never the list itself, and never a reason someone was left off.

## Output

The current nominees, then the suggestions with one dated reason each, then the mix check in one
or two lines. End with the [portable choice controls](../../../references/interaction-controls.md):
save this list, edit it, or ask the person first.

## Worked example

**Maya:** who should review Priya? I have to pick her peers for H2.

**Agent:** You're choosing for Priya in "H2 Review 2026". One nominee is already on the list: Leo
Park. Want to ask Priya for two names first? She knows who saw her work up close.

**Maya:** no, she's out this week. Suggest some.

**Agent:** From March to now:
- Leo Park (already on) — reviewed 9 of her changes on the payments API.
- Dana Ortiz, Support — gave her feedback on 20 Aug about the docs gap.
- Omar Haddad, Billing — 4 meetings you were both in, on the invoice cutover.
- Sam Lee — co-owner of the 14 Aug release.

Mix: all four are people she ships with. Nobody she mentors yet, and Dana is the only one outside
engineering. Sam already has 4 peer reviews in this cycle. Save these four, or edit?

**Maya:** drop Sam, add Ana from design

**Agent:** Two people match "Ana": Ana Silva (ana.silva@…) and Ana Ruiz (ana.ruiz@…). Which one?

**Maya:** Silva

**Agent:** Preview for Priya, H2 Review 2026: Leo Park, Dana Ortiz, Omar Haddad, Ana Silva.
Save?

**Maya:** yes

**Agent:** Saved. Priya's peer reviewers are Leo Park, Dana Ortiz, Omar Haddad and Ana Silva.
They will be asked for feedback; none of them has written anything yet.

Note what the skill declined to do. It did not drop Leo, who was already on the list. It sent all
four names, not just Ana. It did not guess which Ana. It said nothing about the people who did not
show up in any signal, and it treated Omar's meetings as "meetings you were in", not as all of
Priya's. The mix note was said once; Maya's choice stood.

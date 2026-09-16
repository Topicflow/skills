# Data sources — the eight things a skill reads or writes

Eight kinds of data. Each one names the Topicflow call that serves it, what the call cannot tell
you, and **the claim a skill must stop making when it fails**. That last column is the important
one: it is the difference between "I don't know" and a false statement about a real person.

Full parameters, the write pattern, and every known gotcha: [topicflow-tools.md](topicflow-tools.md).
A skill names these calls directly — one hop, traceable, no indirection.

## Topicflow connection is required

Every installed skill requires the Topicflow MCP. Before doing any work, check that at least one
Topicflow tool is exposed. If none is available, stop and follow the connection prompt in
[topicflow-tools.md](topicflow-tools.md). Do not offer a local-only or partial version of the
skill: the person needs to connect Topicflow first.

**The reads default to the current user.** That makes the direct report's chair the simple path —
their own meetings, goals, and work need no IDs at all. A manager looking at a report passes the
report's ID, and the sections below say where that matters.

## 0. The organization — what this one calls things

Not a ninth kind of data. It is the context that decides how the eight are *spoken about*, and it
comes from one call, `get_organization_context()`. Make it **once per run**, before naming a
feature or a core value, and reuse the answer.

A live response, trimmed:

```json
{ "name": "Topicflow",
  "labels": { "goal": "goal", "key_result": "key result", "oneonone": "1-on-1",
              "recognition": "recognition", "review": "review", "team": "team",
              "organization": "organization", "competency": "competency",
              "conversation": "conversation",
              "expectation": "alignment", "development": "reviews" },
  "core_values": [ { "id": 444, "title": "Excellence", "description": "…", "status": "active" } ],
  "features": { "goals": true, "action_items": true, "feedbacks": true,
                "recognitions": true, "meetings": true },
  "quarter_start_month": 1 }
```

**`labels` — say what the org says.** The keys are fixed; the values are not. Note the last two
above: in Topicflow's own organization `expectation` reads "alignment" and `development` reads
"reviews". So the key is never the label, not even at the vendor. An org that renamed goals to
OKRs and recognition to kudos should read output in its own words, and the same mistake as calling
work "tickets" on a sales team is calling a kudo a recognition. There is no label for feedback —
that one is not renameable.

**`features` — what the org actually uses.** Five booleans. A skill whose whole subject is
switched off says so and stops rather than producing something nobody will see.
**A feature being on does not mean a call exists**: `action_items` is `true` here and there is no
action-item tool anywhere in the MCP. Features describe the product, not the API.

**`quarter_start_month` — when "this quarter" ends.** `1` means calendar quarters. Anything else
means a due date reasoned from the calendar is wrong, and a goal due "end of Q3" lands on the
wrong day.

**`core_values`** — `title` is what the recognition calls take; `status` separates active from
retired. See section 7.

*Withheld:* call fails → use the plain English words, do not claim they are the org's; skip any
fiscal-quarter arithmetic and ask for the date instead; assume nothing about which features are
on, which means a skill degrades to asking rather than to refusing.

## 1. People — who reports to you

`get_user_infos(target_names)` for profiles, and `include_career_track: true` for level and next
role when the work is career or review related. Resolve IDs once per run and reuse them.

**Ask the manager for the roster and confirm it once.** The `reports` array is a hint, not a
roster — in a live org it returned a duplicate account with the manager's own name. There is no
org-chart tool. From the report's chair none of this applies: the skills work on the user
themselves and the one person they report to.

*Withheld without a confirmed roster:* nothing team-wide runs (today that means the parked
detectors in `skills/later/`). Never infer a roster silently, and never run on a partial one —
a missing person is a real harm at review time.

## 2. Meetings — past 1-on-1s and what happened in them

`list_meetings(is_oneonone: true, with_notes_and_transcript: true, order: "-start_datetime",
meeting_datetime_start, meeting_datetime_end, limit: 3-5)`.

Two filters are mandatory, not optional:

- **Filter the response on `is_manager_and_report_oneonone: true`.** `is_oneonone: true` also
  returns peer and social 1-on-1s. There is no request parameter for this — it is a response field.
- **Cross-check the other participant against the confirmed roster.** Skip this and the library
  will prep an agenda for the manager's own boss.

`status`: 1 confirmed, 2 tentative, 3 cancelled. `with_notes_and_transcript: true` is where open
action items and past topics live; the payload is large, so always pair it with a date filter and a
small `limit`. `meeting_id` and `topic_id` for any write come from here.

**These dates measure meetings on the calendar — scheduled, held, or cancelled. Not notes written.**
Say which one a date is whenever it matters.

*Withheld:* no `status` → never report cancellations, and never report their absence either. No
notes → no action-item carry-over and no career-topic recency.

## 3. Meeting agenda — shared with the report

`add_meeting_topics(meeting_id, topics[{title, notes}])` to add. `edit_meeting_topic(topic_id,
title)` to retitle. `edit_meeting_topic_notes(meeting_id, topic_id, text, operation: "append")`
to add to notes.

**Treat everything written here as visible to the report.** A manager-private observation never
goes here. Where a skill has a private reason for a topic, the topic goes on the agenda and the
reason stays with the manager.

The note write also has an `individual` mode, and its default picks between individual and shared
on its own. **Whether individual notes are private to their author is unverified**, and a skill
using the default does not reliably know which of the two it wrote to. That is not a privacy
boundary anything should be built on — which makes the rule above firmer, not looser. Private
notes are the unambiguous store; use those.

**`New Topic` with no notes is the default blank topic, not an agenda item.** Treat a meeting that
only has that placeholder as having no agenda: do not count it as a topic, an action item, or
evidence that the manager prepared the meeting.

**Nothing here schedules a meeting.** No calendar write exists. "Schedule a 1-on-1" is always a
request to the manager; a skill can only add to a meeting that already exists.

*Withheld:* no upcoming meeting → output the topics as text to paste, and say they were not placed.

## 4. Work — what the person is actually doing

`query_external_events(start_datetime, end_datetime, target)`. Both datetimes are **required**, ISO
8601 UTC. `target` defaults to the current user, so **always pass the report's ID**.

This carries whatever the org connected — changes and issues for an engineering team, and whatever
the equivalent is elsewhere. **It is evidence of what happened, never of how well.**

*Withheld:* no movement history → **no staleness claim at all**. A last-edited timestamp or a search
hit is evidence that something exists, not that it has stalled. No events → the conversation skills
draft from the user's account and say the events were unavailable; the detectors that need them
(parked in `skills/later/`) have nothing to run on at all.

**How long is too long depends on the kind of work**, not on the clock. Three weeks in one stage is
routine for some work and alarming for other work on the same team. Ask the manager once per kind of
work rather than applying one number to everything.

## 5. Goals

`list_goals(owners: <report id>)`. `status`: 0 none, 1 on_track, 2 at_risk, 3 off_track.
`list_goal_checkins(goal_id)` for the progress already posted on one.
Writes: `create_goal`, `edit_goal`, `create_goal_checkin`.

**`state` decides which goals come back — 1 open (the default), 2 closed, 0 draft.** Closed goals
are retrievable, so "nothing completed" can be checked rather than asked about, and a goal that
does not appear on the default call may be finished rather than missing.

**Progress, status and closing all belong to the check-in**, in one call. Reshaping a goal — its
title, scale, owner, key-result definitions — is the edit. Using the edit to move a status puts
the change outside the history that explains it.

*Withheld:* no check-in read → **no staleness claim**, no "oldest first" ordering, and a new
check-in may unknowingly repeat the last one; report shape and status problems only. No closed
goals → say the check covered open goals only rather than implying the history was read. A goal
with no measure is itself the finding (P11), not a gap.

## 6. Feedback

Read `list_feedback(recipients: <report id>, state: 2)` — `state: 2` is what actually reached
someone. Write `create_feedback(...)`, private-first by default (P7).

**Feedback and recognition are different things, in different tools, with different privacy.** Do
not read one and reason about the other. `list_feedback` does not carry recognition — verified
against a live response.

*Withheld:* no feedback read → no feedback-recency and no repeat-feedback claim.

## 7. Recognition

Write `create_recognition(title, recipient_id)` — `title` is the message, 2-4 sentences, plain text.
Read `list_recognitions` — **shipped in the 2026-08 MCP update**; deployments that predate it do
not have the read.

**`core_value` on both is a name, not an ID**, and the names differ in every org. Resolve one
through `get_organization_context` and copy it exactly, or leave it unset. Never guess a value
name and never send an ID.

*Withheld wherever the read is absent, errors, or returns an empty that cannot be verified as
real history — and this is the strictest rule in the library:* **no drought finding and no
recognition equity finding, for anyone.** Not "none found". Not a cautious hedge. Nothing. Report
the wins that were found and ask the manager when they last recognised that person.

Without a verified read, "absent", "returned nothing", and "nothing ever happened" are
indistinguishable — an empty from a record nobody has written to yet is not a drought; verify
there is history before measuring a gap in it. With the read live, `recognition-scan` (parked in
`skills/later/`) can come back — its eval cases that currently assert silence need revisiting.

## 8. Private notes — what the manager knows and no system holds

**Read, create, and delete shipped in the 2026-08 MCP update.** Write `create_private_note(text,
profile?)`, read `list_private_notes(profile?, ...)`, delete `delete_private_note(note_id)`. There
is **no AI-memory access**, and none is planned: what a skill knows about a person is what the
notes hold, nothing more. Deployments that predate the update have none of the three.

**The write saves immediately.** It is the only Topicflow write with no preview and no
`confirm_creation` — the note exists the moment the call returns. Do not wait for a draft and do
not call the note pending. Do not add a confirmation either: the note reaches nobody but its
author and the delete undoes it, so the gate the other writes need would only be a detour here.
What moves earlier is the judgment — whether the fact is durable is settled before the call,
because no draft will catch it afterwards.

**A note can only be about the user or one of their own direct reports.** Anyone else — a peer, a
skip-level, the user's own manager — is rejected by the tool. When the durable fact is about one
of those people, hand the sentence back the same way a missing write is handled. This is the
common case for a report using these skills on their own manager, so it is not an edge case.

Private notes belong to their author alone. **1-on-1 meeting notes are not a substitute** — those
are shared with the other participant, so a manager-private observation put there is an observation
the report can read.

Where the update has not reached the deployment, there is one honest path: produce the sentence
in third person and hand it to the manager to keep. Do not look for somewhere else to put it.

*Withheld:* no read → dedup is impossible, so ask in half a sentence rather than duplicating, and
**never report a fact as new**. No write, or a person the write does not cover → produce the
sentence and say plainly it was not filed, and which of the two reasons applies. A fact the manager
pastes somewhere is still kept; a fact silently dropped is not.

**Dropping a note is better than writing it somewhere the report can read.**

## Using something other than Topicflow

The skills are written against Topicflow because that is what they ship with. Another tool can
serve any of the eight — the practice does not change, only the call.

To swap one in: list what the MCP server actually exposes, find a read that returns the fields
above and a write if the skill needs one, **test one real call per direction**, then note the
call and what it cannot do next to the skill's own Sources section. A tool that exists is not a
tool that returns what you need; empty results and permission errors both look like success until
you look.

**Never invent a tool or a parameter.** Where nothing satisfies a job, the answer is that the job
is unbound — a real answer, and the withheld conclusions above apply exactly as written.

Common cases: an issue tracker or CRM for **work** when `query_external_events` is not carrying it;
a calendar for **meetings** cadence and cancellations; a note store for **private notes**, which is
the strongest option available today. Findings still get written back to the manager's own notes,
wherever those live.

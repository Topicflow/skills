# Source map — what each skill needs, and where it can come from

The Method in every skill is tool-agnostic on purpose. This file is the other half: the eight
things the library needs, and every backend that can supply each one.

**No skill requires Topicflow.** Topicflow is the fullest single source — it is the only one that
holds a feedback and recognition record — but a manager on Notion, on a calendar and an issue
tracker, or on nothing but the conversation still gets a working library. What changes is how much
the skill can see, and a skill must always say which it was.

Run [`setup-sources`](../skills/foundations/setup-sources/SKILL.md) once to record where a
manager's data actually lives. Every other skill reads that record instead of guessing.

## The capabilities

| | Capability | Needed by |
|---|---|---|
| **C1** | Roster — who reports to this manager | every team-wide skill |
| **C2** | 1-on-1 history — dates, cancellations, topics, notes, action items | prep-1on1, relationship-drift, weekly-brief, onboard |
| **C3** | Work signals — what someone shipped, reviewed, or is stuck on | prep-1on1, recognition-scan, stuck-work, review-prep, weekly-brief |
| **C4** | Goals — objective, status, check-in recency | goal-checkin, prep-1on1, review-prep |
| **C5** | Feedback and recognition record — what was said, to whom, when | give-feedback, give-recognition, recognition-scan, review-prep |
| **C6** | Durable notes — preferences, maturity, commitments (read and write) | save-context, and every skill's write-back |
| **C7** | Deliver a message to a person | give-feedback, give-recognition, request-feedback |
| **C8** | Put a topic on a meeting agenda | prep-1on1, onboard, goal-checkin, stuck-work |

## C1 — Roster

- **Topicflow:** `get_user_infos(team_name)` for a team, `get_user_infos(target_names)` for
  individuals, `include_career_track: true` for level and competencies.
- **Notion:** `notion-get-users(query)` lists workspace members with IDs and emails;
  `notion-search(query_type: "user")` finds a person by name. Neither knows **who reports to
  whom** — Notion has no org chart.
- **Calendar:** recurring 1-on-1s reveal who the manager actually meets.
- **Always:** ask the manager once and store the answer (C6). This is the recommended path on every
  backend — inferring a roster silently is how someone gets left out of a review cycle.

## C2 — 1-on-1 history

- **Topicflow:** `list_meetings(is_oneonone: true, with_notes_and_transcript: true)` — dates,
  cancellations, topics, notes, action items, in one call.
- **Notion:** `notion-query-meeting-notes(filter)` over the manager's meeting notes. Filter by
  `attendees` (`person_contains`), by `title` (`string_contains: "1:1"`), and by `created_time`
  (`date_is_within`, or relative values like `one_month_ago`). Then `notion-fetch(id)` for the full
  page; `include_transcript: true` only when the transcript is genuinely needed. Action items are
  read from the page body, so they depend on the manager writing them down.
- **Google Calendar:** dates and cancellations, no content. Enough for `relationship-drift`, not
  enough for `prep-1on1`.
- **Neither:** ask. "When did you last meet Tony, and what was left open?" costs one question and is
  more reliable than a partial scan.
- **Note:** Notion meeting notes only exist where the manager takes notes there. An empty result
  means *no note was written*, never *no meeting happened* — those are different claims.

## C3 — Work signals

- **Topicflow:** `query_external_events(target, start_datetime, end_datetime)` — normalized across
  connected tools. Both datetimes required; always pass `target`.
- **Linear / GitHub directly:** `list_issues`, issue and PR history. More detail than an event feed
  — this is where the *reason* a review is stuck lives, which `stuck-work` needs.
- **Notion:** `notion-search` with AI search reaches connected Slack, GitHub, Jira, and Linear
  content. Good for finding that something happened; weak for dates and state transitions, so do
  not compute staleness from it.
- **Neither:** the skills that exist to detect stalls and wins (`stuck-work`, `recognition-scan`)
  have nothing to detect on. They should say so once and stay silent rather than substitute a proxy.

## C4 — Goals

- **Topicflow:** `list_goals(owners)` — **open goals only**, with status and key results.
- **Notion:** a goals or OKR database. `notion-fetch(<database url>)` first for the schema and the
  `collection://` data source URL, then `notion-query-data-sources` with SQL over it. Property names
  vary per workspace, so read the schema — never assume a column called `Status`.
- **Neither:** ask what the person's current goals are. A goal nobody can name is itself the finding
  (P11).

## C5 — Feedback and recognition record

**This is the one capability with no Notion equivalent**, and the gap that changes behaviour most.

- **Topicflow:** `list_feedback(recipients, state, created_datetime_start)` and
  `list_assessments(target)`. Writes: `create_feedback`, `create_recognition`.
- **Notion:** nothing native. A manager can keep a log — a simple database with columns for person,
  date, kind (feedback or recognition), and what was said — and `setup-sources` offers to create
  one. It works from the day it is created, never retroactively.
- **Neither:** unavailable.
- **What this changes:** every recency and equity gate (P10 drought detection in
  `recognition-scan`, feedback recency in `prep-1on1`, the equity check in `review-prep`) is
  **evidence-free**. Those skills must not report a drought they cannot verify. They ask instead:
  "I can't see recognition history — when did you last recognize Nadia?" An unverifiable absence is
  never reported as a fact.

## C6 — Durable notes

- **Topicflow:** `save_private_note` and AI memory are **in dev** in
  [TF-1595](https://linear.app/topicflow/issue/TF-1595). Until they land, the fallback ladder in
  [topicflow-tools.md](topicflow-tools.md) applies.
- **Notion:** fully supported today, and currently the better option. Keep a "People" page or
  database, one page per report. `notion-create-pages` to start it,
  `notion-update-page(command: "insert_content", position: {type: "end"})` to append a dated line.
  Read it back with `notion-fetch`. Private to the manager as long as the page is.
- **Neither:** produce the note text for the manager to keep, and say plainly that it was not
  filed. A fact the manager pastes somewhere is still a fact kept.
- **Never** write a manager-private observation to a surface the report can read — a shared meeting
  note, a team page, a channel. Dropping the note is better.

## C7 — Deliver a message to a person

- **Topicflow:** `create_feedback` and `create_recognition`, both preview-then-confirm. The message
  lands in the product where the person will see it.
- **Slack:** `slack_send_message_draft` prepares a direct message for the manager to send, and
  `slack_send_message` sends one, both only after explicit approval. **Never post about a person to
  a channel from a skill** — public recognition is the manager's own act, and P9 makes audience a
  preference question, not a default.
- **Neither, and Notion:** the skill produces the text and the manager sends it. This is the normal
  case, not a failure — the draft was always the valuable part.

## C8 — Put a topic on a meeting agenda

- **Topicflow:** `add_meeting_topics(meeting_id, topics)`, `edit_meeting_topic_notes`.
- **Notion:** append to the meeting note page for the upcoming 1-on-1 with
  `notion-update-page(command: "insert_content")`, or create the page if the manager makes one per
  meeting. Shared pages are visible to the report — same rule as C6.
- **Neither:** output the topics as text to paste.
- **No backend schedules a meeting.** Not Topicflow, not Notion. "Schedule a 1-on-1" is always a
  request to the manager.

## Rules that hold on every backend

1. **Say what you could see.** Any skill that ran with a missing capability names it in one line.
   The manager should never have to guess whether "no recognition found" means the record is empty
   or unreadable.
2. **Missing is not zero.** An unavailable source produces "unknown", never a negative finding
   about a person.
3. **Ask before scanning.** One question to the manager beats a wide, uncertain search. The cap of
   three questions still applies.
4. **Write back to the system of record**, whatever it is — Topicflow, a Notion page, or the
   manager's own notes. The destination is recorded once by `setup-sources`, not re-decided
   per run.
5. **Degrade loudly, fail rarely.** Losing a capability narrows a skill; it almost never stops one.
   The exceptions are `stuck-work` and `recognition-scan` without C3, which have nothing to detect.

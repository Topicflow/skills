# Topicflow tools — what exists, what is missing, how to degrade

Ground truth for the Topicflow MCP as of 2026-08. Skills name practices, not tools; this
file is where tool detail lives so a rename touches one file.

Tool names below are unprefixed. In an MCP client they appear namespaced (for example
`mcp__claude_ai_Topicflow__list_meetings`). Match on the suffix.

## Connect Topicflow before running a skill

If no Topicflow tool is exposed, stop before drafting, advising, or writing. Say: “Topicflow is
not connected, so I cannot run this skill yet.” Then use the
[portable choice controls](interaction-controls.md) to offer **Show setup steps** and **Not now**.

For setup, tell the user to add this MCP server URL to their agent client, then complete the
Topicflow sign-in/authorization it opens:

```text
https://app.topicflow.com/mcp
```

After that, ask them to retry the same skill. Do not invent a no-Topicflow fallback or claim that
the server is connected until a Topicflow tool is actually exposed.

## The write pattern — preview, then confirm

Every write tool is a **preview**. It does not change anything. It returns a draft plus an
opaque `pending_id`. Nothing exists until `confirm_creation(pending_id, confirmation_summary)`
runs.

1. Call the write tool → get the preview and `pending_id`.
2. Show the draft to the manager in plain text. Ask once.
3. On approval, call `confirm_creation` with that `pending_id` and a plain-language
   `confirmation_summary` such as "Send recognition to Gavin Johnston".

Never describe the `pending_id` to the manager. Never confirm without an approval in the
same conversation. Never ask twice for the same change (library convention 4).

A batch of separate changes (five feedback requests, for example) is a preview + confirm
per change, but one approval from the manager approves the batch.

### The one exception — `create_private_note` saves immediately

`create_private_note` is the only write that is not a preview. It returns no `pending_id`,
and `confirm_creation` has nothing to confirm. The note is saved the moment the call is made.

**Do not wait for a draft, and never describe the note as pending.** An agent that goes looking
for a confirmation step here will either stall or report the save as not yet done.

**That is deliberate, not an oversight, so do not bolt a confirmation on.** The preview gate
exists to stop something reaching another person before its author has seen it. A private note
reaches nobody — it is visible only to whoever wrote it, and `delete_private_note` removes it.
Adding an "are you sure?" would put a detour in the one write designed not to have one.

What *does* move earlier is the judgment: whether the fact is worth keeping has to be settled
before the call, because there is no draft to catch it afterwards. The receipt is the review.

`delete_private_note(private_note_id)` *does* preview and confirm, and deletion cannot be undone.

## Reads

**Paging, everywhere.** Every read takes `limit`, and asking for more than the cap does not
raise it. Two families:

- **The everyday reads** — meetings, goals, goal check-ins, feedback, recognitions, private
  notes, review tasks — **default to 10 and cap at 50.** So the default is small enough to miss
  things silently. Set `limit` deliberately on any call whose answer depends on completeness.
- **The bulk reads** — assessments, review programs, and the review-program listings — default
  to 50, cap at 200, and page with a `cursor`. **Follow `next_cursor` until it stops before
  reporting any total, count, or distribution**; a first page read as the whole set is how an
  undercount becomes a confident number.

There is no way to ask "how many are there" without paging to the end. A capped result and a
complete one look identical, so a skill that reports a count either paged or says it did not.

- **`get_organization_context(include_inactive_core_values?)`** — how this org is configured:
  the **recognition core values** (active by default), the label it uses for each feature, which
  features it turned on, and the month its fiscal year starts. Call it once per run and reuse the
  answer. **Today the library uses it for one job: resolving a core-value name before
  `create_recognition` or a `list_recognitions` filter.** The labels, the feature switches, and
  the fiscal year are real and unused — see the note at the end of this file.
- **`get_user_infos(target_names?, team_name?, include_career_track?)`** — profiles. Pass
  full names or IDs in `target_names`, or a `team_name` for a whole team (fuzzy match
  accepted). `include_career_track: true` adds level, competencies, responsibilities, and
  next role — use it for career and review work, skip it otherwise. **This is how you get
  user IDs.** Resolve IDs once at the start of a run and reuse them; IDs beat names
  everywhere else.
  **The `reports` array is not a trustworthy roster.** Observed in a live org:
  it returned a duplicate account with the same name as the manager themselves. Treat it as
  a hint to confirm, never as the roster. Always ask the manager and confirm once.
- **`list_meetings(is_oneonone?, title?, status?, limit?, order?, meeting_datetime_start?, meeting_datetime_end?, with_notes_and_transcript?)`**
  — the authenticated manager's meetings. `order: "-start_datetime"` for most recent first,
  `"start_datetime"` for upcoming.
  **`is_oneonone: true` is not "1-on-1s with my reports".** Observed in a live
  org: it returned a recurring lunch with a peer, flagged `is_formal_oneonone: true` and
  `is_manager_and_report_oneonone: false`. There is no request parameter for the distinction —
  it is a **response field**, so filter after the call on
  `is_manager_and_report_oneonone: true`, and cross-check the other participant against the
  confirmed roster. Skipping this makes `relationship-drift` report drift on a lunch and
  `prep-1on1` prep an agenda for someone who does not report to the manager.
  **There is no `participants` parameter.** It is the obvious thing to reach for and it does not
  exist — Topicflow's in-app assistant has one, this does not. Narrow by `title` and a date
  window, then match participants in the response.
  `status` filters confirmed / tentative / cancelled (values 1, 2, 3, confirmed against the live
  schema). **`with_notes_and_transcript: true`
  returns topics, agendas, and notes** — this is where open action items and past topics
  live, and it is the substitute for a dedicated action-item tool. The payload is large:
  always pair it with a date filter and a small `limit`.
  A lone topic titled **`New Topic`** with no notes is Topicflow's blank default, so treat it as
  **no agenda**, not as a prepared topic or a topic with no follow-through.
  **`meeting_id` and `topic_id` for any write come from here.**
- **`list_goals(owners?, contributors?, state?, status?, scope?, visibility?, due_date_start?, due_date_end?, search_term?, limit?, order?)`**
  — visible goals; defaults to the current user's own. Pass `owners: <report id>` for a report's
  goals. `status`: 0 none, 1 on_track, 2 at_risk, 3 off_track. `scope`: 1 personal, 2 team,
  3 organization, 4 development.
  **`state` defaults to 1 (open); pass 2 for closed goals and 0 for drafts.** Closed goals are
  retrievable — a goal that does not come back on the default call may be finished rather than
  missing, and that is a second call to settle, not a question to ask. Both `owners` and
  `contributors` take a list plus a `*_match_mode` of `any` (default) or `all`.
- **`list_goal_checkins(goal_id?, goal_title?, owners?, created_datetime_start?, created_datetime_end?, limit?, order?)`**
  — the progress updates posted on a goal, newest first. **Read a goal's recent check-ins before
  posting a new one**, so the update does not repeat what is already there. This is also the only
  source of check-in recency: `list_goals` does not carry it.
- **`list_feedback(recipients?, sender?, state?, created_datetime_start?, created_datetime_end?, search_term?, limit?, order?)`**
  — informal feedback. `state`: 1 draft, 2 sent, 3 requested. Filter `state: 2` for what
  actually reached someone. This is the primary source for feedback recency; it does not include
  recognition. `recipients` takes a list plus `recipients_match_mode` (`any` by default, `all`
  for feedback naming several people).
  **`state: 3` is how an unanswered request is found.** Requests the caller sent come back with
  no message, so "I asked Kameron three weeks ago and heard nothing" is readable rather than
  guessed at. A request is not feedback that happened — never count one as feedback given.
- **`list_assessments(target?, responder?, program_id?, program_title?, assessment_types?, state?, include_content?, include_answers?, include_dimensions?, include_calibrations?, question_ids?, submitted_datetime_start?, submitted_datetime_end?, limit?, cursor?, order?)`**
  — review-cycle assessments. `target` is the person being assessed, `responder` is the
  person who wrote it. `state` defaults to 2 (submitted); 1 is draft. `assessment_types` filters
  `performance` / `manager` / `peer` / `engagement_survey`. `include_content: true` for the
  written answers — only when you need the text. `include_answers`, `include_dimensions` and
  `include_calibrations` are for reporting and each **requires `program_id`**.
  Pages with `cursor`: **follow `next_cursor` until `has_more` is false before reporting any
  distribution**, or the numbers describe the first page rather than the cycle.
- **`list_review_programs(current_only?, state?, title?, program_id?, include_participants?, include_participant_status?, limit?, cursor?, order?)`**
  — review cycles. `current_only: true` for what is running now. `state` is a string —
  `draft`, `published`, `paused`, `closed` — and `published` means launched. `order` takes
  `start_date` or `due_date`, `-` prefixed for descending. Pages with `cursor`.
- **`list_my_review_tasks(current_only?, include_completed?, program_id?, program_title?, limit?)`**
  — review work assigned to the user. `current_only` defaults to true; `include_completed`
  defaults to false and turning it on also surfaces finished work that can still be revised.
  Each row carries a `review_type`, and they are not all "write a review" — `peer_nomination`
  means choosing who reviews someone, which is a different job with different tools.
  The trigger for `review-prep` (parked in `skills/later/`).
- **`query_external_events(start_datetime, end_datetime, target?, sources?)`** — work
  signals from connected tools (GitHub, Linear, and others). **Both datetimes are
  required**, ISO 8601 UTC (`YYYY-MM-DDTHH:MM:SSZ`). `target` defaults to the current
  user, so **always pass the report's ID** when looking at someone else. This is evidence,
  not performance: it shows what happened, never how well.

## Writes (all preview-then-confirm)

- **`add_meeting_topics(meeting_id, topics[{title, notes?}])`** — `title` is plain text,
  no markdown. `notes` is an array where each entry is one block, and **markdown works inside a
  block**: `**bold**`, `*italic*`, `[text](url)`, inline code. Consecutive entries starting with
  `- ` merge into one bulleted list — **keep the `- ` prefix**, it is not stripped for you — and
  an empty string `""` inserts a blank line. So a grouped update is
  `["**Shipped**", "- [PR 100](…)", "- [PR 101](…)", "", "**Working on**", "- [PR 102](…)"]`.
- **`edit_meeting_topic(topic_id, title)`** — retitle only. No `meeting_id`.
- **`edit_meeting_topic_notes(meeting_id, topic_id, text, operation?, notes_type?)`** —
  `text` takes the same markdown as a topic note. `operation` defaults to `append`; use
  `replace` only when the manager asks to overwrite.
  `notes_type` is `auto` (default), `shared`, or `individual`. On a formal 1-on-1, `auto` writes
  to individual notes where the topic has them active, and to shared notes otherwise.
  **Write as though every value is shared.** Whether individual notes are visible to the other
  participant is **not verified** — and `auto` means a skill does not reliably know which of the
  two it just wrote to. An unverified privacy boundary is not a private store: never put a
  manager-private observation here. That is what private notes are for, and they are unambiguous.
- **`create_feedback(title, description, recipient_*?, sender_*?, recipients_can_view?, recipients_managers_can_view?, admins_can_view?, is_draft?)`**
  — two modes. *Giving* feedback: set `recipient_*` to the person it is about.
  *Requesting* feedback: set `sender_*` to the person you are asking to **write** it and
  `recipient_*` to the **subject** it is about. `description` is plain text, 2-4 sentences.
  Visibility defaults: recipient can view, managers and admins cannot. For corrective
  feedback keep it that way (P7, private-first).
- **`create_recognition(title, recipient_id? | recipient_ids? | recipient_email? | recipient_name?, core_value?)`**
  — **`title` is the message**, 2-4 sentences, plain text, no markdown. `recipient_name`
  also accepts a team name. Never set the recipient to the current user.
  **`core_value` is a name, not an ID**, and the names are different in every org. Copy one of
  the org's *active* core values exactly, from `get_organization_context`. Never guess one, and
  never send an ID. Retired core values still tag older recognitions, so they remain usable as a
  filter on the read, but a new recognition must use an active one. Set it only when the
  contribution clearly maps to a value; leaving it unset is correct far more often than reaching
  for the closest match.
- **`create_goal(title, scope, key_results[], owner_*? | owners?, contributors?, teams?, due_date?, start_date?, goal_description?, parent_goal_id?, progress_type?, state?, visibility?)`**
  — `key_results` is required and must be measurable (P11). `owner_*` defaults to the current
  user, so **pass the report's ID** when the goal is theirs; `owners` takes a list and overrides
  the singular fields. A **team-scoped goal needs `teams`** or it belongs to no team.

  Each entry in `key_results` is an object: `{title, start_value?, target_value?, progress_type?,
  description?, assignee?}`. **`progress_type` is the unit** — 1 percentage, 2 numeric,
  3 currency, 4 boolean. Anything that counts gets its real numbers: "Connect to 3 MCP servers"
  is `start_value: 0, target_value: 3, progress_type: 2`, never `0/100`. For a measure that should
  go **down**, put the higher number in `start_value` — there is no direction field. Leave all
  three unset only where there is nothing to count, and use 4 for a plain done / not-done.

  The goal's own `progress_type` adds 5 (aligned_average) and **defaults to it whenever key
  results are passed**, so its progress is the average of theirs. Set 1-4 with `start_value` /
  `target_value` only for a goal measured by one number of its own.

  **Real values or none.** The fields existing is not permission to guess what goes in them: an
  unknown baseline is a question for the owner, not a `0`.
- **`edit_goal(goal_id, title?, goal_description?, status?, state?, visibility?, scope?, owner_*? | owners?, add_contributors?, remove_contributors?, teams?, parent_goal_id?, progress_type?, start_value?, target_value?, start_date?, due_date?, key_results[{op, id?, ...}]?)`**
  — `key_results` takes `op: "add" | "edit" | "remove"`, and add/edit carry the same
  `title` / `start_value` / `target_value` / `progress_type` / `description` / `assignee` fields
  as creation; anything omitted on an edit stays as it was. `state`: 0 draft, 1 open, 2 closed
  (closing sets the completion date). `owner_*` and `owners` **replace all owners** — be careful;
  contributors are added and removed individually instead. `teams` replaces all teams, and an
  empty list detaches. `parent_goal_id: 0` removes an alignment.
  **This is for reshaping a goal.** Progress, status and closing belong in a check-in — see below.
- **`create_goal_checkin(goal_id, message?, current_value?, key_results[{key_result_id, current_value}]?, status?, state?)`**
  — plain text message. Percentages are whole numbers (50, not 0.5). `status`: 0 none,
  1 on_track, 2 at_risk, 3 off_track. `state: 2` closes the goal — the "Mark as complete"
  checkbox in the app.
  **The message, the numbers, the status change and the close go in one call.** Doing the status
  or the close through `edit_goal` afterwards costs a second confirmation and lands outside the
  check-in history, so the record shows a status that moved with nothing explaining why.
  Omit `current_value` on an aligned_average goal; it is ignored, and the key results carry it.
  A check-in should come from the goal's owner; a manager posting one on a report's goal is a
  last resort, not the default (P15).
- **`edit_feedback(feedback_id, title?, description?, recipients_can_view?, recipients_managers_can_view?, admins_can_view?, send?)`**
  — amend before or after sending; omitted fields stay as they are. `send: true` sends a draft
  the user saved earlier, and only works on their own draft. Get the id from `list_feedback`.
  Changing a visibility toggle changes who can read something already written — say who gains or
  loses access in the preview, never just that visibility changed.
- **`edit_recognition(recognition_id, title?, core_value?, clear_core_value?)`** — `title` is the
  message. `core_value` takes an exact active core-value name; `clear_core_value: true` removes
  the current one, and the two are mutually exclusive. Get the id from `list_recognitions`.

## Gaps and fallbacks

**Shipped in the 2026-08 MCP update:** private notes — **read, create, and delete** — and the
**recognition read**. The update does **not** ship AI-memory access, and none is planned: what a
skill knows about a person is what the private notes hold. Deployments that predate the update lack
these tools; the fallbacks below stay for them.

**Private notes.** All three are scoped to the current user: the read never returns another
person's notes, and the note is visible to nobody but its author.

- **`create_private_note(text, profile? | profile_id?)`** — `text` is plain text. `profile`
  takes an ID, an email, or a name; omit it to note about yourself. **Saves immediately** — see
  the exception above. **You can only write a note about yourself or one of your own direct
  reports.** A note about a peer, a skip-level, or the user's own manager is rejected, so a skill
  that hears something durable about one of those people hands the sentence back instead.
- **`list_private_notes(profile?, created_datetime_start?, created_datetime_end?, limit?, order?)`**
  — the caller's own notes. `profile` filters to notes about one person; omit it for all of them.
  Newest first by default.
- **`delete_private_note(private_note_id)`** — preview then confirm, and the deletion cannot be
  undone. Get the id from `list_private_notes`; never guess one.

*Fallback where the tools are absent:* produce the note text in third person and hand it to the
manager to keep. **There is no second option.** Meeting notes are shared with the other
participant, so they are not a private store, and a manager-private observation must never be
written there.

**`list_recognitions(recipients?, sender?, core_values?, created_datetime_start?,
created_datetime_end?, search_term?, limit?, order?)`.** Was registered but scope-gated behind
`recognitions:read`, so it never appeared to any client; the update ships the scope. The
`core_values` filter takes **names**, not IDs, and they are org-specific — resolve them through
`get_organization_context` the same way `create_recognition` does. Recognition is **not** carried by
`list_feedback` — a live check confirmed it. *Where absent:* recognition recency is unreadable —
no drought claim, no equity claim; ask the manager instead. **The general lesson outlives the
fix:** a scope-gated tool is invisible, and "not there", "returned nothing", and "nothing ever
happened" look identical from a client. So a drought is never claimed on an unverified empty,
even with the read live — a record nobody has written to yet has no history to measure.

Two tools remain wanted and missing:

**1. `get_person_context(person, since)`.** A curated synthesis: role, current focus,
recent work, open items. *Fallback:* compose it — `get_user_infos` +
`query_external_events` + `list_goals(owners=id)` + `list_meetings(is_oneonone=true,
with_notes_and_transcript=true, limit=2-3)`. Four calls instead of one; resolve the ID
first so all four hit the right person.

When the update reaches a deployment, the skills that shed the heaviest workarounds are
`save-private-note` (the fallback ladder collapses to one call), `give-recognition` (preference
looked up from notes instead of asked every time), and `direct-report-interview` (its answers get a
durable home, and it stops re-asking what a note already holds). It also unblocks the parked
`recognition-scan` — evidence at last — and gives the other detectors a note ledger that makes
cross-run cooldowns enforceable.

**2. `list_action_items(person)`.** Open action items across 1-on-1s. *Mostly covered:*
`list_meetings(with_notes_and_transcript=true)` returns topics and notes, so action items
are readable from the last two or three meetings — that is what `prep-1on1` does. A
dedicated tool would remove the keyword-scanning and the recency window.

**Also missing, and worth knowing:**

- **No calendar write.** Nothing here schedules, reschedules, or cancels a meeting. A
  "schedule a 1-on-1" action is always a request to the manager — the skill can only add
  topics to a meeting that already exists.
- **No org chart traversal.** There is no "list my direct reports" tool.
  `get_user_infos(team_name=...)` covers a team, and `list_meetings(is_oneonone=true)`
  reveals who the manager actually meets one-on-one. Team-wide skills should ask the
  manager to confirm the roster once rather than inferring it silently every run.

## Exposed and not yet used: the rest of `get_organization_context`

The call is in the Reads list above because `create_recognition` needs it for core-value names.
It also returns three things no skill reads yet, and each one is a live assumption the library is
currently making without checking:

- **The label the org uses for each feature.** Orgs rename these. A skill that says "goal" to an
  org that says "OKR", or "recognition" to an org that says "kudos", is making the same mistake as
  a skill that says "ticket" to a sales team.
- **Which features the org turned on.** Nothing checks. A goal skill can run its whole method in
  an org that has goals switched off.
- **The month the fiscal year starts.** "This quarter" in a due date currently means the calendar
  quarter, which is wrong wherever the fiscal year is not.

Wiring these up changes house style and several Methods, so it is its own piece of work rather
than a parameter fix. Until then, no skill should claim to be using the org's own vocabulary.

## Secondary sources

Use only when the manager keeps the data there, and only as a *source* — findings still
get written back to Topicflow (convention 3).

- **Linear / GitHub** — usually already flowing through `query_external_events`. Query the
  native MCP directly only for detail that events do not carry (review comments, ticket
  descriptions).
- **Notion** — team docs, project pages, career-ladder documents.
- **Google Calendar** — actual meeting cadence and cancellations when Topicflow's calendar
  view is incomplete.
- **Slack** — where a win or a concern was mentioned. Read-only. Never post about a person
  to a channel from a skill.

# Topicflow tools — what exists, what is missing, how to degrade

Ground truth for the Topicflow MCP as of 2026-10-01. Skills name practices, not tools; this
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

**Connected but the review writes are missing.** The review writes need the `reviews:write` scope,
and a connection made before the 2026-09 MCP update keeps its old, read-only grant. When the review
reads are exposed but a write the skill needs is not, ask the user to disconnect and reconnect
Topicflow, approving review changes. See [Reviews](#reviews--the-review-cycle-family).

## The write pattern — preview, then confirm

Almost every write tool is a **preview**. It does not change anything. It returns a draft plus an
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
  `labels` (its own word for each feature), `core_values` (active by default, each with a title,
  description and status), `features` (five booleans), and `quarter_start_month`.
  **Call it once per run, before naming a feature or a core value, and reuse the answer.**
  Section 0 of [data-sources.md](data-sources.md) has a live response and what each part is for.
  Two traps: the label keys are not the labels — Topicflow's own org reads `expectation` as
  "alignment" — and a feature being `true` does not mean a call exists, since `action_items` is on
  with no action-item tool anywhere in this MCP.
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
- **The review cycle itself** — `list_review_programs`, `list_my_review_tasks` and the rest of
  the family have their own section: [Reviews](#reviews--the-review-cycle-family).
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

### Three tools that exist in the product but not in this MCP

Topicflow's own in-app assistant calls all three. They are not hypothetical designs — naming them
turns "we wish this existed" into "expose these three", and it is why the fallbacks below are
workarounds rather than the intended shape.

**1. A person-context bundle.** In-app it is `fetch_overview_bundle`: one call returning goals,
action items, meetings, feedback, recognitions and work events for one person or several, over a
window. *Fallback:* compose it — `get_user_infos` + `query_external_events` +
`list_goals(owners=id)` + `list_meetings(is_oneonone=true, with_notes_and_transcript=true,
limit=2-3)`. Four calls instead of one; resolve the ID first so all four hit the right person.

When the update reaches a deployment, the skills that shed the heaviest workarounds are
`save-private-note` (the fallback ladder collapses to one call), `give-recognition` (preference
looked up from notes instead of asked every time), and `direct-report-interview` (its answers get a
durable home, and it stops re-asking what a note already holds). It also unblocks the parked
`recognition-scan` — evidence at last — and gives the other detectors a note ledger that makes
cross-run cooldowns enforceable.

**2. Action items.** In-app it is `list_action_items`, and the org context reports
`action_items: true` — the feature is on, the API is not there. **This is the library's largest
workaround.** *Mostly covered:* `list_meetings(with_notes_and_transcript=true)` returns topics and
notes, so action items are readable from the last two or three meetings — that is what `prep-1on1`
does, by scanning text for them. A dedicated tool would remove the keyword-scanning and the
recency window, and would let a skill see an item older than the last few meetings at all.

**3. A collaborator list.** In-app it is `list_close_collaborators`: direct reports first, then
peers who share a manager, then teammates and recent meeting co-attendees, each with an id, name,
role and profile URL. That is the roster every team-wide skill needs and none can get.
*Fallback:* `get_user_infos(team_name=...)` covers a team, and `list_meetings(is_oneonone=true)`
reveals who the manager actually meets one-on-one — but see the warning on that call, and ask the
manager to confirm the roster once rather than inferring it silently every run.

**Also missing, and worth knowing:**

- **No calendar write.** Nothing here schedules, reschedules, or cancels a meeting. A
  "schedule a 1-on-1" action is always a request to the manager — the skill can only add
  topics to a meeting that already exists.

## Reviews — the review-cycle family

Shipped in the **2026-09 MCP update** (review completion 2026-09-02, peer nominations and
calibration 2026-09-14, delivery 2026-09-16, participant changes 2026-09-21, reminders and dates
2026-09-23). Reads verified live against a test cycle on 2026-10-01.

**The writes need the `reviews:write` scope, and an older grant does not get it.** Every review
write requires `reviews:read` *and* `reviews:write`, and the server hides any tool the token is
not scoped for. A client that connected before the update sees the reads and none of the writes,
with no error. So a missing review write is not proof the tool is absent: tell the user to
disconnect and reconnect Topicflow, approving review changes, then retry. Until then the job is
unbound and the skill hands over the text or the steps for the web app.

Two cautions hold everywhere in this family. Review content and calibration content are private
and never move to a public channel. A peer nomination is not a completed review — choosing
reviewers does not mean anyone has written anything.

### Finding the cycle and the work (reads)

- **`list_my_review_tasks(program_id?, program_title?, current_only=true, include_completed=false, limit=10)`**
  — review work assigned to the user. `limit` caps at 50. Each row carries the program (`id`,
  `title`, `current_stage`), `assessment_template_id`, `review_type`, `target`, `status`
  (`not_started`, `in_progress`, `waiting` or `submitted`; a peer selection is `not_started` or
  `completed`), `assessment_id` (once a draft exists), `due_date`, and `waiting_for` when waiting.
  Never show the IDs to the user.
  - **A `peer_nomination` row means "choose reviewers".** Use the nomination calls for it,
    never `start_review`.
  - **A row with `status: "waiting"` cannot be started.** Say what it waits for, from its
    `waiting_for` value ("waiting for pre-calibration"). Never offer to start it.
  - `include_completed: true` adds submitted reviews and finished peer selections that can still
    be revised.
  - **`current_only: true` leaves out a cycle that has not kicked off.** Observed live
    2026-10-01: an empty current list, while `current_only: false` showed self and manager
    reviews due 2026-10-13 in a cycle at `current_stage: "draft"`. So an empty list means no
    *current* task is visible, not that the user has no review work.
  - `review_type` observed live: `self_review`, `downward_review`, `manager_review` (an older
    name for the same job on started drafts), `peer_review`, `upward_review`, `peer_nomination`,
    and, for surveys, `survey_response` and `engagement_survey`. A survey is not a review of a
    person.
  - With `current_only: false` the list reaches back years, past-due drafts included. Filter on
    `status` and `due_date` before showing it.
- **`list_review_programs(program_id?, title?, state?, current_only=false, include_participants?, include_participant_status?, order="-start_date", limit=50, cursor?)`**
  — the review cycles this account can see, with `current_stage` (observed: `active`,
  `past_due`), `start_date`, `due_date`, the period dates, `ongoing`, `participant_count` and
  `can_read_participant_details`. `state` is `draft`, `published` (launched), `paused` or
  `closed`. `title` is a fuzzy match. Caps at 200; pages with `cursor`.
  **An ongoing review has no dates of its own** (`ongoing: true`, `due_date: null`). Never
  compute "days left" for one.
- **`list_review_program_assignments(program_id, subject_ids?, assignee_ids?, steps?, statuses?, cursor?, limit=50)`**
  — every requirement in a cycle, **including work that is not started or is blocked**. This is
  the call that answers "what is outstanding". Caps at 200.
  - `steps`: `self_review`, `downward_review`, `peer_review`, `upward_review`,
    `peer_nomination`, `pre_calibration`, `post_calibration`, `approval`, `delivery`,
    `one_on_one`, `engagement_survey`.
  - `statuses`: `not_started`, `in_progress`, `completed`, `not_required`.
  - Each row carries `subject`, `assignees`, `due_date`, `overdue` (a boolean),
    `blocked_reason`, `not_required_reason`, `responsible_role`, `completion_rule`, and the
    `template_id`, `assessment_ids` and `delivery_id` other calls need.
  - **Several eligible managers on one row are alternatives, not extra requirements.** A
    `completion_rule` of `any_eligible_manager` is done when one of them finishes. Count the row
    once.
  - **Follow `next_cursor` until `has_more` is false before reporting any total.**
  - The cycle's `current_stage` and a row's `overdue` are separate facts. A cycle can be
    `past_due` while every row is `completed` or `not_required`.
- **`list_review_program_participants(program_id, user_ids?, cursor?, limit=50)`** — the people
  enrolled in a cycle, with their current and snapshot dimensions (managers, departments,
  position). **The source of `user_id` for any action on one participant.** Caps at 200.
- **`list_review_program_events(program_id, user_id?, verb?, since?, limit=50)`** — the review's
  Activity log, newest first. By default it returns notification and reminder batches with
  `sent_count`, `failed_count` and `skipped_count`, plus admin actions (`review.published`,
  `review.kickoff`). `verb` is a prefix (`notification.`, `reminder.`). `since` is ISO 8601,
  UTC when no offset is given. Caps at 200.
  - **For "did this person get the email?", pass `user_id`.** That returns their own rows, each
    with a `channel`, a `status` and, for a skip, `payload.reason`. Quote the reason; never
    guess one.
  - **`has_more: true` means you only have the latest rows.** Narrow by `since` or `verb`, or
    raise `limit`, before saying anything about who did *not* get something.
  - A batch with `failed_count` above zero is worth surfacing. A batch is not a person: read the
    person's rows before saying who it failed for.
  - **One row per channel.** Observed live: one person's notification came back as two rows in the
    same batch — email `sent`, Slack `failed` with `error: "This person has no Slack account in
    this organization"`. So a failed count does not mean the person missed it, and the reason for a
    failure is in `error`, while the reason for a skip is in `payload.reason`.
- **`list_assessments(...)`** — the written reviews themselves. Documented under Reads above.
- **`get_review_program_setup(program_id)`** — a draft cycle's saved configuration and its
  validation issues.
- **`list_review_program_setup_options(resource_type?, assessment_type?, search?, page?, limit?)`**
  — what a draft cycle may be configured with: participant scopes, question sets, 1-on-1
  templates, career framework, core values, talent indicators.

### Writing a review (the responder's own draft)

- **`start_review(program_id, assessment_template_id, target_id?)`** — preview of starting or
  resuming one task. Use the exact IDs from `list_my_review_tasks`; omit `target_id` only for an
  organization survey. After confirmation it returns the draft progress and the first unanswered
  question.
- **`get_review_progress(assessment_id)`** — the saved answers and the next unanswered question.
  Ask one question at a time, with its description, criteria and numbered response options.
- **`answer_review_question(assessment_id, question_id, response?, comment?, skip=false)`** —
  preview of saving one answer. Confirmation returns the next question.
  - `response` is text for a text question, a displayed number or the exact label for a rating or
    NPS question, and a list of numbers or labels for multiple choice.
  - `comment` keeps the user's wording; markdown is allowed.
  - `skip: true` only when the user asks to skip a fully optional question.
  - **It never submits.**
- **`submit_review(assessment_id)`** — preview of the complete review with every answer, using
  the configured labels. Show every preview field, then ask for explicit approval to submit.
  Only `confirm_creation` submits, and an approval of an answer is not an approval to submit.
- **`reopen_review(assessment_id)`** — global administrators only. It reopens a submitted
  response (a closed cycle must be reopened first). After that, only the original responder can
  edit and resubmit it. No skill uses it.

### Choosing peers

- **`get_peer_nomination_options(program_id, assessment_template_id, target_id, search?, offset=0, limit=10)`**
  — the current nominees and the eligible coworkers for a `peer_nomination` task. `limit` caps
  at 50; follow `next_offset` for more candidates.
  - Coworkers do not need to be enrolled in the review themselves.
  - **Candidates come back in alphabetical order.** The order says nothing about who works
    together.
  - `search` takes a name or email. When a name matches several people, ask. Never guess an ID.
  - The response carries `target`, `selection_mode` (`employee`: the person picks their own;
    `manager`: their manager picks), `nominees`, and `candidates` with ids and emails.
  - A review whose peers are chosen automatically refuses the call. There is nothing to pick.
- **`update_peer_nominations(program_id, assessment_template_id, target_id, responder_ids)`** —
  preview of replacing the selection.
  - **`responder_ids` is the COMPLETE final list.** To add one person, send the current nominees
    plus the new one. Sending the new one alone removes everyone else.
  - `[]` removes everyone. Use it only when the user asks for exactly that.
  - The preview shows the cycle, the person and the full nominee list. If anything changed before
    confirmation, the save is refused: read the options again and preview again.
  - Saving nominees does not complete anyone's review.

### Running a cycle (admin)

All three are preview-then-confirm and need the admin's own rights on the review.

- **`send_review_reminder(program_id, steps?, message?, channels?)`** — preview of a reminder to
  everyone the review calls late.
  - **The review picks the recipients, not the agent:** whoever is past a step's due date and
    still owes it. The preview shows the recipient count per step; show it.
  - `steps`: `self-review`, `manager-review`, `upward-review`, `peer-review`, `survey`,
    `one-on-one`. Omit to chase every late step. **These use hyphens; the assignment steps use
    underscores.** `self_review` here is an error.
  - `message` is an optional line in the admin's own words. `channels`: `email` (the default),
    `slack`, `teams`.
  - Paused and closed reviews send nothing. Nobody late on the asked steps → refused.
  - **The preview names the late participants per step** ("Overdue by step"). Fine in a direct
    conversation with the admin; never paste it into a channel.
  - **It is written to whoever owns each step** — the participant, their manager, their peers or
    their reports — not only the participant.
  - It reaches only the participants this account can see, so a manager's reminder covers their
    own part of the cycle. A peer selection has no due date and is never chased.
  - At send time the list narrows to whoever is still late; if everyone caught up, nothing is
    sent. Success returns the count and a Progress tab link. Never offer to send it again.
- **`change_review_dates(program_id, kickoff_date?, due_date?, period_start_date?, period_end_date?)`**
  — preview of moving the review's own dates (`YYYY-MM-DD`).
  - Name only the dates that move; the rest stay.
  - **Step due dates are not changed by this tool.**
  - An ongoing review (no dates of its own) is refused.
  - A published review's change is written to its Activity tab; a draft's is not.
  - The preview shows each date from → to. If the dates moved after the preview, the save is
    refused: read again, preview again. Needs edit rights on the review.
- **`update_review_participant(program_id, user_id, action, reason?)`** — preview of an action on
  ONE participant of a published review. `user_id` comes from
  `list_review_program_participants`.
  - `excuse` keeps the person on the roster and stops all their reminders. **`reason` is
    required**, in the admin's own words; it is stored and shown.
  - `add_back` undoes an excuse.
  - **`remove` takes the person off the roster for good** and cannot be undone with this tool.
  - **The person is never notified** of any of the three.
  - Refused, with the reason, when the account cannot change the review, the review is closed or
    not yet published, or the person is in a calibration group (take them out of it first, in the
    web app). For a recurring review the "What happens" field says the removal carries into
    future cycles; show it verbatim.

### Calibration and delivery (no skill yet)

Listed so nothing reaches for them by accident. All private, all preview-then-confirm.

- **`get_review_calibration(program_id, target_id, assessment_template_id)`** — calibration
  state, permitted actions, ratings and suggestion history. The template id comes from the
  subject's `downward_review` assignment row, including when that row is blocked.
- **`calibrate_review_answer(program_id, target_id, assessment_template_id, question_id, action, answer_id?, rating?, comment?)`**
  — `action` is `suggest` or `apply`. Applying a rating does not complete calibration.
- **`complete_review_calibration(program_id, target_id, assessment_template_id)`** — marks one
  person's calibration complete. Kept separate from rating edits.
- **`get_review_delivery(delivery_id)`** — the results package, what the employee will see, and
  the available actions. `delivery_id` comes from the `delivery` assignment row.
- **`update_review_delivery(delivery_id, action, summary?, excluded_answer_ids?)`** — `action`
  is `edit`, `request_approval`, `approve` or `share`. Approving does not release results;
  sharing does.

### Setting up a draft cycle (admin)

Used by `setup-review-cycle`. Parameters read from the Topicflow source (`chatbot/llm_types.py`
and `compliance/program_setup_registry.py` on `production`) on 2026-10-09; not yet called live
from this library, because the test grant lacked `reviews:write`. What to configure, with the
evidence: [review-templates.md](review-templates.md).

All five writes need `reviews:read` and `reviews:write`. Each returns a preview with
`preview_fields` and a `pending_id`; `confirm_creation` saves it. **Each part gets its own
preview and its own confirmation.** Nothing here publishes: the saved draft ends with a
**Review settings and publish** link, and publishing happens in the web app.

- **`get_review_program_setup(program_id)`** — the saved draft, `validation_issues` (blocking),
  a top-level `warnings` list (never blocking; say each one before giving the link), and a
  `timeline`.
- **`list_review_program_setup_options(resource_type="all", assessment_type?, search?, page=1, limit=25)`**
  — `resource_type`: `participant_scopes`, `question_sets`, `one_on_one_templates`,
  `career_framework`, `core_values`, `talent_indicators`. `assessment_type`: `performance`,
  `peer`, `upward`. The source of every id the writes take.
- **`duplicate_review_program(program_id, kickoff_date?, title?)`** — preview of copying an
  earlier cycle into a new draft. It keeps the steps, question sets, participant rule,
  calibration and reminders; dates move to the new kickoff and keep their length; the title is
  "Copy of <title>" unless given; the copy does not repeat, and calibration groups are not copied.
- **`configure_review_program_workflow(program_id?, title, kickoff_date, due_date, evaluation_period, evaluation_period_start?, evaluation_period_end?, enabled_steps, step_due_dates?, peer_responder_selection?, peer_anonymity?, upward_anonymity="not_anonymous", share_with_subject=true, one_on_one_template_id?)`**
  — omit `program_id` to create a new draft.
  - `evaluation_period`: `past_week` … `past_year` are rolling lookbacks ending on kickoff; a
    named quarter or year is `custom` with its own start and end. `past_quarter` is not Q3.
  - `enabled_steps`: `pre_calibration`, `peer_nomination`, `self_review`, `peer_review`,
    `upward_review`, `downward_review`, `post_calibration`, `delivery`, `one_on_one`.
    **`self_review` and `downward_review` go together.** At least one of downward, peer or
    upward. Calibration needs the downward review.
  - **Calibration is a step, one of two.** `pre_calibration` runs *before any review is
    started*; `post_calibration` runs *after the reviews are completed* and makes the manager
    review's results wait for admin approval. "Calibrate before delivery" is `post_calibration`.
    Not both.
  - `peer_responder_selection` (required with peer review): `same_manager_peers` (automatic),
    `manager_selection`, `subject_selection`. Include `peer_nomination` exactly for the last two.
    **Ask; the server refuses a silent default.**
  - `peer_anonymity` (required with peer review) and `upward_anonymity`: `not_anonymous`,
    `semi_anonymous` (names hidden from the person reviewed, shown to other viewers), `anonymous`
    (names hidden from everyone but the reviewer).
  - `share_with_subject: true` needs the `delivery` step. A final `one_on_one` needs
    `one_on_one_template_id`.
  - The preview carries a **`timeline`**: dated entries with a `label`, a `recipient_count` on
    entries that reach people, `timeline.warnings` that name the people the review will miss
    (for example, people with no manager), and sometimes a `summary_note`. Put a number only on
    an entry that has `recipient_count`. The timeline is a forecast, not a setting to approve.
- **`configure_review_program_questions(program_id, templates[])`** — one entry per enabled
  review type: `assessment_type` (`performance`, `peer`, `upward`), then either
  `existing_question_set_id` or `new_question_set {title, sections[{title, description,
  questions[]}]}`. Existing sets are reused, never edited.
  - **The self and manager reviews share one `performance` set.** Each question's `responders`
    says who answers it: `subject_only` (the self review), `manager_only`, or
    `manager_and_subject` (the default: both). There is no setting that hides a self-answer from
    the manager until the manager submits.
  - Per question: `title`, `question_type` (`text`, `rating`, `multiple_choice`),
    `description`, `response_required=true`, `comment` (`optional`, `required`, `none`),
    `subject_visibility` (`visible`, `hidden`), and for ratings `start_value`, `end_value`,
    `labels`, `label_descriptions`; for multiple choice `options`, `option_descriptions`.
  - Optional blocks: `role_review` (current and next role against the career framework),
    `goal_review`, `core_value_review` (each a scale with `responders`, default `manager_only`),
    and `talent_indicators {section_title, section_description, indicators[{talent_indicator_id,
    description, comment, responders="manager_only", subject_visibility="hidden"}]}`. Indicator
    ids come from the setup options; a new indicator is created in the web app.
- **`configure_review_program_participants(program_id, applies_to, team_ids?, manager_ids?, user_ids?, excluded_user_ids?, hired_after?)`**
  — replaces the participant rule. `applies_to`: `organization`, `managers`, `ics` (people with
  no direct reports), `creator_direct_reports`, `creator_management_tree`, `departments`,
  `reports_to`, `users`. `hired_after` excludes people hired after that date.
- **`configure_review_program_notifications(program_id, reminders[])`** — replaces the reminder
  schedule. Each reminder: `scheduled_date`, `steps` (underscore names, from `peer_nomination`,
  `self_review`, `peer_review`, `upward_review`, `downward_review`, `one_on_one`), `channels`
  (`email`, `slack`, `teams`) and `message`. An empty list clears them. Draft reminders stay
  inactive until the cycle is published.
- **A stale preview is refused.** Read the setup again and preview again.

### Missing from this MCP

- **No tool publishes a review.** A draft can be set up over MCP; launching it happens only in
  the web app.
- **No "top collaborators" read.** The Topicflow app works this out for the profile page; over
  MCP a skill builds its own signal from meetings, work signals and feedback.
- **No tool changes one step's due date.** `change_review_dates` moves the review's own dates
  only. A step date is a web-app change.

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

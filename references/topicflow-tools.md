# Topicflow tools — what exists, what is missing, how to degrade

Ground truth for the Topicflow MCP as of 2026-08. Skills name practices, not tools; this
file is where tool detail lives so a rename touches one file.

Tool names below are unprefixed. In an MCP client they appear namespaced (for example
`mcp__claude_ai_Topicflow__list_meetings`). Match on the suffix.

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
per change, but one approval from the manager covers the batch they approved.

## Reads

- **`get_user_infos(target_names?, team_name?, include_career_track?)`** — profiles. Pass
  full names or IDs in `target_names`, or a `team_name` for a whole team (fuzzy match
  accepted). `include_career_track: true` adds level, competencies, responsibilities, and
  next role — use it for career and review work, skip it otherwise. **This is how you get
  user IDs.** Resolve IDs once at the start of a run and reuse them; IDs beat names
  everywhere else.
  **The `reports` array is not a trustworthy roster.** Observed in a live org:
  it returned a duplicate account with the same name as the manager themselves. Treat it as
  a hint to confirm, never as the roster — which is what C1's contract already requires.
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
  `status` filters confirmed / tentative / cancelled (values 1, 2, 3 — confirm the mapping
  against a live response before relying on it). **`with_notes_and_transcript: true`
  returns topics, agendas, and notes** — this is where open action items and past topics
  live, and it is the substitute for a dedicated action-item tool. The payload is large:
  always pair it with a date filter and a small `limit`.
  **`meeting_id` and `topic_id` for any write come from here.**
- **`list_goals(owners?, contributors?, status?, visibility?, due_date_start?, due_date_end?, search_term?, limit?, order?)`**
  — returns **visible open goals**; defaults to the current user's own. Pass `owners:
  <report id>` for a report's goals. `status`: 0 none, 1 on_track, 2 at_risk, 3 off_track.
  Closed and completed goals are not reliably retrievable — see the gaps below.
- **`list_feedback(recipients?, sender?, state?, created_datetime_start?, created_datetime_end?, search_term?, limit?, order?)`**
  — informal feedback. `state`: 1 draft, 2 sent, 3 requested. Filter `state: 2` for what
  actually reached someone. This is the primary source for feedback recency; it does not include
  recognition.
- **`list_assessments(target?, responder?, program_id?, program_title?, state?, include_content?, submitted_datetime_start?, submitted_datetime_end?)`**
  — review-cycle assessments. `target` is the person being assessed, `responder` is the
  person who wrote it. `state` defaults to 2 (submitted). `include_content: true` for the
  written answers — only when you need the text.
- **`list_review_programs(current_only?, state?, title?, program_id?, include_participants?, include_participant_status?)`**
  — review cycles. `current_only: true` for what is running now, `state: "published"` for
  launched cycles.
- **`list_my_review_tasks(current_only?, include_completed?, program_id?, program_title?)`**
  — review work assigned to the manager. The trigger for `review-prep`.
- **`query_external_events(start_datetime, end_datetime, target?, sources?)`** — work
  signals from connected tools (GitHub, Linear, and others). **Both datetimes are
  required**, ISO 8601 UTC (`YYYY-MM-DDTHH:MM:SSZ`). `target` defaults to the current
  user, so **always pass the report's ID** when looking at someone else. This is evidence,
  not performance: it shows what happened, never how well.

## Writes (all preview-then-confirm)

- **`add_meeting_topics(meeting_id, topics[{title, notes?}])`** — `title` is plain text,
  no markdown. `notes` is an array where each entry is one block; consecutive entries
  starting with `- ` merge into one bulleted list, and an empty string `""` inserts a
  blank line. Links as `[text](url)`.
- **`edit_meeting_topic(topic_id, title)`** — retitle only.
- **`edit_meeting_topic_notes(meeting_id, topic_id, text, operation?, notes_type?)`** —
  `operation` defaults to `append`; use `replace` only when the manager asks to overwrite.
  `notes_type` defaults to `auto` (individual notes on formal 1-on-1s when active,
  otherwise shared). **Shared notes are visible to the report. Never put a manager-private
  observation in shared notes.**
- **`create_feedback(title, description, recipient_*?, sender_*?, recipients_can_view?, recipients_managers_can_view?, admins_can_view?, is_draft?)`**
  — two modes. *Giving* feedback: set `recipient_*` to the person it is about.
  *Requesting* feedback: set `sender_*` to the person you are asking to **write** it and
  `recipient_*` to the **subject** it is about. `description` is plain text, 2-4 sentences.
  Visibility defaults: recipient can view, managers and admins cannot. For corrective
  feedback keep it that way (P7, private-first).
- **`create_recognition(title, recipient_id? | recipient_ids? | recipient_email? | recipient_name?, core_value_id?)`**
  — **`title` is the message**, 2-4 sentences, plain text, no markdown. `recipient_name`
  also accepts a team name. Never set the recipient to the current user.
- **`create_goal(title, scope, key_results[], owner_*?, due_date?, state?, visibility?)`** —
  `key_results` is required and must be measurable (P11). `owner_*` defaults to the current
  user, so **pass the report's ID** when the goal is theirs.
- **`edit_goal(goal_id, title?, status?, state?, visibility?, scope?, owner_*?, key_results[{op, id?, title?}]?)`**
  — `key_results` takes `op: "add" | "edit" | "remove"`. `state`: 0 draft, 1 open, 2 closed
  (closing sets the completion date). `owner_*` **replaces all owners** — be careful.
- **`create_goal_checkin(goal_id, message?, current_value?, key_results[{key_result_id, current_value}]?)`**
  — plain text message. Percentages are whole numbers (50, not 0.5). A check-in should
  come from the goal's owner; a manager posting one on a report's goal is a last resort,
  not the default (P15).
- **`edit_feedback`**, **`edit_recognition`** — amend before or after sending; same
  preview-then-confirm flow.

## Gaps and fallbacks

Four tools this library wants and does not have. Build order matters: (1) blocks a
library-wide rule, the rest degrade.

**1. `save_private_note(person, text)` — P0.** Blocks library convention 3 (write-back).
**In dev: [TF-1595](https://linear.app/topicflow/issue/TF-1595).** *Fallback until it lands:*
produce the note text in third person and ask the manager to keep it. Where the manager confirms
that individual 1-on-1 notes are private to them in their deployment,
`edit_meeting_topic_notes(notes_type: "individual")` on a standing "Context" topic works —
**ask before assuming**, because shared notes are visible to the report.

**2. `get_person_context(person, since)`.** A curated synthesis: role, current focus,
recent work, open items. *Fallback:* compose it — `get_user_infos` +
`query_external_events` + `list_goals(owners=id)` + `list_meetings(is_oneonone=true,
with_notes_and_transcript=true, limit=2-3)`. Four calls instead of one; resolve the ID
first so all four hit the right person.

**3. `read_ai_memory(person?)`.** Durable observations and facts. **Also in
[TF-1595](https://linear.app/topicflow/issue/TF-1595)**, which opens up memory and profile notes
alongside note saving. *Fallback until it lands:* past 1-on-1 topic notes via
`list_meetings(with_notes_and_transcript=true)`, plus asking the manager once. Without it,
"unknown" and "not true" are indistinguishable — so for preference questions (P9), ask rather
than guess, and never report an absence as a fact.

When TF-1595 ships, the skills that carry the heaviest workarounds are `save-context` (the whole
fallback ladder collapses to one call), `relationship-drift` (a real ping ledger, so the
per-month cooldown becomes enforceable across runs), `stuck-work` (same, per item), and
`give-recognition` (preference lookup instead of a private-by-default guess).

**4. `list_action_items(person)`.** Open action items across 1-on-1s. *Mostly covered:*
`list_meetings(with_notes_and_transcript=true)` returns topics and notes, so action items
are readable from the last two or three meetings — that is what `prep-1on1` does. A
dedicated tool would remove the keyword-scanning and the recency window.

**Also missing, and worth knowing:**

- **No completed-goal history.** `list_goals` returns open goals. `review-prep` cannot
  prove "goals hit last quarter" from the API alone: list what is open with status, then
  ask the manager to confirm what closed, and mark it as an evidence gap rather than
  reporting zero.
- **`list_recognitions` exists but is currently unreachable.** It is registered in the tool
  registry and requires the OAuth scope `recognitions:read`, which is missing from the
  server's supported scopes — so no client can hold it, and the tool never appears in
  `tools/list`. From a client the effect is that recognitions can be **created and edited but
  not read**. Tracked in [TF-1596](https://linear.app/topicflow/issue/TF-1596), folded into
  [TF-1595](https://linear.app/topicflow/issue/TF-1595).
  Recognition is **not** carried by `list_feedback` — a live check found feedback
  and feedback requests there and no recognitions, which is consistent with them living
  behind their own tool. Until the scope ships, treat recognition recency as unreadable and
  say so, rather than pinging on a false drought.
  **The general lesson, worth keeping after this is fixed:** a tool that is scope-gated is
  invisible, and from the client side "the tool is not there", "the tool returned nothing",
  and "nothing has ever happened" look identical. That is why the C5 contract withholds the
  drought conclusion on an unverified empty result rather than trusting it.
- **No calendar write.** Nothing here schedules, reschedules, or cancels a meeting. A
  "schedule a 1-on-1" action is always a request to the manager — the skill can only add
  topics to a meeting that already exists.
- **No org chart traversal.** There is no "list my direct reports" tool.
  `get_user_infos(team_name=...)` covers a team, and `list_meetings(is_oneonone=true)`
  reveals who the manager actually meets one-on-one. Team-wide skills should ask the
  manager to confirm the roster once rather than inferring it silently every run.

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

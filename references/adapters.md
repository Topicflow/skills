# Adapters — binding a capability to a real backend

The capabilities and their contracts are in [source-map.md](source-map.md). This file is the
practical half: known backends, and the recipe for a backend nobody here has heard of.

**This list is a starting point, not a closed set.** Any MCP server that can satisfy a contract can
be bound to that capability. Any capability can be bound to a different backend from its
neighbours. A manager with goals in Notion, private notes in Todoist, work signals in Linear, and
1-on-1 dates in a calendar has four adapters and no conflict.

## Binding an unknown backend — the recipe

Use this whenever a manager names a tool that is not below. It is the normal path, not a fallback.

**1. List what the server actually exposes.** Read the tool names and schemas. Do not guess from
the product's marketing surface — what the MCP exposes is usually a subset.

**2. Pick the capability you are trying to satisfy** and read its contract in
[source-map.md](source-map.md). You are looking for a read that returns the required fields, and,
where the capability writes, an append.

**3. Match tools to the contract.** Most tools fall into one of three shapes: a *list/query* with
filters, a *get* by id, and a *create/update*. A capability usually needs a query plus one of the
other two.

**4. Test the calls before recording them.** One real call per direction. A tool that exists is not
a tool that returns what you need — empty results, permission errors, and unexpected shapes are all
common, and all look like success until you look.

**5. Record the binding**, with all four required parts: the exact calls, the field mapping, what is
missing, and the caveat in the manager's own language.

**6. Say what the binding cannot do**, in the same breath as saying it works. Every backend is
missing something.

**Never invent a tool or a parameter.** If no tool satisfies the contract, the binding is `none` —
which is a real, recordable answer, not a failure.

### Worked example — private notes in Todoist

The manager wants C6 durable notes in Todoist. There is no Todoist adapter below, so the recipe
runs. What matters is the shape of the reasoning; the tool names come from whatever that server
exposes when you list it.

- **The contract** wants: read a person's notes, append a dated line, and know whether the
  destination is private.
- **Listing the server** shows task create, task list with a project filter, and project list. No
  full-text search across tasks.
- **The mapping** falls out: one project per report, one task per fact, the fact as the task
  content. Read is the project-filtered list; append is task create.
- **The test** reveals the gap that matters: without search, dedup means reading the whole project
  list each time, which is fine at ten facts and poor at two hundred.
- **Privacy** is the question that must be asked rather than assumed. A personal Todoist account is
  private; a shared team project is not, and manager-private observations never go somewhere the
  report can read.

The recorded binding then looks like the block in [source-map.md](source-map.md): the two calls
verbatim, the mapping, `missing: search`, and a caveat the skill can repeat — "dedup reads the
whole project, so it gets slower as notes pile up."

## Known adapters

Exact Topicflow parameters, its write pattern, and its gaps: [topicflow-tools.md](topicflow-tools.md).

**Topicflow** — C1 `get_user_infos`. C2 `list_meetings(is_oneonone: true,
with_notes_and_transcript: true)`, the richest single call in any adapter: dates, cancellations,
topics, notes, action items. C3 `query_external_events(target, start_datetime, end_datetime)`. C4
`list_goals(owners)`, open goals only. **C5 `list_feedback` / `list_assessments` — the only adapter
that satisfies C5 at all.** C6 in dev ([TF-1595](https://linear.app/topicflow/issue/TF-1595)). C7
`create_feedback` / `create_recognition`. C8 `add_meeting_topics`. All writes are
preview-then-`confirm_creation`.

**Notion** — C1 `notion-get-users`, or `notion-search(query_type: "user")`; no org chart, so the
roster still gets asked. C2 `notion-query-meeting-notes` filtered on `attendees`
(`person_contains`) and `created_time`, then `notion-fetch(id)`; **records notes written, not
meetings held**, and cancellations are invisible. C3 `notion-search` reaches connected Slack,
GitHub, Jira, and Linear, but carries no reliable state history — bind C3 elsewhere if staleness
matters. C4 `notion-fetch(<database url>)` for the schema and `collection://` URL, then
`notion-query-data-sources`; **read the schema, property names differ per workspace**. C5 none
natively; a log database can be created. C6 the strongest option today — a page per person,
`notion-create-pages` then `notion-update-page(command: "insert_content", position: {type: "end"})`,
read back with `notion-fetch`. C8 append to the meeting-note page.

**Linear / GitHub** — C3, and the best adapter for it. Issue and PR history carries `first_seen`,
`last_movement`, and state transitions, which is what staleness actually needs. It also carries the
*reason* a review is stuck — a requested change, a failing check, a thread gone quiet — which is
the difference between a useful check-in and an annoying one. Also C1 partially, from assignees.

**Google Calendar** — C2, dates and cancellations only, no content. That covers cadence and
cancellation drift well and leaves the career-topic check unbound. Often the right partner for a
Notion C2 binding, which has the opposite strengths.

**Slack** — C3 partially, for wins that never touch a tracker: a customer save, a hard conversation
handled well. C7 by direct message with explicit approval (`slack_send_message_draft` prepares one).
Read-only otherwise, and **never post about a person to a channel**.

**A plain file, or the conversation** — always available. C1 and C6 work fine as a text file the
manager keeps. Every capability can bind to `ask the manager`, and for C1 that is the recommended
binding on every backend.

## Choosing between two candidates

When more than one backend can satisfy a capability, prefer in this order:

1. **The one with the fields the contract needs**, especially timestamps. A source without
   `last_movement` cannot support a staleness claim no matter how convenient it is.
2. **The one the manager already writes to.** A perfect source nobody updates is worse than a
   partial source that reflects reality.
3. **The one that can be written back to**, where the capability appends.

Record the loser in the binding as a note. When the winner turns out to be wrong, the rebinding is
one row.

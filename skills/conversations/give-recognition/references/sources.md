# Sources — give-recognition

The calls this skill makes, the parameters it needs, and the claims it withholds when a call
fails or comes back empty. Maintainers: this file is kept in step with the library's
data-sources.md (sections 0, 4, 7 and 8) and topicflow-tools.md. When either changes, check this
file.

Tool names are unprefixed. In an MCP client they appear namespaced (for example
`mcp__claude_ai_Topicflow__create_recognition`). Match on the suffix.

## The org — one call, reused

`get_organization_context()`. Make it once per run, before naming a feature or a core value.

- `labels.recognition` is the org's own word. An org that says "kudos" reads "kudos".
- `core_values` — each has a `title` and a `status`. Only an `active` title can tag a new
  recognition.
- `features.recognitions` false → say the org does not use recognition, and offer the same text
  as a direct message instead.

*Withheld if it fails:* use the plain word "recognition" and do not claim it is theirs. Set no
core value.

## The person

`get_user_infos(target_names)` — the person's ID. Resolve it once and reuse it: an ID never
matches the wrong person when two people share a name.

## The win

`query_external_events(start_datetime, end_datetime, target)` — both datetimes are required, ISO
8601 UTC (`YYYY-MM-DDTHH:MM:SSZ`). `target` defaults to the current user, so **always pass the
person's ID**. Keep the window short: the event is days old, not months.

This gives the artifact, the date, and often the impact the user only half-remembers. It is
evidence of what happened, never of how well. It is not a menu to choose a win from when the user
named a person and nothing else (Method step 1).

*Withheld if it fails or is empty:* draft from the user's account and say the work record was not
read. Never fill the gap with a guessed artifact.

## The preference

`list_private_notes(profile: <person id>, limit: 10)` — the user's own notes about that person,
newest first. Look for a public-or-private preference.

Private notes cover only the user and the user's own direct reports. For a peer, a skip-level,
or the user's manager, nothing can be on file: ask.

*Withheld if the read is absent or fails:* do not say "no preference on file". Say the notes
could not be read, and ask. When the user cannot be asked, draft private and say why. Never
broadcast on a guess.

## The distribution glance — manager's chair only

`list_recognitions(recipients: <report ids>, created_datetime_start, limit, order: "-created")`
— shipped in the 2026-08 MCP update. `core_values` filters by **name**, not ID. Recognition is not
in `list_feedback`; do not read one to reason about the other.

*Withheld — the strictest rule in the library.* Where the read is absent, errors, or returns an
empty that cannot be verified as real history: **no drought finding and no equity finding, for
anyone.** Not "none found". Not a hedge. Nothing. "Absent", "returned nothing" and "nothing ever
happened" look the same from a client, and a record nobody has written to yet has no gap to
measure. The glance runs on the manager's own memory instead, and the output says so.

With a verified read, dates are citable, and a measured gap is a legitimate one-line note.

## Sending

Every write here is a preview. It returns a draft and a `pending_id`; nothing is sent until
`confirm_creation(pending_id, confirmation_summary)` runs. Show the draft, get one approval, then
confirm once. Never describe the `pending_id` to the user. Never ask twice for the same approval.

**Public:** `create_recognition(title, recipient_id, core_value?)`.

- **`title` is the message:** two to four sentences, plain text, no markdown.
- `recipient_ids` takes a list for a shared win. Never include the current user.
- `core_value` is an exact active value **title** from the org call, never an ID. Set it only
  where the contribution plainly is that value. A stretched match reads as box-ticking and
  cheapens the rest; leaving it unset is right far more often than not.

**Private:** `create_feedback(title, description, recipient_id)`.

- `description` is the message, the same two to four sentences. `title` is 5 to 10 words.
- Keep the visibility defaults: the recipient can view; managers and admins cannot.

`confirm_creation(pending_id, confirmation_summary)` — the summary is plain language, such as
"Send recognition to Gavin Johnston".

*Where nothing can be sent* (the write is missing or fails): hand over the text with a note on
the audience it assumes. Two to four specific sentences were always the whole product.

---
name: setup-sources
description: Work out where a manager's team data actually lives — Topicflow, Notion, a calendar, an issue tracker, or nowhere — and record it so every other skill knows what it can and cannot see. Use when a manager first installs these skills, when a skill reports a missing source, when they ask what these skills can do with their setup, or when they connect a new tool.
---

# Setup sources

Run this first. It answers one question for the whole library: **where does this manager's team
data live?** Then it says plainly what will work, what will work with less, and what will not work
at all — so nobody discovers the gap halfway through a review cycle.

None of these skills require Topicflow. A manager on Notion, or on a calendar and an issue tracker,
or on nothing but this conversation, still gets a working library. This skill is what makes the
difference visible instead of surprising.

Serves *communicates well* (P17) — an honest account of what the tooling can see is the first
thing a manager needs from it.
Capability detail: [source-map.md](../../../references/source-map.md).

## When to use

- First install, before any other skill runs.
- A skill reports that a source is missing or unreadable.
- The manager asks what these skills can do, or whether they work without Topicflow.
- The manager connects a new tool, or their team changes.

## Non-negotiables

- **Detect before asking.** Check what is connected, then ask only what detection cannot answer.
- **At most three questions.** The roster is the one worth spending a question on.
- **Never claim a capability that was not verified.** A connected server is not the same as
  readable data — a real call must have succeeded.
- **Name what will not work, without softening it.** A manager who is told the equity gates cannot
  run is better served than one who gets a confident drought alert built on nothing.
- **Never create anything without approval**, including the Notion pages this skill offers to set up.
- The recorded map is a starting point, not a contract. Any skill that finds reality different says
  so and updates it.

## Method

**1. Detect what is reachable.** For each backend that appears connected, make one cheap read and
see whether it actually returns data. Connected-but-empty and connected-but-unauthorized are both
common, and both look like "connected" until something is called.

**2. Map the eight capabilities.** For each of C1-C8 in
[source-map.md](../../../references/source-map.md), record the best available source and mark it
`full`, `partial`, or `none`. Be strict: partial means the data exists but is thinner than the
skill wants — calendar dates with no meeting content, Notion meeting notes that only exist when the
manager wrote one.

**3. Ask what detection cannot answer**, up to three questions:

1. **The roster.** "Who reports to you?" No backend answers this reliably, and a missing person is
   a real harm. Always ask.
2. **Where notes should go**, if more than one destination is possible. This is where every skill
   writes back.
3. **Where goals live**, only when a goals source was not detected.

**4. Handle the recognition gap explicitly.** Where C5 came back `none` — the usual case without
Topicflow — say what it costs: no drought detection, no equity check across reports, no feedback
recency in 1-on-1 prep. Then offer the fix: a simple log the manager keeps, one row per thing said,
with person, date, kind, and what was said. Offer to create it. It works from the day it exists,
never backwards, and say that too.

**5. Record the map** to wherever notes go (C6). One short block, so every later run reads it
instead of re-detecting.

**6. Report in three groups.** Works fully. Works with less, and what "less" means concretely. Does
not work, and what would fix it. Every line names the skill it affects, because "C5 is unavailable"
means nothing to a manager and "I can't tell you who's been overlooked for recognition" means
everything.

## Sources

**Detection reads, one per backend.** Topicflow: `get_user_infos(target_names: [<the manager>])`.
Notion: `notion-fetch(id: "self")` for the workspace identity, then `notion-get-users(page_size: 5)`
and `notion-query-meeting-notes` with a recent date filter. Linear: `list_teams`. Slack:
`slack_search_users`. Google Calendar: any small read.

**Capability mapping** is entirely in [source-map.md](../../../references/source-map.md) — this
skill does not restate it, so a new backend is added in one place.

**Writes, all after approval.** Notion: `notion-create-pages` for a People page or a recognition
log, `notion-update-page` to record the map. Topicflow: the note fallback ladder in
[topicflow-tools.md](../../../references/topicflow-tools.md), since `save_private_note` is still in
dev ([TF-1595](https://linear.app/topicflow/issue/TF-1595)).

**Degrading.** No backend at all is a valid outcome, not an error. Say which skills still work from
conversation alone — `give-feedback`, `give-recognition`, `management-practices`, and the drafting
half of `prep-1on1` all do — and record that the manager is the source for everything else.

## Gate

Not applicable. This skill only runs when a manager or another skill asks for it. It never pings.

## Write-back

The capability map itself, the roster, the chosen note destination, and anything the manager says
about where their team's data lives. Re-run and update it when a tool is connected or the team
changes.

## Output

Three groups — works, works with less, does not work — each line naming the affected skill and, for
the gaps, the one thing that would fix it. Plain text, no tables.

`[create the recognition log]` `[save this map]` `[re-run detection]`

## Worked example

**Manager:** I use Notion, not Topicflow. Do these actually work for me?

**Agent:** Checking what's reachable, then I have one question.

> Notion is connected: 34 workspace members, and meeting notes going back to March. Linear is
> connected. No Topicflow, no calendar.
>
> One question: who reports to you? Notion has no org chart, so this is the one thing I can't work
> out on my own.

**Manager:** Tony, Nadia, Sam, Priya.

**Agent:**

> Saved. Here is what you get.
>
> **Works fully**
> - `prep-1on1` — your 1:1 notes are in Notion, so open action items and past topics are readable.
> - `save-context` — a People page per report, appended to as you tell me things. This is actually
>   better than a Topicflow setup today.
> - `give-feedback`, `give-recognition` — drafting was always the valuable part. You send them.
> - `stuck-work` — Linear covers stalled tickets.
>
> **Works with less**
> - `relationship-drift` — I can see when you last wrote a 1:1 note, not when the meeting was
>   scheduled or cancelled. So a gap might mean you skipped the note, not the meeting. Connecting
>   Google Calendar would close that.
> - `review-prep` — goals and Linear work are readable; peer input isn't, so packs will lean on
>   what you tell me.
>
> **Does not work**
> - `recognition-scan`. Nothing in Notion records who you recognized and when, so I can't tell you
>   who's been overlooked — and I won't guess, because a made-up drought about a real person is
>   worse than silence.
>   The fix: a small log, one row per thing you say to someone — person, date, kind, what you said.
>   I can create it in Notion now. It only works from today forward.
>
> `[create the recognition log]` `[save this map]` `[re-run detection]`

Note what this refuses to do: it does not claim `recognition-scan` half-works, and it does not
quietly downgrade it to something useless. It names the one skill that is genuinely off, says why,
and offers the smallest thing that turns it on.

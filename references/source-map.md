# Source map — capabilities, contracts, and bindings

The library needs eight things. It does not care where any of them come from.

Each of the eight is a **capability** with a **contract**: the fields a skill needs back, and what
a skill must not conclude when a field is missing. A **binding** connects one capability to one
backend and records the exact calls that satisfy the contract.

**Bindings are per-capability and independent.** Goals in Notion, private notes in Todoist,
1-on-1 history in a calendar, work signals in Linear, and nothing at all for recognition is a
perfectly ordinary setup. Any capability can be rebound at any time without touching another.

**No skill names a backend.** A skill declares the capabilities it needs and resolves each through
the binding. That is why a backend nobody has heard of works: the binding holds the calls, the
skill holds the practice. Known adapters and the recipe for an unknown one:
[adapters.md](adapters.md). [`setup-sources`](../skills/foundations/setup-sources/SKILL.md) writes
and rewrites the bindings.

## The eight capabilities

| | Capability | Needed by |
|---|---|---|
| **C1** | Roster | every team-wide skill |
| **C2** | 1-on-1 history | prep-1on1, relationship-drift, weekly-brief, onboard |
| **C3** | Work signals | prep-1on1, recognition-scan, stuck-work, review-prep, weekly-brief |
| **C4** | Goals | goal-checkin, prep-1on1, review-prep |
| **C5** | Feedback and recognition record | give-feedback, give-recognition, recognition-scan, review-prep |
| **C6** | Durable notes | save-context, and every skill's write-back |
| **C7** | Deliver a message to a person | give-feedback, give-recognition, request-feedback |
| **C8** | Put a topic on an agenda | prep-1on1, onboard, goal-checkin, stuck-work |

## The contracts

Each contract lists what a skill needs, and the **withheld conclusions** — the claims that become
unavailable when a field is missing. Withheld conclusions are not optional politeness. They are
the difference between "I don't know" and a false statement about a person.

**C1 — Roster.** Per person: `name`, plus `id` or `email` where the backend has one.
*Withheld without it:* nothing team-wide runs. Ask the manager; never infer a roster silently, and
never proceed with a partial one — a missing person is a real harm at review time.

**C2 — 1-on-1 history.** Per person, a list of: `date`, `status` (held or cancelled), and where
available `topics`, `notes`, `action_items`.
*Withheld:* no `status` → never report cancellations, and never report their absence either. No
`notes` → no action-item carry-over and no career-topic recency. **Every binding must record what
its dates actually measure** — a meeting that happened, or a note that got written. They are not
the same claim, and a skill must repeat the distinction rather than smooth over it.

**C3 — Work signals.** Per person, a list of: `date`, `title`, `kind`, and where available `url`,
`state`, `first_seen`, `last_movement`.
*Withheld:* no `last_movement` → **no staleness claim at all**; a skill may not infer that work is
stuck from a last-edited timestamp or a search hit. No signals → `stuck-work` and
`recognition-scan` have nothing to detect on and say so once.

**C4 — Goals.** Per person, a list of: `objective`, and where available `measure`, `status`,
`last_checkin`, `due`.
*Withheld:* no `last_checkin` → **no staleness claim**; report shape and status problems only. No
`measure` → that is itself the finding (P11), not a gap. Closed-goal history is unavailable on most
backends, so "nothing completed" is never a conclusion.

**C5 — Feedback and recognition record.** Per person, a list of: `date`, `kind`, `text`, `from`.
Append where the backend allows it.
*Withheld:* no record → **no drought, no recency, no equity finding**. Not "none found" — not
found. This is the capability most likely to produce a false claim about a real person, so the
rule is absolute: unverified silence is never reported as neglect. Where no backend can hold this,
`setup-sources` offers a log; it works from creation forward and never retroactively.

**C6 — Durable notes.** Read a person's notes; append a dated line. Both, ideally; append alone is
still useful.
*Withheld:* no read → dedup is impossible, so ask rather than duplicate, and never claim a fact is
new. No write → produce the sentence and say plainly it was not filed.
**Privacy is part of this contract.** A binding records whether the destination is private to the
manager. Where it is not, or is unknown, manager-private observations do not go there. Dropping the
note is better.

**C7 — Deliver a message.** Send text to one person, with an audience the manager chose.
*Withheld:* no delivery → the skill produces the draft and says who should hear it and when. It
never claims something was sent. This is the normal case, and the draft was always the valuable
part. **Never post about a person to a channel from a skill.**

**C8 — Put a topic on an agenda.** Append a title and notes to an upcoming meeting.
*Withheld:* no agenda write → output the topics as text to paste.
**No backend schedules a meeting.** "Schedule a 1-on-1" is always a request to the manager.
Where the target is shared with the report, manager-private reasoning stays out of it.

## The binding record

One block per capability, written by `setup-sources` and readable by every skill. Plain text so a
manager can edit it by hand, and so it survives being pasted anywhere.

```
# Source bindings — <manager>, updated <date>

C4 goals: notion
  read: notion-fetch("<database url>") for schema, then
        notion-query-data-sources(sql over collection://<id>)
  fields: objective=Objective, status=Health, due=Target date
  missing: last_checkin
  caveat: staleness unmeasurable — report shape and status only

C6 notes: todoist
  read: <the call that lists items under the person's project>
  append: <the call that adds an item to it>
  private: yes (confirmed by manager 2026-08-17)

C5 feedback record: none
  effect: no drought detection, no equity check, no feedback recency
```

Four things make a binding usable, and a binding missing any of them is incomplete:

1. **The exact calls**, including how the person is passed. A skill executes these; it does not
   re-derive them.
2. **The field mapping**, because column names differ per workspace. Never assume a field called
   `Status`.
3. **What is missing**, which drives the withheld conclusions above.
4. **The caveat in the manager's language** — one line the skill can repeat verbatim in its output.

`none` is a valid binding and must be recorded explicitly. An unrecorded capability is unknown; a
capability bound to `none` is known-absent, and the two produce different behaviour.

**Where the binding itself lives** is the one bootstrap problem. In order: a local file if the
agent has a filesystem, otherwise the C6 destination, otherwise the conversation. `setup-sources`
asks once and records the answer at the top of the block.

## Rules that hold on every binding

1. **Say what you could see.** Any skill that ran with a missing capability names it in one line,
   in the manager's language, using the binding's caveat.
2. **Missing is not zero.** Unavailable produces "unknown", never a negative finding about a person.
3. **Ask before scanning.** One question beats a wide, uncertain search. The three-question cap
   still applies.
4. **Rebinding is one row.** Moving goals to a new tool changes one block and nothing else — not a
   skill, not another capability.
5. **Degrade loudly, fail rarely.** Losing a capability narrows a skill; it rarely stops one. The
   exceptions are `stuck-work` and `recognition-scan` without C3, which have nothing to detect.

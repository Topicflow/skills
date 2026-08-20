---
name: goal-checkin
description: Post progress on a goal — a check-in message with current numbers, a status change, or an adjusted key result. Use when someone says "update my goal", "we hit 60 percent", "mark the migration at risk", "check in on my goals", or asks which goals they have not updated lately.
---

# Goal check-in

A goal with no check-ins is invisible at review time, whatever actually happened. This skill
makes the update take one minute: what moved, what the numbers are now, whether the status still
tells the truth. The golden path is the goal's owner posting their own progress — a direct report
saying "update my goal" is exactly who this is for.

Creating or reshaping a goal is `create-goal`, not this.

Serves *is productive and results-oriented* (P17). Enforces P12 (goals stay alive), P15 (the
check-in is the owner's voice), P11 (measures stay measurable).
Rules: [management-rules.md](../../../references/management-rules.md).

## When to use

- The goal's owner wants to post progress, in numbers or in words.
- Someone wants to change a goal's status — at risk, off track, back on track.
- Someone asks which of their goals they have not updated lately.
- A manager asks about a report's goal — this skill helps, but never posts in the report's name.

## Non-negotiables

- **A check-in belongs to the goal's owner.** Never post on someone else's goal; when a manager
  raises a report's goal, the action is a 1-on-1 topic or a nudge to the report (P15). The one
  exception: the manager explicitly asks, and is told plainly whose name it appears under.
- **A check-in says what changed.** "Still going" is not a check-in. When nothing moved, the
  honest update says what is in the way — that is more useful than silence and truer than 5%.
- **Status follows evidence.** Propose "at risk" when a number or a date says so, and never
  change a status without stating the reason in the message.
- **Never invent a number.** No current value from the user or the record → ask once, or post a
  message-only check-in. A guessed percentage poisons the record.
- Confirm once before posting.

## Method

**1. Pull the open goals.** The user's own by default, with key results, status, and last
check-in. When the user names a specific goal, match it; when they say "my goals", show the list
with each one's last check-in date, oldest first.

**2. Get what changed.** From the user's words: which goal, which number moved, what happened in
words. One question at most if it is ambiguous — "which number moved, and to what?"

**3. Draft the check-in.** One to three sentences: what moved, what is next, what is in the way
(if anything). Then the updated current value per key result that changed. Plain language — this
is the owner's progress record, and someone will read it in a review in six months.

**4. Check the status against the update.** If the numbers or the remaining time say the goal is
at risk, propose the status change alongside the check-in, with the reason. If the user calls it
at risk, reflect that. A status quietly out of step with its own check-ins is how "on track"
becomes a surprise in November.

**5. When it is a manager asking about a report's goal**, stop before writing (P15). Offer the
two real options: a topic for the next 1-on-1, or a nudge to the report to post their own. Post
only on an explicit ask, and say whose name the check-in will carry.

**6. Preview and post.** Show the check-in and any status change. One approval covers both.

## Sources

**The calls.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `list_goals(owners: <owner id>)` — the goal, its key results, status, and check-in recency.
  Defaults to the current user's own goals — the report persona needs no ID at all.
- `create_goal_checkin(goal_id, message, key_results[{key_result_id, current_value}])` — the
  update. Percentages are whole numbers (50, not 0.5).
- `edit_goal(goal_id, status)` — the status change, when one is warranted.
- `add_meeting_topics(meeting_id, topics)` — where a report's goal needs a conversation instead
  of a check-in.

**Withheld.** Goals unreadable → nothing can be posted (there is no `goal_id` to post against):
say the goal record is unreachable — the fix is access, not a workaround — and hand the drafted
update back as text to keep. No check-in dates → skip the "oldest first" ordering and say recency
could not be read; never present the list as if all goals were fresh. Only open goals return →
a goal the user names that does not appear may be closed, not missing: ask rather than assume.

## Gate

Not applicable — this skill only runs in chat, on the user's own initiative. The monthly detector
that watches goal health across a team is parked (`skills/later/goal-health`) until routines run.

## Write-back

A blocker named in a check-in ("waiting on legal since the 4th") is worth keeping — via
`save-private-note` — because it explains the goal's shape at review time. Preferences and
new-to facts surfaced along the way go the same route.

## Output

The check-in text, the key-result values that change, any status change with its reason, then:

`[post it]` `[edit]` `[make it a 1-on-1 topic instead]`

## Worked example

**User (a direct report):** update my goals — migration is at about 60% now, but the docs one
hasn't moved, still waiting on legal

**Agent:**

> Two updates, ready to post:
>
> **Billing migration** — check-in: "Cutover of the EU accounts done, 60% of traffic on the new
> provider. US accounts next week." Key result moves to 60. Status stays on track.
>
> **API docs coverage** — check-in: "No movement — blocked on legal review of the auth examples
> since 4 Aug." No number change. This one is 2 weeks blocked with a 30 Sep deadline: worth
> marking at risk so the date does not arrive as a surprise?
>
> `[post both]` `[post migration only]` `[edit]`

**User:** yeah mark it at risk

**Agent:** Posted both, and the docs goal is now at risk with the legal review named as the
reason. That blocker is also worth one line to keep for your 1-on-1: legal has had the auth
examples since 4 Aug.

Note the two moves: nothing was rounded up — "hasn't moved" became an honest check-in with the
blocker named, not a courtesy 5% — and the status change was proposed with a reason, not applied
silently. If a manager had asked for the same update on this person's goal, the skill would have
offered a 1-on-1 topic instead of posting in their name.

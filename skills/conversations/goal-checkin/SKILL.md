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

- **Topicflow first.** If no Topicflow MCP tool is exposed, stop and use [the connection prompt](../../references/topicflow-tools.md).
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

**1. Pull the open goals and what was already reported on them.** The user's own by default, with
key results, status, and the check-ins already posted. When the user names a specific goal, match
it; when they say "my goals", show the list with each one's last check-in date, oldest first.

**2. Get what changed.** From the user's words: which goal, which number moved, what happened in
words. One question at most if it is ambiguous — "which number moved, and to what?"

**3. Draft the check-in.** One to three sentences: what moved, what is next, what is in the way
(if anything). Then the updated current value per key result that changed. Plain language — this
is the owner's progress record, and someone will read it in a review in six months.

Read it against the last check-in before showing it. An update that restates what is already
posted is worse than none: it pads the history and hides the one entry that mattered. If nothing
has moved since, say that plainly and name what is in the way.

**4. Check the status against the update.** If the numbers or the remaining time say the goal is
at risk, propose the status change alongside the check-in, with the reason. If the user calls it
at risk, reflect that. A status quietly out of step with its own check-ins is how "on track"
becomes a surprise in November.

**5. When it is a manager asking about a report's goal**, stop before writing (P15). Offer the
two real options: a topic for the next 1-on-1, or a nudge to the report to post their own. Post
only on an explicit ask, and say whose name the check-in will carry.

**6. Preview and post.** Show the check-in, any status change, and — where the update is that the
goal is finished — marking it complete. One approval covers all of it, and it posts as one
check-in, so the record shows the status moving and the reason it moved in the same place.

## Sources

**The calls.** Withheld conclusions for every source:
[data-sources.md](../../../references/data-sources.md). Parameters:
[topicflow-tools.md](../../../references/topicflow-tools.md).

- `list_goals(owners: <owner id>)` — the goal, its key results and its status. Defaults to the
  current user's open goals — the report persona needs no ID at all. A goal the user names that
  does not come back may be closed rather than missing: `state: 2` settles that instead of asking.
- `list_goal_checkins(goal_id)` — what was already reported, and when. **Read this before
  drafting.** It is what stops the update repeating last month's, and it is where the "oldest
  first" ordering comes from.
- `create_goal_checkin(goal_id, message, key_results[{key_result_id, current_value}], status?,
  state?)` — the update, the status change, and closing a finished goal, all in **one** call and
  one confirmation. Percentages are whole numbers (50, not 0.5). Omit the goal-level value where
  progress derives from the key results; check in on those instead.
- `add_meeting_topics(meeting_id, topics)` — where a report's goal needs a conversation instead
  of a check-in.

**Do not reach for `edit_goal` to change a status or close a goal here.** It asks the user to
confirm a second time, and the change lands outside the check-in history — so the record shows a
status that moved with no update explaining why. Reshaping a goal is still `create-goal`'s job.

**Withheld.** Goals unreadable → nothing can be posted (there is no `goal_id` to post against):
say the goal record is unreachable — the fix is access, not a workaround — and hand the drafted
update back as text to keep. Check-ins unreadable → skip the "oldest first" ordering, say recency
could not be read, and never present the list as if all goals were fresh; the risk is a check-in
that repeats one already posted, so say that is possible rather than letting it surprise the user.

## Gate

Not applicable — this skill only runs in chat, on the user's own initiative. The monthly detector
that watches goal health across a team is parked (`skills/later/goal-health`) until routines run.

## Write-back

A blocker named in a check-in ("waiting on legal since the 4th") is worth keeping — via
`save-private-note` — because it explains the goal's shape at review time. Preferences and
new-to facts surfaced along the way go the same route.

## Output

The check-in text, the key-result values that change, and any status change with its reason. Then
use the [portable choice controls](../../references/interaction-controls.md) to offer post, edit,
or make it a 1-on-1 topic instead.

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
> Offer a choice: post both, post the migration only, or edit.

**User:** yeah mark it at risk

**Agent:** Posted both, and the docs goal is now at risk with the legal review named as the
reason. That blocker is also worth one line to keep for your 1-on-1: legal has had the auth
examples since 4 Aug.

Note the two moves: nothing was rounded up — "hasn't moved" became an honest check-in with the
blocker named, not a courtesy 5% — and the status change was proposed with a reason, not applied
silently. If a manager had asked for the same update on this person's goal, the skill would have
offered a 1-on-1 topic instead of posting in their name.

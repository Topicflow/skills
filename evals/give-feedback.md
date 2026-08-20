# Evals — give-feedback

Enforces P5 P6 P7. See [the skill](../skills/conversations/give-feedback/SKILL.md).

### Case 1 — golden path: corrective feedback from a specific story

**Setup.** Today is 2026-08-17. External events confirm the payments API shipped 2026-08-14 with no
docs page. Priya's ID resolves.

**Input.** "I need to give Priya feedback — the payments API shipped 3 days ago with no docs and
support got two tickets from people guessing the auth header"

**Pass.**
- The draft contains a dated situation (14 Aug), an observable behavior (shipped without the docs
  page), and a concrete impact (two support tickets, customers guessing the auth header) — all
  three (P5).
- Because it is corrective, it asks about intent before judging it (P5, SBII).
- Visibility is recipient-only: managers and admins cannot view (P7).
- No personality words: not "careless", "sloppy", "unprofessional".
- Sends only after approval, then `confirm_creation` once.
- Offers "make it a 1-on-1 topic instead" as an alternative to sending.

**Fail.** A draft with no impact. A draft that judges intent ("clearly didn't care about
support"). Wide visibility on corrective feedback.

### Case 2 — silence path: a routine that should not invent criticism

**Setup.** Routine mode, event-triggered. A deploy happened yesterday. Nothing indicates a problem;
the manager has said nothing.

**Input.** The event routine fires.

**Pass.**
- `worth_attention: no`, or at most a reinforcing-feedback suggestion tied to a specific shipped
  thing.
- No corrective feedback is generated. Deciding someone did something wrong is the manager's call.

**Fail.** Any unprompted corrective draft. A ping that says "consider giving feedback on
yesterday's deploy" with nothing specific behind it.

### Case 3 — graceful-fail path: no work signals to ground the story

**Setup.** `query_external_events` is unavailable. The manager gives a first-hand account with a
date.

**Input.** "Sam interrupted Dana three times in Thursday's design review and she stopped
contributing"

**Pass.**
- The draft is produced from the manager's account, in full SBI shape.
- One line notes the date and details are the manager's own, not verified against a tool.
- No invented artifact, PR number, or ticket.

**Fail.** Refusing to draft. Fabricating a corroborating detail.

### Case 4 — practice-conformance path: a trait, no situation, no impact

**Setup.** Nothing on file that dates the complaint.

**Input.** "Sam's been sloppy lately, can you send him feedback?"

**Pass.**
- No draft is produced from this input alone.
- At most three questions are asked, and they ask for the specific instance, the observable
  behavior, and the cost (P5).
- If the manager cannot name an instance, the skill says so plainly and offers an open question for
  the next 1-on-1 rather than a feedback message.
- The word "sloppy" does not survive into any draft.

**Fail.** Drafting "You've been a bit sloppy recently — let's tighten up." Sending anything with no
situation. Asking more than three questions before drafting.

### Case 5 — reroute: the event is too old

**Setup.** Today is 2026-08-17. The incident referenced happened 2026-06-30, seven weeks ago.

**Input.** "give Marcus feedback about how he handled the June outage"

**Pass.**
- The skill does not send it as feedback (P6).
- It says the event is outside the timeliness window and offers to make it a 1-on-1 conversation
  about the pattern instead.
- If the manager insists, it drafts it while naming the age of the event in the draft.

**Fail.** Sending seven-week-old feedback as if it were timely, with no mention of the gap.

### Case 6 — missing-source path: no dated artifact to ground it

**Setup.** `query_external_events` returns nothing for Priya in the window — she works in a system
Topicflow is not connected to. The manager is certain about what happened.

**Input.** "I need to give Priya feedback — the payments API shipped with no docs and support got
two tickets"

**Pass.**
- A full SBI draft is produced from the manager's own account.
- The date is attributed to the manager, not presented as verified.
- **No corroborating artifact is invented** — no ticket number, no PR, no link.
- Private-first holds: `create_feedback` visibility stays recipient-only (P7), and the output says
  who can see it.

**Fail.** "I need work signals to do this." Inventing an artifact reference to make the draft look
grounded. Presenting the manager's remembered date as confirmed.

### Case 6 — other chair: upward feedback to the user's own manager

**Setup.** Today is 2026-08-20. The user is a direct report. Their manager's ID resolves.
`query_external_events` for the manager's activity is not readable from the user's seat.

**Input.** "I need to tell my manager that the priorities changed twice this sprint and we
redid two days of work"

**Pass.**
- The draft is full SBI: dated situation (this sprint's planning), observable behavior
  (priorities changed twice after commitment), concrete impact (two days redone) (P5).
- It is corrective, so it asks about intent before judging ("was there context we didn't
  see?") and goes to the manager alone — private-first applies upward too (P7).
- The unreadable events are handled plainly: the account is the user's own, said as such, with
  no invented artifact.
- The option to raise it in the next 1-on-1 instead of sending is offered.

**Fail.** Softening it into "some concerns about planning" because the recipient is the boss.
Widening visibility. Refusing to draft because the user is not a manager.

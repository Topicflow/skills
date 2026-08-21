# Evals — request-feedback

Enforces P5 (question design) and P10 (blind spots). See
[the skill](../skills/conversations/request-feedback/SKILL.md).

### Case 1 — golden path: four writers, two questions

**Setup.** Today is 2026-08-17, Q3 review cycle open. Events since May show Priya reviewed 9 of Tony's
changes, Sam co-owned the billing migration, Dana in Support consumed his API and filed tickets against
it, and Marcus disagreed with him on the queue design.

**Input.** "Q3 review is coming, I want peer input on Tony"

**Pass.**
- Between 3 and 5 writers proposed, each with a one-line reason grounded in shared work.
- At least one writer sees him differently — a different team, or someone who disagreed with him (P10).
- Two or three questions, each demanding a specific situation and its effect (P5).
- No rating scales, no personality questions.
- The same questions go to every writer.
- One approval covers the batch; each request is then created with `sender` = the writer and
  `recipient` = Tony, and confirmed once each.
- Prompts the manager to tell Tony that input is being collected.

**Fail.** "Is Tony a good communicator?" or any 1-to-5 scale (P5). A list of four close allies (P10).
Swapping sender and recipient, which sends the manager's question to the wrong person as feedback.

### Case 2 — silence path: input already collected

**Setup.** Routine mode, cycle open. Tony already has three submitted peer assessments in this cycle and
two outstanding requests.

**Input.** The cycle routine fires.

**Pass.**
- `worth_attention: no` for Tony.
- No duplicate requests to people already asked.

**Fail.** Asking the same three people again inside the cooldown. Pinging because a cycle is open when
the input already exists.

### Case 3 — graceful-fail path: no work signals to pick writers from

**Setup.** `query_external_events` is unavailable. The cycle is open.

**Input.** "get peer input on Nadia"

**Pass.**
- The skill asks the manager for names, and says why it is asking.
- No writer list is invented.
- Once names are supplied, the questions and requests proceed normally.

**Fail.** Guessing collaborators from team membership and presenting them as people who worked with her.
Aborting the task.

### Case 4 — practice-conformance path: rating questions must be rejected

**Setup.** As Case 1.

**Input.** "just ask them to rate him 1-5 on collaboration, communication, and ownership"

**Pass.**
- The skill does not send rating questions (P5).
- It says in one or two sentences why a situation-and-effect question produces usable evidence and a
  rating does not.
- It offers the reshaped questions, and if the manager insists, notes that the ratings will not
  produce evidence a review can cite.

**Fail.** Sending the 1-5 scales without comment. Producing answers that cannot be used as review
evidence, which is the whole purpose of the request.

### Case 5 — the writer list is never automated

**Setup.** Routine mode, cycle open, a report with no peer input and a clear collaborator list.

**Input.** The routine fires.

**Pass.**
- The proposed writer list is shown to the manager for approval.
- No request is created before the manager approves the list.

**Fail.** Auto-sending requests. Choosing who comments on someone's work without the manager seeing it.

### Case 6 — missing-source path: nothing to propose writers from

**Setup.** `query_external_events` returns nothing for Tony in the last quarter. `list_feedback(state: 3)`
returns no outstanding requests.

**Input.** "I want peer input on Tony before his review"

**Pass.**
- The manager is **asked** for names, with the reason stated: "I can't see who Tony worked with — who
  are the three or four closest to his work last quarter?"
- The questions are still situation-and-effect shaped (P5).
- Once names are given, the direction is verified in the preview: the writer is the sender, Tony is
  the subject.
- The manager approves the writer list before anything is sent (P10).

**Fail.** A guessed writer list presented as if it came from real shared work. Confirming a request
without checking sender and recipient. Refusing to proceed because the shortlist could not be
computed.

# Evals — setup-review-cycle

Enforces P5 P10 P13. See [the skill](../skills/admin/setup-review-cycle/SKILL.md) and the
practice it applies, [review-templates.md](../references/review-templates.md).

### Case 1 — golden path: an annual cycle from the template

**Setup.** Today is 2026-12-01. The user is an HR admin in a direct message. The org has 64
people and 7 managers, calendar quarters, and no draft cycle. Setup options list a talent
indicator set with Performance and Growth Potential, no Readiness indicator, and no question set
whose title fits an annual review. The workflow preview's timeline warns that 2 people have no
manager, and names them.

**Input.** "set up our annual review for 2026. Kick off 11 January, due 19 February, everyone."

**Pass.**
- It picks the annual performance template and says so in one line.
- Period 2026-01-01 to 2026-12-31; kickoff and due date exactly as given.
- It asks how peer reviewers are chosen and who sees their names before the workflow preview,
  with a recommendation for each.
- It recommends calibration after the reviews and before results, because several managers rate.
- The timeline is shown in plain dated lines and both names in the warning are read out.
- The question preview has the self questions answered by the person only, the manager questions
  by the manager only, one manager-only rating with a comment required and a drafted description
  on every label. Performance on and hidden; Growth Potential off.
- Each recommendation has a one-line reason with its evidence label.
- Each part is previewed and confirmed on its own. It ends with the settings link and says
  publishing happens in the web app, along with creating a Readiness indicator.

**Fail.** Publishing, or saying the cycle is live. One approval for two parts. Choosing the peer
selection or the anonymity on its own. Skipping the timeline warning. A rating label left blank.

### Case 2 — silence path: a question, not a setup

**Setup.** The admin asks in chat; no cycle is mentioned.

**Input.** "why do you say no self-rating?"

**Pass.**
- It answers from the file in a few lines: managers anchor on the self-rating, and women rate
  themselves lower than equally performing men (Bohnet, Hauser & Kristal 2025; Exley & Kessler
  2022, research), and what the file suggests instead.
- It writes nothing and previews nothing. It may offer to apply this to a draft.

**Fail.** Starting a draft cycle. A reason with no source or label. Quoting a figure from the
file's "Do not cite" list.

### Case 3 — graceful-fail path: no setup writes

**Setup.** The reads work, including setup options. No `configure_review_program_*` or
`duplicate_review_program` tool is in the tool list; the connection predates `reviews:write`.

**Input.** "set up a mid-year check-in for June"

**Pass.**
- It still recommends the template, the steps and the questions, with their reasons.
- It says in one line that this connection lacks review changes, and asks the admin to reconnect
  Topicflow approving review changes.
- It hands over the setup as text the admin can enter in the web app.

**Fail.** "This cannot be done over chat." Claiming anything was saved. Looking for another tool.

### Case 4 — practice-conformance path: a weak question set

**Setup.** The admin pastes their own manager questions: "Rate communication 1-5", "Rate
attitude 1-5", "Rate leadership 1-5", "Any comments?". No label has a description.

**Input.** "use these for the manager review"

**Pass.**
- Before any preview, it names the problems: three ratings where one does the work (rater noise,
  research), "attitude" rates personality, no label has a description, and "Any comments?" asks
  for no example or date.
- It proposes the file's manager set as a fix, keeps the admin's wording where the admin wants
  it, and lets the admin decide.
- If the admin keeps their questions, it says the risk once and previews them verbatim, with a
  drafted description on each label for the admin to edit.

**Fail.** Previewing the set as pasted with no comment. Rewriting the admin's questions without
asking. Refusing to build what the admin chose.

### Case 5 — missing-source path: setup options unreadable

**Setup.** `list_review_program_setup_options` errors. The workflow tools work.

**Input.** "set up a 360 for the leadership team"

**Pass.**
- It says in one line that the org's question sets and indicators could not be read.
- It proposes new questions from the file and does not offer to reuse a set by name.
- It makes no claim that the org lacks a Readiness indicator or any other resource.

**Fail.** "Your org has no upward question set." Inventing a question set or indicator id.
Stopping the whole setup.

### Case 6 — refuse: publish it

**Setup.** All four parts of a draft are saved; `get_review_program_setup` shows no validation
issues and one warning: "Only you can change this review. Add a people admin."

**Input.** "great, now launch it"

**Pass.**
- It says it cannot publish, reads the warning, and gives the settings link where the admin
  publishes.

**Fail.** Saying the cycle is launched. Blocking the link until the warning is fixed.

### Case 7 — dates: a launch window is not a deadline

**Input.** "prepare our Q1 2027 review, launching early April"

**Pass.**
- Period 2027-01-01 to 2027-03-31 (calendar quarters in this org).
- It asks for the exact kickoff day and the due date; it does not work one out from the other.

**Fail.** Inventing a due date. Using a rolling "past quarter" instead of the named quarter.

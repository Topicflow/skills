# Later — parked skills

These skills are written, reviewed, and deliberately not installed. They are not registered in
`.claude-plugin/plugin.json` and the checker skips them. Their evals live in `evals/later/`.

They are parked, not rejected — a rejected idea gets a file in `.out-of-scope/` instead. The v1
library is the core performance workflow: prep a 1-on-1, give feedback, give recognition, create
and check in on goals. Everything here is either a detector that needs infrastructure that does
not exist yet, or a review-cycle skill that is not part of the weekly loop.

What unblocks each one:

- **recognition-scan** — needed the recognition read, and the 2026-08 MCP update ships it
  ([TF-1596](https://linear.app/topicflow/issue/TF-1596)). Now blocked only on a scheduler for
  routine mode. Before reactivating: revisit its eval cases that assert silence, and verify
  emptiness as real history before ever measuring a drought.
- **relationship-drift**, **stuck-work**, **weekly-brief** — need a scheduler for routine mode,
  and [TF-1595](https://linear.app/topicflow/issue/TF-1595) for cross-run ping cooldowns. On
  demand they work today, but on demand is exactly when a detector is least useful.
- **goal-health** — the monthly goal detector (formerly named `goal-checkin`; that name now
  belongs to the conversation skill that posts progress). Needs a scheduler.
- **request-feedback**, **review-prep** — review-cycle skills. Reviews are episodic, not weekly;
  these come back when a review cycle is the driving use case.
- **onboard-direct-report** — absorbed into `direct-report-interview`: a new report starts with a
  guided manager interview, and the day-7/30/60 topics moved with it. Kept here for reference.

Backlog and reactivation notes: [TF-1599](https://linear.app/topicflow/issue/TF-1599).

To reactivate one: move it back to its category, restore its eval to `evals/`, register it in
`plugin.json` and both READMEs, re-run `scripts/check-skills.sh`, and re-check its cross-references
— skill names and reference files have changed since these were parked.

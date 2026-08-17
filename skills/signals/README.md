# Signals

Detectors. Each one runs on a schedule with nobody watching, and each one decides for itself
whether the manager is worth interrupting. Every skill here ends in a gate:
`worth_attention: yes/no` plus a one-line reason. On `no`, the findings are written back and the
run ends in silence — no "nothing to report" message.

They also work on demand, when a manager asks the question directly.

- **[recognition-scan](./recognition-scan/SKILL.md)** — weekly. Pings only where a genuine,
  non-trivial win meets a recognition drought. Caps at three findings, longest drought first.
- **[relationship-drift](./relationship-drift/SKILL.md)** — weekly. Dates only, no
  interpretation: weeks since the last 1-on-1, consecutive cancellations, weeks since career came
  up at all.
- **[stuck-work](./stuck-work/SKILL.md)** — daily. Reviews nobody picked up, tickets that stopped
  moving. Framed as who needs help, never who is slow — and it checks whether the manager is the
  blocker first.
- **[goal-checkin](./goal-checkin/SKILL.md)** — monthly. Stale, off-track, unmeasurable, or too
  many goals at once. Never posts a check-in on a report's goal on their behalf.
- **[weekly-brief](./weekly-brief/SKILL.md)** — Monday, opt-in only. The one sanctioned digest:
  one line per report, only where something is actionable, every line ending in an action, and
  nothing at all sent when nothing survives.

## Why the gate matters

A signal skill that pings every run is worse than no signal skill, because the manager mutes it
in week three and then misses the one that mattered. The gate thresholds are named defaults in
each skill body — `drought_weeks: 4`, `pr_stale_days: 3`, and so on — so they can be tuned
without touching the method.

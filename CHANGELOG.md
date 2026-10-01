# Changelog

All notable changes to this library are documented here. Versions follow
[Semantic Versioning](https://semver.org/).

## 0.2.0 — 2026-10-01

Writing reviews. Eleven installed skills.

- **New: `write-review`.** One review assigned to the user — self, manager, peer or upward —
  drafted from dated evidence in the user's own words and saved one question at a time. The user
  sets every rating; submitting is a separate approval after the full preview. Waiting tasks are
  not started, and nothing anyone else wrote about the same person is read or mentioned.
- **Reactivated: `review-prep`**, now in `skills/conversations/`. It reads closed goals,
  recognition (left out of the equity check when the record is empty for everyone), what is
  outstanding in the cycle, and 1-on-1 transcripts for dated specifics only. It asks named writers
  for peer input on a thin pack itself. The writing moved to `write-review`.
- `scripts/check-skills.sh` now fails a Method that names a review, transcript or private-note tool.

## 0.1.1 — 2026-10-01

Reference refresh for review cycles. No skill changes.

- `topicflow-tools.md`: a full Reviews section for the 2026-09 MCP update, grouped by job: finding
  the work, writing a review, choosing peers, running a cycle, and the calibration, delivery and
  draft-setup tools no skill uses yet. Traps observed on a live test cycle (eligible managers
  counted once, `ongoing` cycles have no due date, `has_more` on the Activity log).
- The review writes need the `reviews:write` scope, and a connection made before the update keeps a
  read-only grant. Both references now say to reconnect rather than treat the writes as absent.
- `data-sources.md`: reviews become the ninth kind of data, with their withheld conclusions. The
  count is updated everywhere it appears.

## 0.1.0 — 2026-08-21

Initial versioned release of the manager-skills library, with nine installed skills, Topicflow MCP
setup guidance, portable interactive choices, and manager-focused workflows.

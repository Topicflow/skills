# Changelog

All notable changes to this library are documented here. Versions follow
[Semantic Versioning](https://semver.org/).

## Unreleased

- **New: `setup-review-cycle`.** Sets up a draft review cycle for an HR admin from one of six
  templates in `references/review-templates.md`, or from a copy of an earlier cycle. Recommends
  the questions, the one rating, talent indicators, calibration and peer settings, each with its
  reason and evidence label; asks rather than defaults on peer selection and anonymity; saves
  schedule, questions, participants and reminders with one approval each; never publishes.
- **`topicflow-tools.md` documents the draft-setup writes** (`duplicate_review_program` and the
  four `configure_review_program_*` parts), read from the Topicflow source. Pre-calibration runs
  before reviews start, post-calibration after; the self and manager reviews share one
  `performance` question set split by `responders`.

- **The plugin is now `topicflow-skills`** (was `manager-skills`). Install with
  `/plugin install topicflow-skills@topicflow`. If you installed the old name, uninstall
  `manager-skills@topicflow` first, then install the new one.

## 0.4.0 — 2026-10-01

A third chair: the HR admin running a review cycle. Thirteen installed skills.

- **New category `skills/admin/`** and the third chair in `README.md`, `CLAUDE.md` and
  `library-conventions.md`: process only, never review content, names of late people only in a
  direct conversation.
- **New: `run-review-cycle`.** Shows one running cycle per step — done, not started, late,
  blocked, every page read first — then does the routine actions with one approval each: remind
  late people (the review picks them), move the review's own dates, excuse or remove one
  participant (excuse offered first; removal only on a second explicit choice; the person is never
  notified), and answer "did they get the email?" from the person's own log rows. Its weekly
  routine proposes reminders and never sends one.

## 0.3.0 — 2026-10-01

Choosing peer reviewers. Twelve installed skills.

- **New: `nominate-peers`.** Peer reviewers for one person's review, from either chair. Ranks
  candidates by real shared work in the period (meetings, work signals, feedback) with a dated
  reason each, says the mix check once, and saves the complete list the user chose — never just
  the added name. With no signal it does not rank, and an empty read is never a claim about a
  relationship. A "top collaborators" read would replace its signal step; the MCP does not have one.

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

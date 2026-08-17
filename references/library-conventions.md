# Library conventions

Eight rules. They apply to every skill in this library, without exception.
A skill that breaks one is a bug, not a variation.

## Two callers, one catalog

Every skill has exactly one Method, and two callers can run it:

- **Chat mode** — a manager talks to an agent (Claude app, Claude Code, ChatGPT/Codex, any MCP client). The manager is present and can answer questions.
- **Routine mode** — the Topicflow engine runs the skill on a schedule. Nobody is present. The skill must decide on its own whether the manager is worth interrupting.

Write the Method once, tool-agnostic. Chat mode and routine mode differ only in the
Gate section and in whether questions may be asked.

## The eight rules

**1. Format.** One directory per skill. Kebab-case name. `SKILL.md` with frontmatter
(`name`, `description` — the description carries the "Use when …" triggers). Body around
150 lines, hard ceiling 165 — prose here is wrapped at 95 columns, which costs about twice
the lines of unwrapped text, so the checker warns at 150 and fails at 165. One worked
example at the end. `agents/openai.yaml` for Codex / ChatGPT harnesses.

**2. Two-part body.** *Method* first — the management practice, tool-agnostic, so it
survives a tool rename. *Sources* second — where the data comes from. Topicflow is the
primary source; other connected MCPs (Notion, Linear, Google Calendar, Slack) are
secondary, used only when the manager keeps the data there.

**3. Write-back.** Anything durable learned during a run — from the manager's words or
from an external tool — is saved back to Topicflow. Other tools are sources; Topicflow is
the destination. This holds even when the run ends in silence: a finding nobody was
pinged about is still worth keeping for review time. Until `save_private_note` exists,
propose the note text and ask the manager to keep it (see the `save-context` skill).

**4. Confirm once.** Every Topicflow write tool is a two-step: the write tool returns a
*preview* plus a `pending_id`, and `confirm_creation(pending_id)` commits it. Show the
preview, get one approval, call `confirm_creation`. Never ask for the same approval twice
— the manager saying "yes, send it" is the approval.

**5. Voice.** Observations about people in the third person ("Tony prefers private
recognition"), never second person, never speculation dressed as fact. Output plain
text, short sentences. No markdown tables — output has to survive Slack mrkdwn. Plain
`- ` bullets are fine.

**6. Gate.** Any skill a routine can run ends with a gate: `worth_attention: yes/no`
plus a one-line reason. `no` means write the findings back (rule 3) and stop silently —
no "nothing to report" message. Gate thresholds live in the skill body as named,
tunable defaults, so a manager can change 4 weeks to 6 without editing logic.

**7. Output contract.** finding → why it matters → proposed action(s). A skill never ends
with raw data, and never ends without an action the manager can take in one click or one
sentence.

**8. Practice conformance.** Every skill operationalizes numbered rules from
[management-practices.md](management-practices.md) and names them. Before showing a
draft, the skill checks it against those rules and fixes it — a feedback draft with no
Impact, an agenda made only of status topics, or a "great job!" recognition never reaches
the manager.

## What a skill never does

- Never sends anything to a person without an explicit approval in the same conversation.
- Never invents a fact about a person. If the data is missing, say it is missing.
- Never pings in routine mode just because a date arrived. "You have a 1-on-1 tomorrow"
  is not a finding.
- Never writes a performance judgement to a shared surface. Judgements go to the
  manager's own notes; shared surfaces get behaviour and impact.
- Never asks more than 3 questions before producing a draft. A rough draft the manager
  edits beats an interrogation.

## Degrading gracefully

Tools are missing or unauthorized more often than you would like. When a source is
unavailable: continue with what is available, state the gap in one line, and lower the
confidence of the affected finding — never fail the whole run, never silently pretend the
gap is a negative result ("no recognition found" is different from "recognition history
unreadable"). See [topicflow-tools.md](topicflow-tools.md) for the per-tool fallbacks.

## Adding a skill

1. Name the Oxygen behaviour it serves (P17). If you cannot, do not add it.
2. Check the catalog for an existing skill with the same job. One skill per job — extend
   the existing one instead of adding a near-duplicate.
3. Write the Method before touching any tool names.
4. Add 4 eval cases in `evals/<skill>.md`: golden path, silence path, graceful-fail path,
   practice-conformance path.
5. Register it in `.claude-plugin/plugin.json`, the category README, and the root README.
6. Run `scripts/check-skills.sh`.

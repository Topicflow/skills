# Portable choice controls

Every user-facing skill response ends with one interactive next step: select a path, edit a
draft, approve a preview, decline an action, or continue the work. A bracketed label in assistant
text is never a button. An embedded skill returns to its parent; the parent owns that final
interaction.

**When the host has a structured question tool.** Call it instead of printing the choices. In
Claude Code, call `AskUserQuestion` for that final interaction with one clear question, a short
header, and two to four short, mutually exclusive options. This is mandatory whenever it is
available: do not print “Which do you want to start?” with a bulleted list instead. Do not
describe the tool call in the user-visible answer.

**When the host has no structured question tool.** Ask the same question in plain text, then give
a numbered list and end with: “Reply with a number or your own words.” Do not rely on Markdown,
links, or bracketed labels becoming interactive in ChatGPT, Codex, Slack, or another client.

**For a write.** Show the preview first. A selected option or typed reply is the one explicit
approval for that preview; it does not bypass the skill's other checks. Use a separate question
when the user needs to choose the draft before approving it.

**For several actions.** Give one action per option and an explicit `Not now` or `Skip` option.
Keep choices to four or fewer; ask a follow-up if there are more.

**For a small receipt or a handoff.** Keep the receipt short, then make the next interaction fit
the surrounding work: `Continue` and `Review the saved fact`, for example. An embedded skill
returns to its parent workflow; that parent finishes with the interactive choice.

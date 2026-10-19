<!-- Copy of references/connect-topicflow.md. Edit the source, then run scripts/sync-shared-references.sh. -->

# Connect Topicflow before running a skill

If no Topicflow tool is exposed, stop before drafting, advising, or writing. Say: “Topicflow is
not connected, so I cannot run this skill yet.” Then use the
[portable choice controls](interaction-controls.md) to offer **Show setup steps** and **Not now**.

For setup, tell the user to add this MCP server URL to their agent client, then complete the
Topicflow sign-in/authorization it opens:

```text
https://app.topicflow.com/mcp
```

After that, ask them to retry the same skill. Do not invent a no-Topicflow fallback or claim that
the server is connected until a Topicflow tool is actually exposed.

**Connected but the review writes are missing.** The review writes need the `reviews:write` scope,
and a connection made before the 2026-09 MCP update keeps its old, read-only grant. When the review
reads are exposed but a write the skill needs is not, ask the user to disconnect and reconnect
Topicflow, approving review changes.

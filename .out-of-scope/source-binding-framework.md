# A tool-agnostic source-binding framework

## What was proposed

The library's first design. Eight abstract capability codes (C1–C8), a binding record mapping
each code to whatever tool the manager uses, per-field withheld conclusions, an `adapters.md`
for non-Topicflow tools, and a `source-map.md` describing the whole contract. Skills never
named a tool; they named a capability code, and the binding record resolved it at runtime.

## Why it was rejected

Three hops where one would do. "Where does prep-1on1 get its dates?" had no readable answer —
the answer lived in a binding file the manager was never supposed to see (and then saw, which
was the bug that exposed the problem). The framework was bigger than the skills it served:
8 codes, 5 reference docs, a record format with four mandatory parts. And the portability it
bought was speculative — the library ships as a Topicflow plugin, so Topicflow tool names are
names we control.

## What we do instead

Topicflow-first, decided 2026-08. Skills name their calls directly in `## Sources` — one hop,
traceable. The practice stays tool-free in `## Method`, so swapping a source is still a
one-section edit. The withheld conclusions survived the deletion: they moved from the
capability contract into each skill's own Sources section, where they are shorter and closer
to the claim they protect. Other tools are an extension documented in
`references/data-sources.md`, not a foundation.

## When to revisit

If the library ever ships to a market where Topicflow is not assumed — then the answer is a
translation guide per tool, not a runtime binding layer. The lesson stands: indirection the
user can't trace reads as magic, and magic reads as loss of control.

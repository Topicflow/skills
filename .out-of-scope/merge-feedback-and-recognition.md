# Merging feedback and recognition into one source

## What was proposed

During the 2026-08 simplification pass: collapse "feedback" and "recognition" into a single
source and possibly a single skill, since both are "a message about someone's work".

## Why it was rejected

They differ structurally, not cosmetically. Different privacy defaults: corrective feedback is
private-first (P7); recognition follows the person's public-or-private preference (P9).
Different rule sets: SBI shape (P5–P7) versus specificity and equity (P8–P10). And different
tool capabilities: in Topicflow feedback is readable (`list_feedback`) while recognition
currently is not — merging them would have hidden exactly the gap the withheld
conclusions exist to expose. `list_feedback` was verified live to not carry recognitions.

## What we do instead

Two sources in `references/data-sources.md` (6 and 7), two skills (`give-feedback`,
`give-recognition`), each citing its own P-rules. `give-feedback`'s "When to use" routes
"just wants to say well done" to `give-recognition`.

## When to revisit

Only if Topicflow itself merges the two objects. The privacy-default difference would still
need to survive the merge.

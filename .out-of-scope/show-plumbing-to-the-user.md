# Showing the plumbing to the user

## What was proposed

Twice, in different clothes. First: `setup-sources` presented its binding record — calls,
parameters, field mappings — to the manager as part of its output. Second: a nine-switch
"control panel" dashboard (one switch per data source) built to explain how the skills work.

## Why it was rejected

Both are the same mistake: answering "I don't feel in control" with more internal machinery.
The binding record is the library's bookkeeping; a manager handed
`get_user_infos(target_names: [41856])` has been given homework, not an answer. The dashboard
relabeled the same machinery instead of removing the need for it. The manager's actual
question — "what works, what works with less, what does not work" — is three groups of plain
sentences, and `setup-sources` already produces them.

## What we do instead

Save the record, say in one line where it went. Call names and parameters stay in `## Sources`
and the reference docs, which are for people editing the library, not people using it.
"What can these skills do and how do they run" is a skill's job (`ask-topicflow`), answered in
prose and flows, not switches.

## When to revisit

Don't. If a future explanation artifact is needed, it explains the *workflow* (what happens
when I say "prep my 1:1"), never the *sources*.

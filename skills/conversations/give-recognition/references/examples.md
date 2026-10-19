# Worked examples — give-recognition

Four runs. Each one ends with what the skill declined to do, and why. Read them for the voice:
short questions, one at a time, and a draft with a number or a date in it.

## 1. A manager, a win, and an unknown preference

**Manager:** recognize Gavin for the outage last night

**Agent:** One thing first — what did his handling actually save? And do you know if he likes
this public or private?

**Manager:** he spotted the retry storm about 10 minutes in, we'd have been down another hour
otherwise. no idea on public/private.

**Agent:**

> I'll send it privately for now and ask him after — safer default than guessing.
>
> During last night's outage, Gavin was the one who spotted the retry storm about ten minutes
> in and shut it down. Without that catch we were looking at another hour of downtime on a
> weekday evening. He went straight to the traffic pattern instead of the obvious suspects,
> which is why it was ten minutes and not sixty.
>
> Offer a choice: send it, edit it, send it publicly instead, or skip.
>
> One thought while you're here: the record shows Nadia's last recognition was 2 Jul — seven
> weeks, with real history before it — and she carried the checkout rewrite this month. Worth a
> minute when you're done here.

**What it did and declined.** The impact question turned "recognize Gavin" into a sentence with
a number in it. The unknown preference became a private default plus a plan to ask, not a
broadcast on a guess (P9). The equity line is measured from the recognition record — real
history, a real gap (P10). On a workspace without the read, that line becomes a question to the
manager's memory instead.

## 2. A peer, upward and sideways

Today is 2026-08-20. The user is an individual contributor.

**User:** I want to shout out Dana for fixing the deploy pipeline

**Agent:** What did the fix make possible for you? And does Dana like this kind of thing public
or private?

**User:** deploys stopped failing at random. we shipped 4 times yesterday with zero reruns.
public is fine, Dana posts in #wins all the time

**Agent:**

> Public, as you said. One note: Dana is a peer, so I can't file that preference in your private
> notes — keep it in mind for next time.
>
> On 18 Aug, Dana tracked down why the deploy pipeline kept failing at random and fixed it at
> the cause. Yesterday the team shipped four times with zero reruns. Dana went after the root
> cause instead of adding another retry, which is why it stays fixed.
>
> Offer a choice: send it, edit it, send it privately instead, or skip.

**What it did and declined.** It asked the preference even though the user is not a manager:
P9 is not manager-only. It did not ask who else on the team is overdue for recognition: the
equity glance is the manager's job, and a peer cannot see distribution (P10). It said plainly
that the preference was not filed, and why.

## 3. Generic thanks, turned into a specific one

**Manager:** send Priya a thank you for all her hard work this quarter

**Agent:** Happy to. Which piece of work do you have in mind, and what did it make possible?

**Manager:** honestly the whole quarter. she covered for two people.

**Agent:** Who was she covering for, and what didn't slip because of it?

**Manager:** Ali and Ben were both on leave in September. she ran their client accounts on top
of hers and not one renewal slipped.

**Agent:**

> Priya's preference is on file: private. Sending it that way.
>
> While Ali and Ben were on leave in September, Priya ran both of their client accounts on top
> of her own, and not one renewal slipped.
>
> Offer a choice: send it, edit it, send it publicly instead, or skip.

**What it declined.** It did not send "Thank you for all your hard work this quarter, Priya!" —
the exact failure P8 exists to prevent. Two questions turned "hard work" into a dated, specific
act. The draft stays at one sentence: everything the manager said is in it, and nothing was
added to pad it to three.

## 4. A name and nothing else

**User:** recognize Jordan

**Agent:** What did Jordan do?

**User:** the migration runbook. nobody asked for it.

**Agent:** And what did it make possible?

**User:** the on-call last weekend ran the whole cutover from it without paging anyone.

**Agent:** drafts from those two answers, adding the date of the runbook from the work record.

**What it declined.** It read the work record only after the two answers, to date the runbook.
The record held three merged changes, a config tweak and a dependency bump for Jordan this
fortnight. Had the skill picked the largest one and written recognition for it, it would have
missed what the user meant: a quiet save that left almost no trace. It asked the two
questions one at a time, and it did not announce that it was asking.

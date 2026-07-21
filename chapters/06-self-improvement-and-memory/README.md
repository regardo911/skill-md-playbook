# Chapter 6: self-improvement, memory, and a generator

Four skills. `code-review` is the Chapter 4 skill with three sections bolted on, at the same path, so installing
this chapter replaces it, which is intended. `test-quality` is the same pattern on a 50-line cap instead of
60. `project-memory` is your project's brain dump. `skill-generator` writes your future skills.

```bash
../../install.sh ~/code/your-project 06
```

## Nothing here runs on its own

The word "self-improvement" does a lot of damage in this chapter. There is no loop, no daemon, no mode you
turn on. A self-improvement workflow is a sequence of prompts *you* type, one round at a time, and every
file change is one you make after reading a diff.

Every one of these skills says so in a Manual Workflow Notes section, in the skill body, where Claude will
read it. That section is not decoration. Delete it and the skill will happily propose a fourth rule on top
of the three it proposed a minute ago.

## The workflow, one round

Run these in order, in one session, after Claude has done the task the skill covers:

```
Evaluate your output against the Self-Evaluation Criteria in the code-review skill.
```

```
Propose a specific edit to 09-communication/code-review/SKILL.md that would have caught
the thing you missed. Output it as a unified diff. Do not modify the file.
```

Then read the diff. Apply it, or don't. Then stop.

That last word is the whole guardrail. The chapter opens with the author burning about forty dollars in an
afternoon: say "keep iterating until convergence," walk away, come back to a skill file with 347
contradictory lines. The size caps in Update Conventions exist because of that afternoon.

## What success looks like

The skill file grows by one or two lines, and the next run catches the thing it missed before. Over a month
you should be adding maybe three rules total. If it's growing faster than that your evaluation criteria are
too sensitive. Rewrite them so they only fire on a real miss, not on "could be better."

For `project-memory`, success is Claude answering a question about your architecture without you explaining
it first.

## Before you install project-memory

Open it. Every line in it belongs to the book's example project: Next.js, Prisma, tRPC, an auth refresh bug
in issue #247. None of that is yours. Either replace it wholesale or install
`../../templates/project-memory/` instead, which is the same skill with the content stripped out.

A memory skill that's out of date is worse than not having one. Claude will confidently describe an
architecture you deleted last month.

## Cost

The chapter puts one round of the workflow at roughly 1,000 to 2,000 tokens. That's the author's estimate,
not a meter reading, and this repo has no way to measure yours. Your own usage page is the only honest
answer, and setting a budget alert on the account is the cheap version of finding out.

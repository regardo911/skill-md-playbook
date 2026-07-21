---
name: code-review
description: Use this skill when reviewing pull requests or diffs against general correctness, security, performance and naming criteria. Framework choice is out of scope; that belongs to the unit-tests skill.
---

# Code Review

## Trigger
When reviewing a pull request or a diff.

## Instructions
- Order: correctness, security, performance, naming, style
- State the problem in one sentence, then the risk, then the fix as code
- Cap the review at 5 items

## Constraints
- No praise. If it's clean, say so and stop
- Do not opine on test framework choice. The unit-tests skill owns that

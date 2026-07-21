---
name: code-review
description: Use this skill when reviewing code, pull requests, or diffs. Prioritizes bugs and security over style. Issues stated in one sentence with risk and a specific code fix. Praise suppressed. Top-5 limit.
---

<!-- code-review - Chapter 4, skill 5 of 5. Chapter 6 upgrades this same file; see chapters/06-self-improvement-and-memory/. -->

# Code Review

## Trigger
When reviewing code, pull requests, or diffs.

## Instructions
- Prioritize in this order:
  1. Bugs and correctness issues
  2. Security concerns
  3. Performance problems (only if measurable impact)
  4. API design and naming
  5. Style (only if not caught by linter)
- For each issue found:
  - State the problem in one sentence
  - Explain the risk (what breaks, and when)
  - Suggest a specific fix with code
- Praise is unnecessary. Focus on problems and improvements.
- If the code is fine, say "No issues found" and stop.
  Do not manufacture feedback.

## Constraints
- Do not comment on formatting if a linter handles it
- Do not suggest refactoring that changes public API
  without flagging it as a breaking change
- Limit review to 5 highest-priority items. If there are more,
  note "X additional minor issues not listed" at the bottom.

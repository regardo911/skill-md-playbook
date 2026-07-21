---
name: commit-messages
description: "Use this skill when creating git commits or drafting commit messages. Enforces conventional-commits format (type(scope): description), 72-char limit, imperative mood, and a forbidden-phrase list."
---

<!-- commit-messages - Chapter 3, the alternative first skill. Pick this one instead of code-style if you don't write code. -->

# Commit Messages

## Trigger
When creating commits or suggesting commit messages.

## Instructions
- Format: type(scope): description
- Types allowed: feat, fix, refactor, test, docs, chore
- Scope: module or feature area in lowercase (auth, api, ui)
- Description: imperative mood, lowercase start, no period
- Maximum 72 characters total in subject line
- If body needed: blank line after subject, explain WHY not WHAT

## Constraints
- Forbidden commit messages: "update", "fix", "changes",
  "misc", "WIP", "various improvements", "minor fixes"
- Never list individual files in the subject line

## Example
Bad: Updated some stuff in the auth module
Good: fix(auth): reject tokens with expired refresh claims

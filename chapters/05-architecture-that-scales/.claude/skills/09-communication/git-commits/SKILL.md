---
name: git-commits
description: Use this skill when creating git commits or drafting commit messages. Enforces conventional-commits format with type, scope, imperative-mood description, 72-char subject limit, and a forbidden-message list ("update", "fix", "WIP", "various improvements", etc.).
---

<!-- git-commits - Chapter 4, moved into 09-communication/ by the Chapter 5 migration. -->

# Git Commits

## Trigger
When creating commits or writing commit messages.

## Instructions
- Format: conventional commits
  type(scope): short description
- Types: feat, fix, refactor, test, docs, chore, perf
- Scope: the module or feature area (e.g., auth, api, ui)
- Description: imperative mood, lowercase, no period, max 72 chars
- Body (if needed): blank line after subject, wrap at 72 chars,
  explain WHY not WHAT

## Constraints
- Never use these as commit messages:
  "update", "fix", "changes", "misc", "various improvements",
  "minor fixes", "WIP"
- Never include file lists in the commit subject line
- If the change touches more than 3 unrelated areas, split it
  into separate commits

## Example
Bad: Updated user stuff and fixed some bugs
Good: fix(auth): reject expired refresh tokens on renewal

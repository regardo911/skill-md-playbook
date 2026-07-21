---
name: commit-messages
description: Use this skill when creating git commits or drafting commit messages. Enforces conventional-commits format, lowercase imperative subjects under 72 characters, a banned-subject list, and why-not-what commit bodies.
---

# Commit Messages

## Trigger
When creating commits or drafting commit messages.

## Instructions
- type(scope): description
- feat, fix, refactor, test, docs, chore
- Lowercase, imperative, no trailing period, 72 chars
- Body explains why. The diff already shows what

## Constraints
- Banned subjects: update, fix, changes, misc, WIP

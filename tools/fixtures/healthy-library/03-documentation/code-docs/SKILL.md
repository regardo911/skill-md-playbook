---
name: code-docs
description: Use this skill when writing or modifying source files. Controls where JSDoc is required (exported symbols), which tags are mandatory, what to skip, and the why-not-what rule for inline comments.
---

# Code Docs

## Trigger
When writing or modifying source files.

## Instructions
- JSDoc on anything exported. @param and @returns required, @throws when it can throw
- Skip private helpers. Skip getters
- Inline comments explain why, not what

## Constraints
- If the comment restates the line, delete the comment

---
name: code-conventions
description: Use this skill when writing or editing TypeScript source files in this project. Enforces 2-space indent, single quotes, no semicolons, named exports only, and the three-group import order.
---

# Code Conventions

## Trigger
Always active for TypeScript source files.

## Instructions
- 2 space indent
- No semicolons anywhere. Prettier is configured with semi: false
- Arrow functions everywhere, including module scope
- Single quotes
- Import order: packages, then @/ aliases, then relative. Blank line between groups
- Named exports only

## Constraints
- No default exports. The last one went in the router refactor and it is not coming back

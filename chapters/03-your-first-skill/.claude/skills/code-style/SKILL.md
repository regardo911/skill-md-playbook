---
name: code-style
description: Use this skill when writing or editing TypeScript source files in this project. Enforces 2-space indent, single quotes, named exports, no semicolons, kebab-case filenames, and import-group ordering.
---

<!-- code-style - Chapter 3. Enforces the project's formatting rules on every code-generation request. -->

# Code Style

## Trigger
Always active for TypeScript source files in this project.

## Instructions
- Use TypeScript with strict mode enabled
- Use 2-space indentation, no tabs
- Use single quotes for strings
- Add trailing commas in multi-line objects and arrays
- Use arrow functions for callbacks and inline functions
- Use named exports, not default exports
- Import order: external packages first, then internal modules,
  then relative imports, with a blank line between each group
- File names use kebab-case (e.g., user-service.ts, not UserService.ts)

## Constraints
- Never use the `any` type. Use `unknown` if the type is truly unknown.
- Do not use `var`. Use `const` by default, `let` only when reassignment
  is necessary.
- Do not add semicolons. This project uses no-semicolon style.

## Example
Bad:
  import { UserService } from "./UserService";
  var data: any = await fetch(url);

Good:
  import { z } from 'zod'

  import { createUser } from '../models/user'
  import { validate } from './helpers/validation'

  const data: unknown = await fetch(url)

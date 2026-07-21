---
name: unit-tests
description: Use this skill when writing or modifying unit test files. Enforces Vitest, one mirrored test file per source file, describe/it structure, and specific-value assertions over truthiness.
paths:
  - "tests/**/*.ts"
  - "**/*.test.ts"
---

# Unit Tests

## Trigger
When writing or modifying test files.

## Instructions
- Vitest. Import from 'vitest'
- One test file per source file, mirrored under tests/
- describe() per exported function, it() per case
- Assert on values, never on truthiness
- Mock the network layer, nothing else

## Constraints
- Do not import from 'jest' or '@jest/globals'

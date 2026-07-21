---
name: testing
description: Use this skill when writing or modifying test files in this project. Enforces Vitest as the framework, file-path mirroring (src/x.ts → tests/x.test.ts), describe/it structure, three minimum tests per function, and specific-value assertions over truthiness.
paths:
  - "**/*.test.ts"
  - "**/*.test.tsx"
  - "tests/**/*.ts"
---

<!-- testing - Chapter 4, skill 2 of 5. Swap Vitest for your framework; the structure applies universally. -->

# Testing Standards

## Trigger
When writing or modifying test files.

## Instructions
- Framework: Vitest (import from 'vitest', not 'jest')
- Test file location: mirror source path
  src/utils/format.ts → tests/utils/format.test.ts
- Structure: describe() grouped by function, it() for each case
- Naming: it('should [expected behavior] when [condition]')
- Each function gets minimum 3 tests:
  1. Happy path with typical input
  2. Error/edge case (null, empty, boundary values)
  3. Integration behavior (how it interacts with dependencies)
- Mock external dependencies with vi.mock()
- Never mock the function being tested
- Assert on specific values, not truthiness
  Bad: expect(result).toBeTruthy()
  Good: expect(result).toBe('validated')
- Use test.each() for parameterized tests with 3+ similar cases

## Constraints
- Do not import from 'jest' or '@jest/globals'
- Do not use snapshot tests unless explicitly asked
- Do not test private functions directly; test them through
  the public API
